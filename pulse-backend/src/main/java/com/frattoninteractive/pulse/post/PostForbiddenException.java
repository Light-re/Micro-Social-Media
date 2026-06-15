package com.frattoninteractive.pulse.post;

public class PostForbiddenException extends RuntimeException {

    public PostForbiddenException(String postId) {
        super("Not allowed to modify post: " + postId);
    }
}
