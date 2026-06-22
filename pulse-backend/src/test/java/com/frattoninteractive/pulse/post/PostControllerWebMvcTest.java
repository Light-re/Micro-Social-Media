package com.frattoninteractive.pulse.post;

import com.frattoninteractive.pulse.auth.JwtAuthenticationFilter;
import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.auth.JwtUtil;
import com.frattoninteractive.pulse.auth.SecurityConfig;
import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.post.dto.FeedResponse;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.authentication;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = PostController.class)
@Import({SecurityConfig.class, JwtUtil.class, JwtAuthenticationFilter.class})
@TestPropertySource(properties = {
        "jwt.secret=test-jwt-secret-at-least-32-characters-long",
        "jwt.expiration-ms=86400000"
})
class PostControllerWebMvcTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private PostService postService;

    @Test
    void createPost_returnsCreatedPost() throws Exception {
        when(postService.createPost(eq("user-1"), any(CreatePostRequest.class))).thenReturn(
                new PostResponse("post-1", "user-1", "devuser", "Hello", Instant.parse("2026-06-15T10:00:00Z"), 0, 0, false)
        );

        mockMvc.perform(post("/api/posts")
                        .with(authentication(authenticatedUser("user-1")))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"content\":\"Hello\"}"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.id").value("post-1"))
                .andExpect(jsonPath("$.authorUsername").value("devuser"));
    }

    @Test
    void getFeed_returnsSortedPosts() throws Exception {
        when(postService.getFeed("user-1")).thenReturn(new FeedResponse(List.of(
                new PostResponse("post-2", "user-1", "devuser", "new", Instant.parse("2026-06-15T12:00:00Z"), 1, 0, true),
                new PostResponse("post-1", "user-1", "devuser", "old", Instant.parse("2026-06-15T10:00:00Z"), 0, 2, false)
        )));

        mockMvc.perform(get("/api/posts/feed")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.posts.length()").value(2))
                .andExpect(jsonPath("$.posts[0].id").value("post-2"));
    }

    @Test
    void deleteOwnPost_returnsNoContent() throws Exception {
        mockMvc.perform(delete("/api/posts/post-1")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isNoContent());

        verify(postService).deleteOwnPost("user-1", "post-1");
    }

    private UsernamePasswordAuthenticationToken authenticatedUser(String userId) {
        JwtPrincipal principal = new JwtPrincipal(userId, "dev@pulse.test");
        return new UsernamePasswordAuthenticationToken(principal, null, List.of());
    }
}
