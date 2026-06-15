package com.frattoninteractive.pulse.user.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UpdateProfileRequest(
        @NotBlank
        @Size(min = 3, max = 30)
        String username,

        @Size(max = 500)
        String bio
) {
}
