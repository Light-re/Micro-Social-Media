package com.frattoninteractive.pulse.post;

import com.frattoninteractive.pulse.like.Like;
import com.frattoninteractive.pulse.like.LikeRepository;
import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.post.dto.FeedResponse;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class PostServiceTest {

    private PostRepository postRepository;
    private UserService userService;
    private LikeRepository likeRepository;
    private PostService postService;

    @BeforeEach
    void setUp() {
        postRepository = mock(PostRepository.class);
        userService = mock(UserService.class);
        likeRepository = mock(LikeRepository.class);
        postService = new PostServiceImpl(postRepository, userService, likeRepository);
    }

    @Test
    void createPost_trimsContentAndStoresAuthorUsername() {
        when(userService.findById("user-1")).thenReturn(User.builder()
                .id("user-1")
                .username("devuser")
                .email("dev@pulse.test")
                .build());
        when(postRepository.save(any(Post.class))).thenAnswer(invocation -> {
            Post post = invocation.getArgument(0);
            post.setId("post-1");
            return post;
        });

        PostResponse response = postService.createPost(
                "user-1",
                new CreatePostRequest("  Hello Pulse  ")
        );

        assertThat(response.id()).isEqualTo("post-1");
        assertThat(response.authorUsername()).isEqualTo("devuser");
        assertThat(response.content()).isEqualTo("Hello Pulse");
        assertThat(response.likedByMe()).isFalse();
    }

    @Test
    void getFeed_returnsPostsWithLikedByMeForCurrentUser() {
        Instant newer = Instant.parse("2026-06-15T12:00:00Z");
        Instant older = Instant.parse("2026-06-15T10:00:00Z");
        when(postRepository.findAllByOrderByCreatedAtDesc()).thenReturn(List.of(
                Post.builder().id("p2").authorId("u1").authorUsername("devuser").content("new").createdAt(newer).build(),
                Post.builder().id("p1").authorId("u1").authorUsername("devuser").content("old").createdAt(older).build()
        ));
        when(likeRepository.findByUserIdAndPostIdIn(eq("user-1"), any())).thenReturn(List.of(
                Like.builder().id("like-1").postId("p2").userId("user-1").build()
        ));

        FeedResponse feed = postService.getFeed("user-1");

        assertThat(feed.posts()).hasSize(2);
        assertThat(feed.posts().getFirst().id()).isEqualTo("p2");
        assertThat(feed.posts().getFirst().likedByMe()).isTrue();
        assertThat(feed.posts().getLast().id()).isEqualTo("p1");
        assertThat(feed.posts().getLast().likedByMe()).isFalse();
    }

    @Test
    void deleteOwnPost_deletesWhenAuthorMatches() {
        Post post = Post.builder().id("post-1").authorId("user-1").content("x").build();
        when(postRepository.findById("post-1")).thenReturn(Optional.of(post));

        postService.deleteOwnPost("user-1", "post-1");

        verify(postRepository).delete(post);
    }

    @Test
    void deleteOwnPost_throwsWhenAuthorDoesNotMatch() {
        Post post = Post.builder().id("post-1").authorId("other-user").content("x").build();
        when(postRepository.findById("post-1")).thenReturn(Optional.of(post));

        assertThatThrownBy(() -> postService.deleteOwnPost("user-1", "post-1"))
                .isInstanceOf(PostForbiddenException.class);

        verify(postRepository, never()).delete(any());
    }

    @Test
    void requirePost_throwsWhenMissing() {
        when(postRepository.findById("missing")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> postService.requirePost("missing"))
                .isInstanceOf(PostNotFoundException.class);
    }
}
