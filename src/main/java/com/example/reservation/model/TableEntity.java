package com.example.reservation.model;

import jakarta.persistence.*;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class TableEntity {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

    private int capacity;

    public TableEntity() {}

    public TableEntity(int capacity) {
        this.capacity = capacity;
    }

    public Long getId() {
        return id;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
}

