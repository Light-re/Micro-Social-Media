package com.frattoninteractive.pulse.user;

import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.user.dto.UpdateProfileRequest;
import com.frattoninteractive.pulse.user.dto.UserMeResponse;
import org.junit.jupiter.api.Test;
import org.springframework.http.ResponseEntity;

import java.time.Instant;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class UserControllerTest {

    @Test
    void me_returnsAuthenticatedUserProfile() {
        UserService userService = mock(UserService.class);
        Instant createdAt = Instant.parse("2026-01-01T10:00:00Z");
        User user = User.builder()
                .id("user-1")
                .email("dev@pulse.test")
                .username("devuser")
                .bio("Hello world")
                .createdAt(createdAt)
                .build();
        when(userService.findById("user-1")).thenReturn(user);
        UserController controller = new UserController(userService);

        ResponseEntity<UserMeResponse> response = controller.me(new JwtPrincipal("user-1", "dev@pulse.test"));

        assertThat(response.getStatusCode().value()).isEqualTo(200);
        assertThat(response.getBody()).isEqualTo(
                new UserMeResponse("user-1", "dev@pulse.test", "devuser", "Hello world", createdAt));
        verify(userService).findById("user-1");
    }

    @Test
    void updateMe_returnsUpdatedProfile() {
        UserService userService = mock(UserService.class);
        Instant createdAt = Instant.parse("2026-01-01T10:00:00Z");
        User user = User.builder()
                .id("user-1")
                .email("dev@pulse.test")
                .username("newname")
                .bio("Updated bio")
                .createdAt(createdAt)
                .build();
        when(userService.updateProfile("user-1", new UpdateProfileRequest("newname", "Updated bio")))
                .thenReturn(user);
        UserController controller = new UserController(userService);

        ResponseEntity<UserMeResponse> response = controller.updateMe(
                new JwtPrincipal("user-1", "dev@pulse.test"),
                new UpdateProfileRequest("newname", "Updated bio"));

        assertThat(response.getStatusCode().value()).isEqualTo(200);
        assertThat(response.getBody()).isEqualTo(
                new UserMeResponse("user-1", "dev@pulse.test", "newname", "Updated bio", createdAt));
        verify(userService).updateProfile("user-1", new UpdateProfileRequest("newname", "Updated bio"));
    }
}
