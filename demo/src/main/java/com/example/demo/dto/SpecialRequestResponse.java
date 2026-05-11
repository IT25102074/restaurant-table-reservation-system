package com.example.demo.dto;


import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SpecialRequestResponse {
    private Long id;
    private String Customername;    //flatterend from customer obj
    private String Response;
    private LocalDateTime submitted;




}
