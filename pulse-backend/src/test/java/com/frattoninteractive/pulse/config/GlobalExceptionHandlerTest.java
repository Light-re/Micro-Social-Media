package com.frattoninteractive.pulse.config;

import com.frattoninteractive.pulse.moderation.ContentModerationException;
import com.frattoninteractive.pulse.moderation.ModerationUnavailableException;
import com.frattoninteractive.pulse.post.PostForbiddenException;
import com.frattoninteractive.pulse.post.PostNotFoundException;
import org.junit.jupiter.api.Test;
import org.springframework.http.ProblemDetail;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;

import java.util.Map;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class GlobalExceptionHandlerTest {

    private final GlobalExceptionHandler handler = new GlobalExceptionHandler();

    @Test
    @SuppressWarnings("unchecked")
    void handleValidation_returnsFirstMessageAsDetail() {
        BeanPropertyBindingResult bindingResult =
                new BeanPropertyBindingResult(new Object(), "createPostRequest");
        bindingResult.addError(new FieldError("createPostRequest", "content", "Content is required"));
        MethodArgumentNotValidException ex = mock(MethodArgumentNotValidException.class);
        when(ex.getBindingResult()).thenReturn(bindingResult);

        ProblemDetail detail = handler.handleValidation(ex);

        assertThat(detail.getStatus()).isEqualTo(400);
        assertThat(detail.getTitle()).isEqualTo("Validation failed");
        assertThat(detail.getDetail()).isEqualTo("Content is required");
        Map<String, String> errors =
                (Map<String, String>) detail.getProperties().get("errors");
        assertThat(errors).containsEntry("content", "Content is required");
    }

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

    @Test
    @SuppressWarnings("unchecked")
    void handleContentModeration_returnsRejectedProblem() {
        ProblemDetail detail = handler.handleContentModeration(
                new ContentModerationException(List.of("hate", "violence")));

        assertThat(detail.getStatus()).isEqualTo(422);
        assertThat(detail.getTitle()).isEqualTo("Content rejected");
        assertThat((List<String>) detail.getProperties().get("categories"))
                .containsExactly("hate", "violence");
    }

    @Test
    void handleModerationUnavailable_returnsServiceUnavailableProblem() {
        ProblemDetail detail = handler.handleModerationUnavailable(
                new ModerationUnavailableException("Moderation service is currently unavailable.", null));

        assertThat(detail.getStatus()).isEqualTo(503);
        assertThat(detail.getTitle()).isEqualTo("Moderation unavailable");
    }
}
