package com.frattoninteractive.pulse.user.dto;

import lombok.Builder;
import lombok.Value;

import java.time.Instant;

@Value
@Builder
public class UserMeResponse {
    String id;
    String email;
    String username;
    Instant createdAt;
}
