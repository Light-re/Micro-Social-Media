package com.frattoninteractive.pulse.comment;

import com.frattoninteractive.pulse.comment.dto.CommentResponse;
import com.frattoninteractive.pulse.comment.dto.CreateCommentRequest;
import com.frattoninteractive.pulse.moderation.ContentModerationService;
import com.frattoninteractive.pulse.post.Post;
import com.frattoninteractive.pulse.post.PostService;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final PostService postService;
    private final UserService userService;
    private final ContentModerationService moderationService;

    @Override
    public CommentResponse createComment(String authorId, String postId, CreateCommentRequest request) {
        String content = request.content().trim();
        moderationService.moderateText(content);

        Post post = postService.requirePost(postId);
        User author = userService.findById(authorId);

        Comment comment = commentRepository.save(Comment.builder()
                .postId(postId)
                .authorId(authorId)
                .authorUsername(author.getUsername())
                .content(content)
                .createdAt(Instant.now())
                .build());

        post.setCommentCount(post.getCommentCount() + 1);
        postService.save(post);

        return toResponse(comment);
    }

    @Override
    public List<CommentResponse> getComments(String postId) {
        postService.requirePost(postId);
        return commentRepository.findByPostIdOrderByCreatedAtAsc(postId).stream()
                .map(this::toResponse)
                .toList();
    }

    private CommentResponse toResponse(Comment comment) {
        return new CommentResponse(
                comment.getId(),
                comment.getPostId(),
                comment.getAuthorId(),
                comment.getAuthorUsername(),
                comment.getContent(),
                comment.getCreatedAt()
        );
    }
}
