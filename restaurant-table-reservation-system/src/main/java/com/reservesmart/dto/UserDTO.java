package com.reservesmart.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * DTO for transferring User data between service and controller layers.
 * Excludes sensitive fields like password and resetToken.
 */
@Data
public class UserDTO {
    private Long userId;
    private String fullName;
    private String email;
    private String phone;
    private String role;
    private LocalDateTime createdAt;
    private String dashboardUrl;
}
