package com.frattoninteractive.pulse.post;

import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.post.dto.FeedResponse;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostRepository postRepository;
    private final UserService userService;

    @Override
    public PostResponse createPost(String authorId, CreatePostRequest request) {
        User author = userService.findById(authorId);

        Post post = Post.builder()
                .authorId(authorId)
                .authorUsername(author.getUsername())
                .content(request.content().trim())
                .createdAt(Instant.now())
                .build();

        Post saved = postRepository.save(post);
        return toResponse(saved);
    }

    @Override
    public FeedResponse getFeed() {
        return new FeedResponse(
                postRepository.findAllByOrderByCreatedAtDesc().stream()
                        .map(this::toResponse)
                        .toList()
        );
    }

    @Override
    public void deleteOwnPost(String authorId, String postId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new PostNotFoundException(postId));

        if (!post.getAuthorId().equals(authorId)) {
            throw new PostForbiddenException(postId);
        }

        postRepository.delete(post);
    }

    private PostResponse toResponse(Post post) {
        return new PostResponse(
                post.getId(),
                post.getAuthorId(),
                post.getAuthorUsername(),
                post.getContent(),
                post.getCreatedAt(),
                post.getLikeCount(),
                post.getCommentCount()
        );
    }
}
