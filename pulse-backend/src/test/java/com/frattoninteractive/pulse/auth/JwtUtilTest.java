package com.frattoninteractive.pulse.auth;

import io.jsonwebtoken.Claims;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class JwtUtilTest {

    @Test
    void generateToken_createsParsableTokenWithUserClaims() {
        JwtUtil jwtUtil = new JwtUtil("test-jwt-secret-at-least-32-characters-long", 60_000);

        String token = jwtUtil.generateToken("user-1", "dev@pulse.test");
        Claims claims = jwtUtil.parseToken(token);

        assertThat(jwtUtil.getUserId(claims)).isEqualTo("user-1");
        assertThat(jwtUtil.getEmail(claims)).isEqualTo("dev@pulse.test");
        assertThat(claims.getSubject()).isEqualTo("user-1");
        assertThat(claims.getExpiration()).isAfter(claims.getIssuedAt());
    }

    @Test
    void constructor_withShortSecret_throwsIllegalArgumentException() {
        assertThatThrownBy(() -> new JwtUtil("too-short", 60_000))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("JWT_SECRET must be at least 32 characters");
    }
}
