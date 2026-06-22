package com.frattoninteractive.pulse.like;

import com.frattoninteractive.pulse.post.Post;
import com.frattoninteractive.pulse.post.PostNotFoundException;
import com.frattoninteractive.pulse.post.PostService;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.Instant;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class LikeServiceTest {

    private LikeRepository likeRepository;
    private PostService postService;
    private LikeService likeService;

    @BeforeEach
    void setUp() {
        likeRepository = mock(LikeRepository.class);
        postService = mock(PostService.class);
        likeService = new LikeServiceImpl(likeRepository, postService);
    }

    @Test
    void like_createsLikeAndIncrementsCountWhenNotLikedYet() {
        Post post = postWithLikes(0);
        when(postService.requirePost("post-1")).thenReturn(post);
        when(likeRepository.existsByPostIdAndUserId("post-1", "user-1")).thenReturn(false);
        when(postService.toResponse(post, "user-1")).thenReturn(response(1, true));

        PostResponse response = likeService.like("user-1", "post-1");

        verify(likeRepository).save(any(Like.class));
        verify(postService).save(post);
        assertThat(post.getLikeCount()).isEqualTo(1);
        assertThat(response.likedByMe()).isTrue();
    }

    @Test
    void like_allowsUserToLikeOwnPost() {
        Post post = postWithAuthorAndLikes("user-1", 0);
        when(postService.requirePost("post-1")).thenReturn(post);
        when(likeRepository.existsByPostIdAndUserId("post-1", "user-1")).thenReturn(false);
        when(postService.toResponse(post, "user-1")).thenReturn(response(1, true));

        PostResponse response = likeService.like("user-1", "post-1");

        verify(likeRepository).save(any(Like.class));
        verify(postService).save(post);
        assertThat(post.getLikeCount()).isEqualTo(1);
        assertThat(response.likedByMe()).isTrue();
    }

    @Test
    void like_isIdempotentWhenAlreadyLiked() {
        Post post = postWithLikes(5);
        when(postService.requirePost("post-1")).thenReturn(post);
        when(likeRepository.existsByPostIdAndUserId("post-1", "user-1")).thenReturn(true);

        likeService.like("user-1", "post-1");

        verify(likeRepository, never()).save(any(Like.class));
        verify(postService, never()).save(any());
        assertThat(post.getLikeCount()).isEqualTo(5);
    }

    @Test
    void unlike_removesLikeAndDecrementsCountWhenLiked() {
        Post post = postWithLikes(3);
        when(postService.requirePost("post-1")).thenReturn(post);
        when(likeRepository.existsByPostIdAndUserId("post-1", "user-1")).thenReturn(true);

        likeService.unlike("user-1", "post-1");

        verify(likeRepository).deleteByPostIdAndUserId("post-1", "user-1");
        verify(postService).save(post);
        assertThat(post.getLikeCount()).isEqualTo(2);
    }

    @Test
    void unlike_doesNothingAndNeverGoesNegativeWhenNotLiked() {
        Post post = postWithLikes(0);
        when(postService.requirePost("post-1")).thenReturn(post);
        when(likeRepository.existsByPostIdAndUserId("post-1", "user-1")).thenReturn(false);

        likeService.unlike("user-1", "post-1");

        verify(likeRepository, never()).deleteByPostIdAndUserId(any(), any());
        verify(postService, never()).save(any());
        assertThat(post.getLikeCount()).isZero();
    }

    @Test
    void like_throwsWhenPostMissing() {
        when(postService.requirePost("missing")).thenThrow(new PostNotFoundException("missing"));

        assertThatThrownBy(() -> likeService.like("user-1", "missing"))
                .isInstanceOf(PostNotFoundException.class);

        verify(likeRepository, never()).save(any(Like.class));
    }

    private Post postWithLikes(long likeCount) {
        return postWithAuthorAndLikes("u1", likeCount);
    }

    private Post postWithAuthorAndLikes(String authorId, long likeCount) {
        return Post.builder().id("post-1").authorId(authorId).likeCount(likeCount).build();
    }

    private PostResponse response(long likeCount, boolean likedByMe) {
        return new PostResponse("post-1", "u1", "devuser", "x",
                Instant.parse("2026-06-15T10:00:00Z"), likeCount, 0, likedByMe);
    }
}
