package com.frattoninteractive.pulse.moderation;

import java.util.List;

public class ContentModerationException extends RuntimeException {

    private final List<String> categories;

    public ContentModerationException(List<String> categories) {
        super("Content was rejected by moderation.");
        this.categories = List.copyOf(categories);
    }

    public List<String> getCategories() {
        return categories;
    }
}
