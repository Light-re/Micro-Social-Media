package com.frattoninteractive.pulse.user;

import com.frattoninteractive.pulse.auth.dto.RegisterRequest;
import com.frattoninteractive.pulse.config.DuplicateResourceException;
import com.frattoninteractive.pulse.user.dto.UpdateProfileRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public User register(RegisterRequest request) {
        if (userRepository.existsByEmailIgnoreCase(request.email())) {
            throw new DuplicateResourceException("Email is already registered");
        }
        if (userRepository.existsByUsernameIgnoreCase(request.username())) {
            throw new DuplicateResourceException("Username is already taken");
        }

        User user = User.builder()
                .email(request.email().trim().toLowerCase())
                .username(request.username().trim())
                .passwordHash(passwordEncoder.encode(request.password()))
                .bio("")
                .createdAt(Instant.now())
                .build();

        return userRepository.save(user);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmailIgnoreCase(email)
                .orElseThrow(() -> new org.springframework.security.authentication.BadCredentialsException("Invalid credentials"));
    }

    public User findById(String id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new org.springframework.security.authentication.BadCredentialsException("User not found"));
    }

    public User updateProfile(String userId, UpdateProfileRequest request) {
        User user = findById(userId);
        String newUsername = request.username().trim();

        if (!newUsername.equalsIgnoreCase(user.getUsername())
                && userRepository.existsByUsernameIgnoreCaseAndIdNot(newUsername, userId)) {
            throw new DuplicateResourceException("Username is already taken");
        }

        user.setUsername(newUsername);
        user.setBio(request.bio() == null ? "" : request.bio().trim());
        return userRepository.save(user);
    }
}
