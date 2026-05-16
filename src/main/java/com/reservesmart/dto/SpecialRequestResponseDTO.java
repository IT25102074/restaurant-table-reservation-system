package com.reservesmart.dto;


import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SpecialRequestResponseDTO {
    private Long id;
    private Long customerID;
    private String response;
    private LocalDateTime submitted;
    private Long reservationId;

}
