package com.frattoninteractive.pulse.comment;

import com.frattoninteractive.pulse.comment.dto.CommentResponse;
import com.frattoninteractive.pulse.comment.dto.CreateCommentRequest;

import java.util.List;

public interface CommentService {

    CommentResponse createComment(String authorId, String postId, CreateCommentRequest request);

    List<CommentResponse> getComments(String postId);
}
