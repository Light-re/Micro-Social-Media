package com.frattoninteractive.pulse.comment;

import com.frattoninteractive.pulse.auth.JwtPrincipal;
import com.frattoninteractive.pulse.comment.dto.CommentResponse;
import com.frattoninteractive.pulse.comment.dto.CreateCommentRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/posts/{postId}/comments")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @GetMapping
    public List<CommentResponse> getComments(@PathVariable String postId) {
        return commentService.getComments(postId);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public CommentResponse createComment(
            @AuthenticationPrincipal JwtPrincipal principal,
            @PathVariable String postId,
            @Valid @RequestBody CreateCommentRequest request
    ) {
        return commentService.createComment(principal.userId(), postId, request);
    }
}
