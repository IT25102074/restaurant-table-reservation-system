package com.reservesmart.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * DTO for transferring Notification data to views.
 */
@Data
public class NotificationDTO {
    private Long notificationId;
    private String message;
    private String status;
    private LocalDateTime createdAt;
}
