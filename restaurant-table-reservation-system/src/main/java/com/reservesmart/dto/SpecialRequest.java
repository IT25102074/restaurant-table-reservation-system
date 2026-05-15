package com.reservesmart.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SpecialRequest {
    private Long CustomerID; //id ek
    private String CustomerName; //name ek
    private String Request;
    private LocalDateTime time;

    //isAccepted(bool) - ekak danna pluwn unoth


}
