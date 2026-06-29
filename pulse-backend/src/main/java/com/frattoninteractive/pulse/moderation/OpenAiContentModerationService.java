package com.frattoninteractive.pulse.moderation;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class OpenAiContentModerationService implements ContentModerationService {

    private final RestClient.Builder restClientBuilder;

    @Value("${openai.api-key:}")
    private String apiKey;

    @Value("${openai.moderation.enabled:true}")
    private boolean enabled;

    @Value("${openai.moderation.base-url:https://api.openai.com/v1}")
    private String baseUrl;

    @Value("${openai.moderation.model:omni-moderation-latest}")
    private String model;

    @Override
    public void moderateText(String content) {
        if (!enabled || !StringUtils.hasText(apiKey) || !StringUtils.hasText(content)) {
            return;
        }

        OpenAiModerationResponse response = requestModeration(content.trim());
        OpenAiModerationResult result = response.firstResult();
        if (result != null && result.flagged()) {
            throw new ContentModerationException(result.flaggedCategories());
        }
    }

    private OpenAiModerationResponse requestModeration(String content) {
        try {
            return restClientBuilder
                    .baseUrl(baseUrl)
                    .build()
                    .post()
                    .uri("/moderations")
                    .header(HttpHeaders.AUTHORIZATION, "Bearer " + apiKey)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(new OpenAiModerationRequest(model, content))
                    .retrieve()
                    .body(OpenAiModerationResponse.class);
        } catch (RestClientException ex) {
            throw new ModerationUnavailableException("Moderation service is currently unavailable.", ex);
        }
    }

    record OpenAiModerationRequest(String model, String input) {
    }

    record OpenAiModerationResponse(List<OpenAiModerationResult> results) {

        OpenAiModerationResult firstResult() {
            if (results == null || results.isEmpty()) {
                return null;
            }
            return results.getFirst();
        }
    }

    record OpenAiModerationResult(
            boolean flagged,
            Map<String, Boolean> categories,
            @JsonProperty("category_scores") Map<String, Double> categoryScores
    ) {

        List<String> flaggedCategories() {
            if (categories == null) {
                return List.of();
            }
            return categories.entrySet().stream()
                    .filter(Map.Entry::getValue)
                    .map(Map.Entry::getKey)
                    .sorted()
                    .toList();
        }
    }
}
