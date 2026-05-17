package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "SpecialRequest")
public class SpecialRequestModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long reservationId;
    private Long customerID;
    private String Request;
    private LocalDateTime time;
    private String status; // PENDING, ACCEPTED, REJECTED

    @PrePersist
    public void prePersist() {
        this.time = LocalDateTime.now();
        if (this.status == null) {
            this.status = "PENDING";
        }
    }
}
