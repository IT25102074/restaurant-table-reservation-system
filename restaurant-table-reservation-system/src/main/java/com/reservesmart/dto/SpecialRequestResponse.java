package com.reservesmart.dto;


import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SpecialRequestResponse {
    private Long id;
    private Long customerID;
    private String customerName;
    private String response;
    private LocalDateTime submitted;


}
