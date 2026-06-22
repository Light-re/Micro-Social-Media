package com.frattoninteractive.pulse.comment;

import com.frattoninteractive.pulse.auth.JwtAuthenticationFilter;
import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.auth.JwtUtil;
import com.frattoninteractive.pulse.auth.SecurityConfig;
import com.frattoninteractive.pulse.comment.dto.CommentResponse;
import com.frattoninteractive.pulse.comment.dto.CreateCommentRequest;
import com.frattoninteractive.pulse.config.GlobalExceptionHandler;
import com.frattoninteractive.pulse.post.PostNotFoundException;
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
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.authentication;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = CommentController.class)
@Import({SecurityConfig.class, JwtUtil.class, JwtAuthenticationFilter.class, GlobalExceptionHandler.class})
@TestPropertySource(properties = {
        "jwt.secret=test-jwt-secret-at-least-32-characters-long",
        "jwt.expiration-ms=86400000"
})
class CommentControllerWebMvcTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private CommentService commentService;

    @Test
    void createComment_returnsCreatedComment() throws Exception {
        when(commentService.createComment(eq("user-1"), eq("post-1"), any(CreateCommentRequest.class))).thenReturn(
                new CommentResponse("comment-1", "post-1", "user-1", "devuser", "Hi", Instant.parse("2026-06-15T10:00:00Z"))
        );

        mockMvc.perform(post("/api/posts/post-1/comments")
                        .with(authentication(authenticatedUser("user-1")))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"content\":\"Hi\"}"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.id").value("comment-1"))
                .andExpect(jsonPath("$.content").value("Hi"));
    }

    @Test
    void createComment_returnsBadRequestWhenContentBlank() throws Exception {
        mockMvc.perform(post("/api/posts/post-1/comments")
                        .with(authentication(authenticatedUser("user-1")))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"content\":\"   \"}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    void createComment_returnsBadRequestWhenContentTooLong() throws Exception {
        String tooLong = "a".repeat(501);

        mockMvc.perform(post("/api/posts/post-1/comments")
                        .with(authentication(authenticatedUser("user-1")))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"content\":\"" + tooLong + "\"}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    void getComments_returnsCommentsOldestFirst() throws Exception {
        when(commentService.getComments("post-1")).thenReturn(List.of(
                new CommentResponse("c1", "post-1", "user-1", "devuser", "first", Instant.parse("2026-06-15T10:00:00Z")),
                new CommentResponse("c2", "post-1", "user-2", "other", "second", Instant.parse("2026-06-15T12:00:00Z"))
        ));

        mockMvc.perform(get("/api/posts/post-1/comments")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(jsonPath("$[0].id").value("c1"));
    }

    @Test
    void getComments_returnsNotFoundWhenPostMissing() throws Exception {
        when(commentService.getComments("missing")).thenThrow(new PostNotFoundException("missing"));

        mockMvc.perform(get("/api/posts/missing/comments")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isNotFound());
    }

    private UsernamePasswordAuthenticationToken authenticatedUser(String userId) {
        JwtPrincipal principal = new JwtPrincipal(userId, "dev@pulse.test");
        return new UsernamePasswordAuthenticationToken(principal, null, List.of());
    }
}
