package com.frattoninteractive.pulse.comment;

import com.frattoninteractive.pulse.comment.dto.CommentResponse;
import com.frattoninteractive.pulse.comment.dto.CreateCommentRequest;
import com.frattoninteractive.pulse.moderation.ContentModerationException;
import com.frattoninteractive.pulse.moderation.ContentModerationService;
import com.frattoninteractive.pulse.post.Post;
import com.frattoninteractive.pulse.post.PostNotFoundException;
import com.frattoninteractive.pulse.post.PostService;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.Instant;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class CommentServiceTest {

    private CommentRepository commentRepository;
    private PostService postService;
    private UserService userService;
    private ContentModerationService moderationService;
    private CommentService commentService;

    @BeforeEach
    void setUp() {
        commentRepository = mock(CommentRepository.class);
        postService = mock(PostService.class);
        userService = mock(UserService.class);
        moderationService = mock(ContentModerationService.class);
        commentService = new CommentServiceImpl(commentRepository, postService, userService, moderationService);
    }

    @Test
    void createComment_trimsContentAndIncrementsCommentCount() {
        Post post = Post.builder().id("post-1").commentCount(0).build();
        when(postService.requirePost("post-1")).thenReturn(post);
        when(userService.findById("user-1")).thenReturn(User.builder()
                .id("user-1").username("devuser").build());
        when(commentRepository.save(any(Comment.class))).thenAnswer(invocation -> {
            Comment comment = invocation.getArgument(0);
            comment.setId("comment-1");
            return comment;
        });

        CommentResponse response = commentService.createComment(
                "user-1", "post-1", new CreateCommentRequest("  Nice post  "));

        verify(moderationService).moderateText("Nice post");
        assertThat(response.id()).isEqualTo("comment-1");
        assertThat(response.content()).isEqualTo("Nice post");
        assertThat(response.authorUsername()).isEqualTo("devuser");
        assertThat(post.getCommentCount()).isEqualTo(1);
        verify(postService).save(post);
    }

    @Test
    void getComments_returnsCommentsOldestFirst() {
        Instant older = Instant.parse("2026-06-15T10:00:00Z");
        Instant newer = Instant.parse("2026-06-15T12:00:00Z");
        when(postService.requirePost("post-1")).thenReturn(Post.builder().id("post-1").build());
        when(commentRepository.findByPostIdOrderByCreatedAtAsc("post-1")).thenReturn(List.of(
                Comment.builder().id("c1").postId("post-1").content("first").createdAt(older).build(),
                Comment.builder().id("c2").postId("post-1").content("second").createdAt(newer).build()
        ));

        List<CommentResponse> comments = commentService.getComments("post-1");

        assertThat(comments).hasSize(2);
        assertThat(comments.getFirst().id()).isEqualTo("c1");
        assertThat(comments.getLast().id()).isEqualTo("c2");
    }

    @Test
    void createComment_throwsWhenPostMissing() {
        when(postService.requirePost("missing")).thenThrow(new PostNotFoundException("missing"));

        assertThatThrownBy(() -> commentService.createComment(
                "user-1", "missing", new CreateCommentRequest("hi")))
                .isInstanceOf(PostNotFoundException.class);

        verify(commentRepository, never()).save(any());
    }

    @Test
    void createComment_rejectsFlaggedContentBeforeLoadingPost() {
        org.mockito.Mockito.doThrow(new ContentModerationException(List.of("violence")))
                .when(moderationService).moderateText("blocked");

        assertThatThrownBy(() -> commentService.createComment(
                "user-1", "post-1", new CreateCommentRequest(" blocked ")))
                .isInstanceOf(ContentModerationException.class);

        verify(postService, never()).requirePost(any());
        verify(commentRepository, never()).save(any());
    }
}
