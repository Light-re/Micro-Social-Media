package com.frattoninteractive.pulse.comment.dto;

import java.time.Instant;

public record CommentResponse(
        String id,
        String postId,
        String authorId,
        String authorUsername,
        String content,
        Instant createdAt
) {
}
