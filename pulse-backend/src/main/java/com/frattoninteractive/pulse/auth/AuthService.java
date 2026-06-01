package com.frattoninteractive.pulse.auth;

import com.frattoninteractive.pulse.auth.dto.AuthResponse;
import com.frattoninteractive.pulse.auth.dto.LoginRequest;
import com.frattoninteractive.pulse.auth.dto.RegisterRequest;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    public AuthResponse register(RegisterRequest request) {
        User user = userService.register(request);
        return buildAuthResponse(user);
    }

    public AuthResponse login(LoginRequest request) {
        User user = userService.findByEmail(request.getEmail().trim().toLowerCase());
        if (!passwordEncoder.matches(request.getPassword(), user.getPasswordHash())) {
            throw new BadCredentialsException("Invalid credentials");
        }
        return buildAuthResponse(user);
    }

    private AuthResponse buildAuthResponse(User user) {
        String token = jwtUtil.generateToken(user.getId(), user.getEmail());
        return AuthResponse.builder()
                .token(token)
                .userId(user.getId())
                .email(user.getEmail())
                .username(user.getUsername())
                .build();
    }
}
