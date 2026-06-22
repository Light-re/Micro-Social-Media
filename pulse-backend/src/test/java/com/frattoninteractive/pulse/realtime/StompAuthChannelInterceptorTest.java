package com.frattoninteractive.pulse.realtime;

import com.frattoninteractive.pulse.auth.JwtUtil;
import org.junit.jupiter.api.Test;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageDeliveryException;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.messaging.support.MessageHeaderAccessor;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.mock;

class StompAuthChannelInterceptorTest {

    private final JwtUtil jwtUtil =
            new JwtUtil("test-jwt-secret-at-least-32-characters-long", 86400000L);
    private final StompAuthChannelInterceptor interceptor =
            new StompAuthChannelInterceptor(jwtUtil);
    private final MessageChannel channel = mock(MessageChannel.class);

    @Test
    void preSend_authenticatesConnectWithValidToken() {
        String token = jwtUtil.generateToken("user-1", "dev@pulse.test");
        Message<byte[]> message = connectMessage("Bearer " + token);

        Message<?> result = interceptor.preSend(message, channel);

        StompHeaderAccessor out =
                MessageHeaderAccessor.getAccessor(result, StompHeaderAccessor.class);
        assertThat(out).isNotNull();
        assertThat(out.getUser()).isNotNull();
        assertThat(out.getUser().getName()).isNotNull();
    }

    @Test
    void preSend_rejectsConnectWithoutAuthorizationHeader() {
        Message<byte[]> message = connectMessage(null);

        assertThatThrownBy(() -> interceptor.preSend(message, channel))
                .isInstanceOf(MessageDeliveryException.class);
    }

    @Test
    void preSend_rejectsConnectWithInvalidToken() {
        Message<byte[]> message = connectMessage("Bearer not-a-real-token");

        assertThatThrownBy(() -> interceptor.preSend(message, channel))
                .isInstanceOf(MessageDeliveryException.class);
    }

    private Message<byte[]> connectMessage(String authorizationValue) {
        StompHeaderAccessor accessor = StompHeaderAccessor.create(StompCommand.CONNECT);
        if (authorizationValue != null) {
            accessor.addNativeHeader("Authorization", authorizationValue);
        }
        accessor.setLeaveMutable(true);
        return MessageBuilder.createMessage(new byte[0], accessor.getMessageHeaders());
    }
}
