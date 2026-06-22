package com.frattoninteractive.pulse.seed;

import com.frattoninteractive.pulse.auth.dto.RegisterRequest;
import com.frattoninteractive.pulse.post.PostRepository;
import com.frattoninteractive.pulse.post.PostService;
import com.frattoninteractive.pulse.post.dto.CreatePostRequest;
import com.frattoninteractive.pulse.user.User;
import com.frattoninteractive.pulse.user.UserRepository;
import com.frattoninteractive.pulse.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Seeds a handful of demo users and posts on a fresh database so the feed is
 * not empty during local development. Idempotent: only runs when both
 * collections are empty. Disabled under the {@code test} profile.
 */
@Component
@Profile("!test")
@RequiredArgsConstructor
public class DemoDataSeeder implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PostRepository postRepository;
    private final UserService userService;
    private final PostService postService;

    @Override
    public void run(String... args) {
        if (userRepository.count() > 0 || postRepository.count() > 0) {
            return;
        }
        demoUsers().forEach(this::seedUser);
    }

    private void seedUser(DemoUser demo) {
        User user = userService.register(
                new RegisterRequest(demo.email(), demo.username(), demo.password()));
        demo.posts().forEach(content ->
                postService.createPost(user.getId(), new CreatePostRequest(content)));
    }

    private List<DemoUser> demoUsers() {
        return List.of(
                new DemoUser("mara@pulse.dev", "mara", "demo-pass-1", List.of(
                        "Guten Morgen, Pulse! Erster Beitrag des Tages.",
                        "Heute beim Sonnenaufgang joggen war einfach grossartig.")),
                new DemoUser("jonas@pulse.dev", "jonas", "demo-pass-2", List.of(
                        "Endlich das M335-Projekt am Laufen. Flutter macht Spass.",
                        "Wer hat Tipps fuer guten Kaffee in Zuerich?")),
                new DemoUser("lea@pulse.dev", "lea", "demo-pass-3", List.of(
                        "Neues Wochenende, neue Wanderung in den Alpen.",
                        "Live-Feed funktioniert jetzt in Echtzeit!")));
    }

    private record DemoUser(String email, String username, String password, List<String> posts) {
    }
}
