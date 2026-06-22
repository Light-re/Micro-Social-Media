package com.frattoninteractive.pulse.realtime;

import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.auth.JwtUtil;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageDeliveryException;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Authenticates the STOMP {@code CONNECT} frame with the same JWT used by the
 * REST API. The Flutter client sends {@code Authorization: Bearer <token>} in
 * the connect headers; an invalid or missing token rejects the connection.
 */
@Component
@RequiredArgsConstructor
public class StompAuthChannelInterceptor implements ChannelInterceptor {

    private final JwtUtil jwtUtil;

    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor =
                MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
        if (accessor != null && StompCommand.CONNECT.equals(accessor.getCommand())) {
            accessor.setUser(authenticate(accessor));
        }
        return message;
    }

    private UsernamePasswordAuthenticationToken authenticate(StompHeaderAccessor accessor) {
        String token = bearerToken(accessor);
        try {
            Claims claims = jwtUtil.parseToken(token);
            JwtPrincipal principal =
                    new JwtPrincipal(jwtUtil.getUserId(claims), jwtUtil.getEmail(claims));
            return new UsernamePasswordAuthenticationToken(principal, null, List.of());
        } catch (JwtException | IllegalArgumentException ex) {
            throw new MessageDeliveryException("Invalid or missing JWT on STOMP CONNECT");
        }
    }

    private String bearerToken(StompHeaderAccessor accessor) {
        List<String> headers = accessor.getNativeHeader(HttpHeaders.AUTHORIZATION);
        if (headers == null || headers.isEmpty()) {
            throw new MessageDeliveryException("Missing Authorization header on STOMP CONNECT");
        }
        String value = headers.getFirst();
        if (value == null || !value.startsWith("Bearer ")) {
            throw new MessageDeliveryException("Malformed Authorization header on STOMP CONNECT");
        }
        return value.substring(7);
    }
}
