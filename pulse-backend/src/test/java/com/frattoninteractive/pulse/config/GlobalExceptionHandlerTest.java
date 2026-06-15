package com.frattoninteractive.pulse.config;

import com.frattoninteractive.pulse.post.PostForbiddenException;
import com.frattoninteractive.pulse.post.PostNotFoundException;
import org.junit.jupiter.api.Test;
import org.springframework.http.ProblemDetail;
import org.springframework.security.authentication.BadCredentialsException;

import static org.assertj.core.api.Assertions.assertThat;

class GlobalExceptionHandlerTest {

    private final GlobalExceptionHandler handler = new GlobalExceptionHandler();

    @Test
    void handleDuplicate_returnsConflictProblem() {
        ProblemDetail detail = handler.handleDuplicate(new DuplicateResourceException("Email is already registered"));

        assertThat(detail.getStatus()).isEqualTo(409);
        assertThat(detail.getTitle()).isEqualTo("Conflict");
        assertThat(detail.getDetail()).isEqualTo("Email is already registered");
    }

    @Test
    void handleBadCredentials_returnsUnauthorizedProblem() {
        ProblemDetail detail = handler.handleBadCredentials(new BadCredentialsException("Invalid credentials"));

        assertThat(detail.getStatus()).isEqualTo(401);
        assertThat(detail.getTitle()).isEqualTo("Unauthorized");
        assertThat(detail.getDetail()).isEqualTo("Invalid credentials");
    }

    @Test
    void handlePostNotFound_returnsNotFoundProblem() {
        ProblemDetail detail = handler.handlePostNotFound(new PostNotFoundException("post-1"));

        assertThat(detail.getStatus()).isEqualTo(404);
        assertThat(detail.getDetail()).contains("post-1");
    }

    @Test
    void handlePostForbidden_returnsForbiddenProblem() {
        ProblemDetail detail = handler.handlePostForbidden(new PostForbiddenException("post-1"));

        assertThat(detail.getStatus()).isEqualTo(403);
        assertThat(detail.getDetail()).contains("post-1");
    }
}
