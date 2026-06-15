package com.frattoninteractive.pulse.like;

import com.frattoninteractive.pulse.auth.JwtAuthenticationFilter;
import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.auth.JwtUtil;
import com.frattoninteractive.pulse.auth.SecurityConfig;
import com.frattoninteractive.pulse.config.GlobalExceptionHandler;
import com.frattoninteractive.pulse.post.PostNotFoundException;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;

import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.authentication;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = LikeController.class)
@Import({SecurityConfig.class, JwtUtil.class, JwtAuthenticationFilter.class, GlobalExceptionHandler.class})
@TestPropertySource(properties = {
        "jwt.secret=test-jwt-secret-at-least-32-characters-long",
        "jwt.expiration-ms=86400000"
})
class LikeControllerWebMvcTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private LikeService likeService;

    @Test
    void like_returnsUpdatedPost() throws Exception {
        when(likeService.like("user-1", "post-1")).thenReturn(
                new PostResponse("post-1", "author", "devuser", "Hi", Instant.parse("2026-06-15T10:00:00Z"), 1, 0, true)
        );

        mockMvc.perform(post("/api/posts/post-1/like")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.likeCount").value(1))
                .andExpect(jsonPath("$.likedByMe").value(true));
    }

    @Test
    void unlike_returnsUpdatedPost() throws Exception {
        when(likeService.unlike("user-1", "post-1")).thenReturn(
                new PostResponse("post-1", "author", "devuser", "Hi", Instant.parse("2026-06-15T10:00:00Z"), 0, 0, false)
        );

        mockMvc.perform(delete("/api/posts/post-1/like")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.likeCount").value(0))
                .andExpect(jsonPath("$.likedByMe").value(false));
    }

    @Test
    void like_returnsNotFoundWhenPostMissing() throws Exception {
        when(likeService.like("user-1", "missing")).thenThrow(new PostNotFoundException("missing"));

        mockMvc.perform(post("/api/posts/missing/like")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isNotFound());
    }

    private UsernamePasswordAuthenticationToken authenticatedUser(String userId) {
        JwtPrincipal principal = new JwtPrincipal(userId, "dev@pulse.test");
        return new UsernamePasswordAuthenticationToken(principal, null, List.of());
    }
}
