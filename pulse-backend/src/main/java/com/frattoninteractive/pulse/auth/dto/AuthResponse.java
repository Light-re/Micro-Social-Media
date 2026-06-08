package com.frattoninteractive.pulse.auth.dto;

public record AuthResponse(
        String token,
        String userId,
        String email,
        String username
) {
}
