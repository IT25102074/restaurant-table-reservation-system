package com.reservesmart.dto;

import lombok.Data;

/**
 * DTO for transferring RestaurantTable data to views.
 */
@Data
public class TableDTO {
    private Long tableId;
    private String tableNumber;
    private int capacity;
    private String location;
    private String status;
}
