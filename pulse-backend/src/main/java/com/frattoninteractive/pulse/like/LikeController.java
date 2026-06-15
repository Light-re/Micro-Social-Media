package com.frattoninteractive.pulse.like;

import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/posts/{postId}/like")
@RequiredArgsConstructor
public class LikeController {

    private final LikeService likeService;

    @PostMapping
    public PostResponse like(
            @AuthenticationPrincipal JwtPrincipal principal,
            @PathVariable String postId
    ) {
        return likeService.like(principal.userId(), postId);
    }

    @DeleteMapping
    public PostResponse unlike(
            @AuthenticationPrincipal JwtPrincipal principal,
            @PathVariable String postId
    ) {
        return likeService.unlike(principal.userId(), postId);
    }
}
