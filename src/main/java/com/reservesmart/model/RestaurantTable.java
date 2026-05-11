package com.reservesmart.model;

import jakarta.persistence.*;
import java.util.List;

/**
 * OOP: ENCAPSULATION — All table fields are private.
 * OOP: ABSTRACTION — isAvailable() and updateStatus() hide logic from controllers.
 */
@Entity
@Table(name = "restaurant_tables")
public class RestaurantTable {

    // Table status constants
    public static final String STATUS_AVAILABLE = "AVAILABLE";
    public static final String STATUS_RESERVED   = "RESERVED";
    public static final String STATUS_INACTIVE   = "INACTIVE";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long tableId;

    @Column(name = "table_number", nullable = false, unique = true)
    private String tableNumber;

    @Column(name = "capacity", nullable = false)
    private int capacity;

    @Column(name = "location")
    private String location;

    @Column(name = "status", nullable = false)
    private String status;

    //  Constructors

    public RestaurantTable() {
        this.status = STATUS_AVAILABLE;
    }

    public RestaurantTable(String tableNumber, int capacity, String location) {
        this.tableNumber = tableNumber;
        this.capacity = capacity;
        this.location = location;
        this.status = STATUS_AVAILABLE;
    }

    // Business Logic Methods
    /**
     * OOP: ABSTRACTION — Hides status check logic.
     */
    public boolean isAvailable() {
        return STATUS_AVAILABLE.equals(this.status);
    }

    /**
     * OOP: ENCAPSULATION — Status is updated through this controlled method.
     */
    public void updateStatus(String newStatus) {
        this.status = newStatus;
    }

    public void markAsReserved() {
        this.status = STATUS_RESERVED;
    }

    public void markAsAvailable() {
        this.status = STATUS_AVAILABLE;
    }

    // Getters & Setters

    public Long getTableId() { return tableId; }
    public void setTableId(Long tableId) { this.tableId = tableId; }

    public String getTableNumber() { return tableNumber; }
    public void setTableNumber(String tableNumber) { this.tableNumber = tableNumber; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}