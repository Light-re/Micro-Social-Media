package com.frattoninteractive.pulse.user;

import com.frattoninteractive.pulse.auth.JwtAuthenticationFilter;
import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.auth.JwtUtil;
import com.frattoninteractive.pulse.auth.SecurityConfig;
import com.frattoninteractive.pulse.config.GlobalExceptionHandler;
import com.frattoninteractive.pulse.user.dto.UpdateProfileRequest;
import com.frattoninteractive.pulse.user.dto.UserMeResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.authentication;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = UserController.class)
@Import({SecurityConfig.class, GlobalExceptionHandler.class, JwtUtil.class, JwtAuthenticationFilter.class})
@TestPropertySource(properties = {
        "jwt.secret=test-jwt-secret-at-least-32-characters-long",
        "jwt.expiration-ms=86400000"
})
class UserControllerWebMvcTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private UserService userService;

    @Test
    void me_withoutJwt_isRejected() throws Exception {
        mockMvc.perform(get("/api/users/me"))
                .andExpect(status().isForbidden());
    }

    @Test
    void me_withJwt_returnsProfile() throws Exception {
        when(userService.findById("user-1")).thenReturn(User.builder()
                .id("user-1")
                .email("dev@pulse.test")
                .username("devuser")
                .bio("My bio")
                .createdAt(Instant.parse("2026-01-01T10:00:00Z"))
                .build());

        mockMvc.perform(get("/api/users/me")
                        .with(authentication(authenticatedUser("user-1"))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.username").value("devuser"))
                .andExpect(jsonPath("$.bio").value("My bio"));
    }

    @Test
    void updateMe_withJwt_returnsUpdatedProfile() throws Exception {
        when(userService.updateProfile(eq("user-1"), any(UpdateProfileRequest.class))).thenReturn(User.builder()
                .id("user-1")
                .email("dev@pulse.test")
                .username("newname")
                .bio("Updated bio")
                .createdAt(Instant.parse("2026-01-01T10:00:00Z"))
                .build());

        mockMvc.perform(put("/api/users/me")
                        .with(authentication(authenticatedUser("user-1")))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"username":"newname","bio":"Updated bio"}
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.username").value("newname"))
                .andExpect(jsonPath("$.bio").value("Updated bio"));

        verify(userService).updateProfile(eq("user-1"), any(UpdateProfileRequest.class));
    }

    @Test
    void updateMe_invalidPayload_returnsBadRequest() throws Exception {
        mockMvc.perform(put("/api/users/me")
                        .with(authentication(authenticatedUser("user-1")))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"username":"ab","bio":"Updated bio"}
                                """))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.title").value("Validation failed"));
    }

    private UsernamePasswordAuthenticationToken authenticatedUser(String userId) {
        JwtPrincipal principal = new JwtPrincipal(userId, "dev@pulse.test");
        return new UsernamePasswordAuthenticationToken(principal, null, List.of());
    }
}
