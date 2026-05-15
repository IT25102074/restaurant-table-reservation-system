package com.reservesmart.dto;

import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 * DTO for transferring Reservation data to views.
 * Flattens nested User and Table entities into simple fields.
 */
@Data
public class ReservationDTO {
    private Long reservationId;
    private String userName;
    private String userEmail;
    private String tableNumber;
    private int tableCapacity;
    private String tableLocation;
    private Long tableId;
    private LocalDate reservationDate;
    private LocalTime reservationTime;
    private int guestCount;
    private String status;
    private LocalDateTime createdAt;
}
