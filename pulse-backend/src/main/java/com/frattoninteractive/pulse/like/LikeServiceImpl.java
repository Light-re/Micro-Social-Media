package com.frattoninteractive.pulse.like;

import com.frattoninteractive.pulse.post.Post;
import com.frattoninteractive.pulse.post.PostService;
import com.frattoninteractive.pulse.post.dto.PostResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
@RequiredArgsConstructor
public class LikeServiceImpl implements LikeService {

    private final LikeRepository likeRepository;
    private final PostService postService;

    @Override
    public PostResponse like(String userId, String postId) {
        Post post = postService.requirePost(postId);
        if (!likeRepository.existsByPostIdAndUserId(postId, userId)) {
            likeRepository.save(Like.builder()
                    .postId(postId)
                    .userId(userId)
                    .createdAt(Instant.now())
                    .build());
            post.setLikeCount(post.getLikeCount() + 1);
            postService.save(post);
        }
        return postService.toResponse(post, userId);
    }

    @Override
    public PostResponse unlike(String userId, String postId) {
        Post post = postService.requirePost(postId);
        if (likeRepository.existsByPostIdAndUserId(postId, userId)) {
            likeRepository.deleteByPostIdAndUserId(postId, userId);
            post.setLikeCount(Math.max(0, post.getLikeCount() - 1));
            postService.save(post);
        }
        return postService.toResponse(post, userId);
    }
}
