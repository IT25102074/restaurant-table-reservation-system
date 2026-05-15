package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * OOP: ENCAPSULATION — All table fields are private.
 * OOP: ABSTRACTION — isAvailable() and updateStatus() hide logic from
 * controllers.
 */
@Entity
@Table(name = "restaurant_tables")
@Getter @Setter
public class RestaurantTable {

    // Table status constants
    public static final String STATUS_AVAILABLE = "AVAILABLE";
    public static final String STATUS_RESERVED = "RESERVED";
    public static final String STATUS_INACTIVE = "INACTIVE";

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

    // Constructors

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
}