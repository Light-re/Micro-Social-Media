package com.frattoninteractive.pulse.config;

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
}
