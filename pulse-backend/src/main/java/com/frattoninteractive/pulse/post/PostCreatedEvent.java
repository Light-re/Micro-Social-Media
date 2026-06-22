package com.frattoninteractive.pulse.post;

import com.frattoninteractive.pulse.post.dto.PostResponse;

/**
 * Domain event published when a new post is persisted, so listeners (such as
 * the realtime broadcaster) can react without coupling to the post service.
 */
public record PostCreatedEvent(PostResponse post) {
}
