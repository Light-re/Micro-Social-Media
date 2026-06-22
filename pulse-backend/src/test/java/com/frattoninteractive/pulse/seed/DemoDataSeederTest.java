package com.frattoninteractive.pulse.seed;

import com.frattoninteractive.pulse.auth.dto.RegisterRequest;
import com.frattoninteractive.pulse.post.PostRepository;
import com.frattoninteractive.pulse.post.PostService;
import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserRepository;
import com.frattoninteractive.pulse.user.UserService;
import org.junit.jupiter.api.Test;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.atLeastOnce;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

class DemoDataSeederTest {

    private final UserRepository userRepository = mock(UserRepository.class);
    private final PostRepository postRepository = mock(PostRepository.class);
    private final UserService userService = mock(UserService.class);
    private final PostService postService = mock(PostService.class);
    private final DemoDataSeeder seeder =
            new DemoDataSeeder(userRepository, postRepository, userService, postService);

    @Test
    void run_seedsUsersAndPostsWhenDatabaseIsEmpty() {
        when(userRepository.count()).thenReturn(0L);
        when(postRepository.count()).thenReturn(0L);
        when(userService.register(any(RegisterRequest.class)))
                .thenReturn(User.builder().id("user-1").username("demo").build());

        seeder.run();

        verify(userService, atLeastOnce()).register(any(RegisterRequest.class));
        verify(postService, atLeastOnce()).createPost(anyString(), any(CreatePostRequest.class));
    }

    @Test
    void run_skipsSeedingWhenUsersAlreadyExist() {
        when(userRepository.count()).thenReturn(3L);

        seeder.run();

        verifyNoInteractions(userService);
        verifyNoInteractions(postService);
    }
}
