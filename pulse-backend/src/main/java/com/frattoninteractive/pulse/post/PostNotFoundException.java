package com.frattoninteractive.pulse.post;

public class PostNotFoundException extends RuntimeException {

    public PostNotFoundException(String postId) {
        super("Post not found: " + postId);
    }
}
