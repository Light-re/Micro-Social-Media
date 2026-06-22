package com.frattoninteractive.pulse.post;

import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.post.dto.FeedResponse;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/posts")
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public PostResponse createPost(
            @AuthenticationPrincipal JwtPrincipal principal,
            @Valid @RequestBody CreatePostRequest request
    ) {
        return postService.createPost(principal.userId(), request);
    }

    @GetMapping("/feed")
    public FeedResponse getFeed(@AuthenticationPrincipal JwtPrincipal principal) {
        return postService.getFeed(principal.userId());
    }

    @GetMapping("/me")
    public FeedResponse getMyPosts(@AuthenticationPrincipal JwtPrincipal principal) {
        return postService.getPostsByAuthor(principal.userId(), principal.userId());
    }

    @DeleteMapping("/{postId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteOwnPost(
            @AuthenticationPrincipal JwtPrincipal principal,
            @PathVariable String postId
    ) {
        postService.deleteOwnPost(principal.userId(), postId);
    }
}
