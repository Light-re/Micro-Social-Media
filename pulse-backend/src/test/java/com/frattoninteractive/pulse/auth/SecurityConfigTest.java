package com.frattoninteractive.pulse.auth;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;

class SecurityConfigTest {

    @Test
    void passwordEncoder_returnsBcryptEncoder() {
        SecurityConfig securityConfig = new SecurityConfig(mock(JwtAuthenticationFilter.class));

        PasswordEncoder encoder = securityConfig.passwordEncoder();

        String hash = encoder.encode("password123");
        assertThat(hash).startsWith("$2");
        assertThat(encoder.matches("password123", hash)).isTrue();
    }
}
