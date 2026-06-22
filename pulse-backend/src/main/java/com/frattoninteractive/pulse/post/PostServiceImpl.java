package com.frattoninteractive.pulse.post;

import com.frattoninteractive.pulse.like.Like;
import com.frattoninteractive.pulse.like.LikeRepository;
import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.post.dto.FeedResponse;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostRepository postRepository;
    private final UserService userService;
    private final LikeRepository likeRepository;
    private final ApplicationEventPublisher eventPublisher;

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
        PostResponse response = toResponse(saved, authorId);
        eventPublisher.publishEvent(new PostCreatedEvent(response));
        return response;
    }

    @Override
    public FeedResponse getFeed(String currentUserId) {
        return toFeed(postRepository.findAllByOrderByCreatedAtDesc(), currentUserId);
    }

    @Override
    public FeedResponse getPostsByAuthor(String currentUserId, String authorId) {
        return toFeed(postRepository.findByAuthorIdOrderByCreatedAtDesc(authorId), currentUserId);
    }

    private FeedResponse toFeed(List<Post> posts, String currentUserId) {
        Set<String> likedPostIds = likedPostIds(currentUserId, posts);
        return new FeedResponse(posts.stream()
                .map(post -> toResponse(post, likedPostIds.contains(post.getId())))
                .toList());
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

    @Override
    public Post requirePost(String postId) {
        return postRepository.findById(postId)
                .orElseThrow(() -> new PostNotFoundException(postId));
    }

    @Override
    public Post save(Post post) {
        return postRepository.save(post);
    }

    @Override
    public PostResponse toResponse(Post post, String currentUserId) {
        boolean likedByMe = currentUserId != null
                && likeRepository.existsByPostIdAndUserId(post.getId(), currentUserId);
        return toResponse(post, likedByMe);
    }

    private Set<String> likedPostIds(String currentUserId, List<Post> posts) {
        if (currentUserId == null || posts.isEmpty()) {
            return Set.of();
        }
        List<String> postIds = posts.stream().map(Post::getId).toList();
        return likeRepository.findByUserIdAndPostIdIn(currentUserId, postIds).stream()
                .map(Like::getPostId)
                .collect(Collectors.toSet());
    }

    private PostResponse toResponse(Post post, boolean likedByMe) {
        return new PostResponse(
                post.getId(),
                post.getAuthorId(),
                post.getAuthorUsername(),
                post.getContent(),
                post.getCreatedAt(),
                post.getLikeCount(),
                post.getCommentCount(),
                likedByMe
        );
    }
}
