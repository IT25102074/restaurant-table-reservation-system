package com.restaurant.reservation.dto;

import lombok.*;

import java.time.LocalDateTime;

@Data
public class FeedbackDTO {
    private Long id;
    private String content;
    private Long userId;
    private LocalDateTime datetime;
}
