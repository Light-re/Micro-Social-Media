package com.frattoninteractive.pulse.post.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CreatePostRequest(
        @NotBlank(message = "Content is required")
        @Size(max = 500, message = "Content must be at most 500 characters")
        String content
) {
}
