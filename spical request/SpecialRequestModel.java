package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "SpecialRequest")  //db  eka ekka change krnna
public class SpecialRequestModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
//    private String Name;

//depended on user clss
//    @ManyToOne
//    @JoinColumn(name = "customer_id") //merge krddi change krnn
//    private Customer customer;  //merge krddi change krnn "Customer -> class name
//
//    @JoinColumn(name = "customer_name") //merge krddi chnge krnn
//    private Customer cusName;

    private Long reservationId;
    private Long customerID;
    private String Request;
    private LocalDateTime time;
    //isaccepted eka danna free unama

    @PrePersist
    public void prePersist() {
        this.time = LocalDateTime.now();
    }

}