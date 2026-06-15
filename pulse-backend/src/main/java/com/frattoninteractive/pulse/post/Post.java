package com.frattoninteractive.pulse.post;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "posts")
public class Post {

    @Id
    private String id;

    @Indexed
    private String authorId;

    private String authorUsername;

    private String content;

    @Indexed
    private Instant createdAt;

    @Builder.Default
    private long likeCount = 0;

    @Builder.Default
    private long commentCount = 0;
}
