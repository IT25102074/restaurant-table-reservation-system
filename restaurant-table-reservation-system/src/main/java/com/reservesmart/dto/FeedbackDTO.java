package com.reservesmart.dto;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * DTO for transferring Feedback data to views.
 * Flattens nested User entity into simple fields.
 */
@Data
public class FeedbackDTO {
    private Long feedbackId;
    private String userName;
    private String userEmail;
    private String message;
    private int rating;
    private LocalDateTime createdAt;
}
