package com.frattoninteractive.pulse.user;

import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.user.dto.UpdateProfileRequest;
import com.frattoninteractive.pulse.user.dto.UserMeResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/me")
    public ResponseEntity<UserMeResponse> me(@AuthenticationPrincipal JwtPrincipal principal) {
        User user = userService.findById(principal.userId());
        return ResponseEntity.ok(toResponse(user));
    }

    @PutMapping("/me")
    public ResponseEntity<UserMeResponse> updateMe(
            @AuthenticationPrincipal JwtPrincipal principal,
            @Valid @RequestBody UpdateProfileRequest request) {
        User user = userService.updateProfile(principal.userId(), request);
        return ResponseEntity.ok(toResponse(user));
    }

    private UserMeResponse toResponse(User user) {
        return new UserMeResponse(
                user.getId(),
                user.getEmail(),
                user.getUsername(),
                user.getBio() == null ? "" : user.getBio(),
                user.getCreatedAt());
    }
}
