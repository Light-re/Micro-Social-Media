package com.frattoninteractive.pulse.config;

import com.frattoninteractive.pulse.post.PostForbiddenException;
import com.frattoninteractive.pulse.post.PostNotFoundException;
import com.frattoninteractive.pulse.moderation.ContentModerationException;
import com.frattoninteractive.pulse.moderation.ModerationUnavailableException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ProblemDetail handleValidation(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        for (FieldError fieldError : ex.getBindingResult().getFieldErrors()) {
            errors.putIfAbsent(fieldError.getField(), fieldError.getDefaultMessage());
        }
        ProblemDetail detail = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
        detail.setTitle("Validation failed");
        detail.setDetail(firstMessage(errors));
        detail.setProperty("errors", errors);
        return detail;
    }

    private String firstMessage(Map<String, String> errors) {
        return errors.values().stream()
                .findFirst()
                .orElse("Please check your input and try again.");
    }

    @ExceptionHandler(DuplicateResourceException.class)
    public ProblemDetail handleDuplicate(DuplicateResourceException ex) {
        ProblemDetail detail = ProblemDetail.forStatus(HttpStatus.CONFLICT);
        detail.setTitle("Conflict");
        detail.setDetail(ex.getMessage());
        return detail;
    }

    @ExceptionHandler(BadCredentialsException.class)
    public ProblemDetail handleBadCredentials(BadCredentialsException ex) {
        ProblemDetail detail = ProblemDetail.forStatus(HttpStatus.UNAUTHORIZED);
        detail.setTitle("Unauthorized");
        detail.setDetail(ex.getMessage());
        return detail;
    }

    @ExceptionHandler(PostNotFoundException.class)
    public ProblemDetail handlePostNotFound(PostNotFoundException ex) {
        ProblemDetail detail = ProblemDetail.forStatus(HttpStatus.NOT_FOUND);
        detail.setTitle("Not found");
        detail.setDetail(ex.getMessage());
        return detail;
    }

    @ExceptionHandler(PostForbiddenException.class)
    public ProblemDetail handlePostForbidden(PostForbiddenException ex) {
        ProblemDetail detail = ProblemDetail.forStatus(HttpStatus.FORBIDDEN);
        detail.setTitle("Forbidden");
        detail.setDetail(ex.getMessage());
        return detail;
    }

    @ExceptionHandler(ContentModerationException.class)
    public ProblemDetail handleContentModeration(ContentModerationException ex) {
        ProblemDetail detail = ProblemDetail.forStatus(HttpStatus.UNPROCESSABLE_ENTITY);
        detail.setTitle("Content rejected");
        detail.setDetail("Your post or comment violates the content policy.");
        detail.setProperty("categories", ex.getCategories());
        return detail;
    }

    @ExceptionHandler(ModerationUnavailableException.class)
    public ProblemDetail handleModerationUnavailable(ModerationUnavailableException ex) {
        ProblemDetail detail = ProblemDetail.forStatus(HttpStatus.SERVICE_UNAVAILABLE);
        detail.setTitle("Moderation unavailable");
        detail.setDetail(ex.getMessage());
        return detail;
    }
}
