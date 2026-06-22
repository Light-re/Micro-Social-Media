package com.frattoninteractive.pulse.like;

import com.frattoninteractive.pulse.post.dto.PostResponse;

public interface LikeService {

    PostResponse like(String userId, String postId);

    PostResponse unlike(String userId, String postId);
}
