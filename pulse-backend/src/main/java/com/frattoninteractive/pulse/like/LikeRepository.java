package com.frattoninteractive.pulse.like;

import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface LikeRepository extends MongoRepository<Like, String> {

    boolean existsByPostIdAndUserId(String postId, String userId);

    Optional<Like> findByPostIdAndUserId(String postId, String userId);

    void deleteByPostIdAndUserId(String postId, String userId);

    long countByPostId(String postId);

    List<Like> findByUserIdAndPostIdIn(String userId, Collection<String> postIds);
}
