package com.frattoninteractive.pulse.realtime;

import com.frattoninteractive.pulse.post.PostCreatedEvent;
import lombok.RequiredArgsConstructor;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

/**
 * Pushes newly created posts to subscribers of {@code /topic/posts} so other
 * users see them in their feed without reloading (live feed).
 */
@Component
@RequiredArgsConstructor
public class PostBroadcaster {

    static final String POSTS_TOPIC = "/topic/posts";

    private final SimpMessagingTemplate messagingTemplate;

    @EventListener
    public void onPostCreated(PostCreatedEvent event) {
        messagingTemplate.convertAndSend(POSTS_TOPIC, event.post());
    }
}
