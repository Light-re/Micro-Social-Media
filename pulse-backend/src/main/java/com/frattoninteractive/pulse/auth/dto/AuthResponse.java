package com.frattoninteractive.pulse.auth.dto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AuthResponse {
    String token;
    String userId;
    String email;
    String username;
}
