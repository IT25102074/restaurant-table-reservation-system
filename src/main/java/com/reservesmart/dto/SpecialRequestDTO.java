package com.reservesmart.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SpecialRequestDTO {
    private Long reservationId; //id ek
    private String CustomerName; //name ek
    private String Request;


    //isAccepted(bool) - ekak danna pluwn unoth


}
