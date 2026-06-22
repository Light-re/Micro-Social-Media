package com.frattoninteractive.pulse.realtime;

import org.junit.jupiter.api.Test;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.StompWebSocketEndpointRegistration;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class WebSocketConfigTest {

    private final StompAuthChannelInterceptor interceptor =
            mock(StompAuthChannelInterceptor.class);
    private final WebSocketConfig config = new WebSocketConfig(interceptor);

    @Test
    void registerStompEndpoints_exposesWsEndpoint() {
        StompEndpointRegistry registry = mock(StompEndpointRegistry.class);
        StompWebSocketEndpointRegistration registration =
                mock(StompWebSocketEndpointRegistration.class);
        when(registry.addEndpoint("/ws")).thenReturn(registration);
        when(registration.setAllowedOriginPatterns(any())).thenReturn(registration);

        config.registerStompEndpoints(registry);

        verify(registry).addEndpoint("/ws");
        verify(registration).setAllowedOriginPatterns("*");
    }

    @Test
    void configureMessageBroker_enablesTopicBroker() {
        MessageBrokerRegistry registry = mock(MessageBrokerRegistry.class);

        config.configureMessageBroker(registry);

        verify(registry).enableSimpleBroker("/topic");
        verify(registry).setApplicationDestinationPrefixes("/app");
    }

    @Test
    void configureClientInboundChannel_registersAuthInterceptor() {
        ChannelRegistration registration = mock(ChannelRegistration.class);

        config.configureClientInboundChannel(registration);

        verify(registration).interceptors(interceptor);
    }
}
