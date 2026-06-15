package com.frattoninteractive.pulse.post.dto;

import java.time.Instant;

public record PostResponse(
        String id,
        String authorId,
        String authorUsername,
        String content,
        Instant createdAt,
        long likeCount,
        long commentCount
) {
}
