package com.frattoninteractive.pulse.user.dto;

import java.time.Instant;

public record UserMeResponse(
        String id,
        String email,
        String username,
        String bio,
        Instant createdAt
) {
}
