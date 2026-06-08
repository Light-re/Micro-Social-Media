package com.frattoninteractive.pulse.user;

import com.frattoninteractive.pulse.auth.JwtPrincipal;
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
                .createdAt(createdAt)
                .build();
        when(userService.findById("user-1")).thenReturn(user);
        UserController controller = new UserController(userService);

        ResponseEntity<UserMeResponse> response = controller.me(new JwtPrincipal("user-1", "dev@pulse.test"));

        assertThat(response.getStatusCode().value()).isEqualTo(200);
        assertThat(response.getBody()).isEqualTo(
                new UserMeResponse("user-1", "dev@pulse.test", "devuser", createdAt));
        verify(userService).findById("user-1");
    }
}
