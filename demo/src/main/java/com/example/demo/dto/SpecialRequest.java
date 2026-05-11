package com.example.demo.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SpecialRequest {
    private Long CustomerID; //id ek
    private Long CustomerName; //name ek
    private String Request;
    private LocalDateTime time;

    //isAccepted(bool) - ekak danna pluwn unoth


}
