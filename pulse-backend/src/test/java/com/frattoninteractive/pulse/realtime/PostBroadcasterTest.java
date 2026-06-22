package com.frattoninteractive.pulse.realtime;

import com.frattoninteractive.pulse.post.PostCreatedEvent;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import org.junit.jupiter.api.Test;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import java.time.Instant;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

class PostBroadcasterTest {

    private final SimpMessagingTemplate messagingTemplate = mock(SimpMessagingTemplate.class);
    private final PostBroadcaster broadcaster = new PostBroadcaster(messagingTemplate);

    @Test
    void onPostCreated_sendsPostToPostsTopic() {
        PostResponse post = new PostResponse(
                "post-1", "user-1", "devuser", "Live!",
                Instant.parse("2026-06-15T10:00:00Z"), 0, 0, false);

        broadcaster.onPostCreated(new PostCreatedEvent(post));

        verify(messagingTemplate).convertAndSend("/topic/posts", post);
    }
}
