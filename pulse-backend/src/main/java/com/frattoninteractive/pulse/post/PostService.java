package com.frattoninteractive.pulse.post;

import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.post.dto.FeedResponse;
import com.frattoninteractive.pulse.post.dto.PostResponse;

public interface PostService {

    PostResponse createPost(String authorId, CreatePostRequest request);

    FeedResponse getFeed(String currentUserId);

    void deleteOwnPost(String authorId, String postId);

    Post requirePost(String postId);

    Post save(Post post);

    PostResponse toResponse(Post post, String currentUserId);
}
