package com.frattoninteractive.pulse.user;

import com.frattoninteractive.pulse.auth.dto.RegisterRequest;
import com.frattoninteractive.pulse.config.DuplicateResourceException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class UserServiceTest {

    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    private UserService userService;

    @BeforeEach
    void setUp() {
        userRepository = mock(UserRepository.class);
        passwordEncoder = mock(PasswordEncoder.class);
        userService = new UserService(userRepository, passwordEncoder);
    }

    @Test
    void register_withUniqueUser_normalizesAndStoresUser() {
        RegisterRequest request = new RegisterRequest(" DEV@PULSE.TEST ", " devuser ", "password123");
        when(userRepository.existsByEmailIgnoreCase(" DEV@PULSE.TEST ")).thenReturn(false);
        when(userRepository.existsByUsernameIgnoreCase(" devuser ")).thenReturn(false);
        when(passwordEncoder.encode("password123")).thenReturn("password-hash");
        when(userRepository.save(org.mockito.ArgumentMatchers.any(User.class))).thenAnswer(invocation -> {
            User user = invocation.getArgument(0);
            user.setId("user-1");
            return user;
        });

        User user = userService.register(request);

        assertThat(user.getId()).isEqualTo("user-1");
        assertThat(user.getEmail()).isEqualTo("dev@pulse.test");
        assertThat(user.getUsername()).isEqualTo("devuser");
        assertThat(user.getPasswordHash()).isEqualTo("password-hash");
        assertThat(user.getCreatedAt()).isNotNull();

        ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);
        verify(userRepository).save(captor.capture());
        assertThat(captor.getValue().getEmail()).isEqualTo("dev@pulse.test");
    }

    @Test
    void register_withDuplicateEmail_throwsDuplicateResourceException() {
        RegisterRequest request = new RegisterRequest("dev@pulse.test", "devuser", "password123");
        when(userRepository.existsByEmailIgnoreCase("dev@pulse.test")).thenReturn(true);

        assertThatThrownBy(() -> userService.register(request))
                .isInstanceOf(DuplicateResourceException.class)
                .hasMessage("Email is already registered");
    }

    @Test
    void register_withDuplicateUsername_throwsDuplicateResourceException() {
        RegisterRequest request = new RegisterRequest("dev@pulse.test", "devuser", "password123");
        when(userRepository.existsByEmailIgnoreCase("dev@pulse.test")).thenReturn(false);
        when(userRepository.existsByUsernameIgnoreCase("devuser")).thenReturn(true);

        assertThatThrownBy(() -> userService.register(request))
                .isInstanceOf(DuplicateResourceException.class)
                .hasMessage("Username is already taken");
    }

    @Test
    void findByEmail_whenUserExists_returnsUser() {
        User user = User.builder().id("user-1").email("dev@pulse.test").build();
        when(userRepository.findByEmailIgnoreCase("dev@pulse.test")).thenReturn(Optional.of(user));

        assertThat(userService.findByEmail("dev@pulse.test")).isSameAs(user);
    }

    @Test
    void findByEmail_whenMissing_throwsBadCredentials() {
        when(userRepository.findByEmailIgnoreCase("missing@pulse.test")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> userService.findByEmail("missing@pulse.test"))
                .isInstanceOf(BadCredentialsException.class)
                .hasMessage("Invalid credentials");
    }

    @Test
    void findById_whenUserExists_returnsUser() {
        User user = User.builder().id("user-1").email("dev@pulse.test").build();
        when(userRepository.findById("user-1")).thenReturn(Optional.of(user));

        assertThat(userService.findById("user-1")).isSameAs(user);
    }

    @Test
    void findById_whenMissing_throwsBadCredentials() {
        when(userRepository.findById("missing")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> userService.findById("missing"))
                .isInstanceOf(BadCredentialsException.class)
                .hasMessage("User not found");
    }
}
