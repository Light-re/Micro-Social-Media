package com.frattoninteractive.pulse.post.dto;

import java.util.List;

public record FeedResponse(
        List<PostResponse> posts
) {
}
