package com.frattoninteractive.pulse.auth;

import com.frattoninteractive.pulse.auth.dto.AuthResponse;
import com.frattoninteractive.pulse.auth.dto.LoginRequest;
import com.frattoninteractive.pulse.auth.dto.RegisterRequest;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class AuthServiceTest {

    private UserService userService;
    private PasswordEncoder passwordEncoder;
    private JwtUtil jwtUtil;
    private AuthService authService;

    @BeforeEach
    void setUp() {
        userService = mock(UserService.class);
        passwordEncoder = mock(PasswordEncoder.class);
        jwtUtil = mock(JwtUtil.class);
        authService = new AuthService(userService, passwordEncoder, jwtUtil);
    }

    @Test
    void register_returnsTokenForNewUser() {
        RegisterRequest request = new RegisterRequest("dev@pulse.test", "devuser", "password123");
        User user = user("user-1", "dev@pulse.test", "devuser", "hash");
        when(userService.register(request)).thenReturn(user);
        when(jwtUtil.generateToken("user-1", "dev@pulse.test")).thenReturn("jwt-token");

        AuthResponse response = authService.register(request);

        assertThat(response.token()).isEqualTo("jwt-token");
        assertThat(response.userId()).isEqualTo("user-1");
        assertThat(response.email()).isEqualTo("dev@pulse.test");
        assertThat(response.username()).isEqualTo("devuser");
    }

    @Test
    void login_withValidPassword_returnsToken() {
        LoginRequest request = new LoginRequest(" DEV@PULSE.TEST ", "password123");
        User user = user("user-1", "dev@pulse.test", "devuser", "stored-hash");
        when(userService.findByEmail("dev@pulse.test")).thenReturn(user);
        when(passwordEncoder.matches("password123", "stored-hash")).thenReturn(true);
        when(jwtUtil.generateToken("user-1", "dev@pulse.test")).thenReturn("jwt-token");

        AuthResponse response = authService.login(request);

        assertThat(response.token()).isEqualTo("jwt-token");
        verify(userService).findByEmail("dev@pulse.test");
    }

    @Test
    void login_withWrongPassword_throwsBadCredentials() {
        LoginRequest request = new LoginRequest("dev@pulse.test", "wrong-password");
        User user = user("user-1", "dev@pulse.test", "devuser", "stored-hash");
        when(userService.findByEmail("dev@pulse.test")).thenReturn(user);
        when(passwordEncoder.matches("wrong-password", "stored-hash")).thenReturn(false);

        assertThatThrownBy(() -> authService.login(request))
                .isInstanceOf(BadCredentialsException.class)
                .hasMessage("Invalid credentials");
    }

    private static User user(String id, String email, String username, String passwordHash) {
        return User.builder()
                .id(id)
                .email(email)
                .username(username)
                .passwordHash(passwordHash)
                .build();
    }
}
