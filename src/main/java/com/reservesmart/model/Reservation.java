package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 * OOP: ENCAPSULATION — All reservation fields are private.
 * OOP: ASSOCIATION — Reservation is linked to User and RestaurantTable via FK.
 */
@Entity
@Table(name = "reservations")
@Getter @Setter
public class Reservation {

    // Reservation status constants
    public static final String STATUS_PENDING   = "PENDING";
    public static final String STATUS_CONFIRMED = "CONFIRMED";
    public static final String STATUS_CANCELLED = "CANCELLED";
    public static final String STATUS_COMPLETED = "COMPLETED";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reservationId;

    // OOP: ASSOCIATION — Many reservations belong to one User
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // OOP: ASSOCIATION — Many reservations belong to one RestaurantTable
    @ManyToOne(fetch = FetchType.EAGER)  //change this line for test reservations error
    @JoinColumn(name = "table_id", nullable = false)
    private RestaurantTable table;

    @Column(name = "reservation_date", nullable = false)
    private LocalDate reservationDate;

    @Column(name = "reservation_time", nullable = false)
    private LocalTime reservationTime;

    @Column(name = "guest_count", nullable = false)
    private int guestCount;

    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // Constructors

    public Reservation() {
        this.status = STATUS_PENDING;
        this.createdAt = LocalDateTime.now();
    }

    public Reservation(User user, RestaurantTable table, LocalDate date,
                       LocalTime time, int guestCount) {
        this.user = user;
        this.table = table;
        this.reservationDate = date;
        this.reservationTime = time;
        this.guestCount = guestCount;
        this.status = STATUS_PENDING;
        this.createdAt = LocalDateTime.now();
    }

    // Business Logic Methods

    public void createReservation() {
        this.status = STATUS_PENDING;
    }

    public void updateReservation(LocalDate newDate, LocalTime newTime, int newGuestCount) {
        this.reservationDate = newDate;
        this.reservationTime = newTime;
        this.guestCount = newGuestCount;
    }

    public void cancelReservation() {
        this.status = STATUS_CANCELLED;
        if (this.table != null) {
            this.table.markAsAvailable();
        }
    }

    public void confirmReservation() {
        this.status = STATUS_CONFIRMED;
    }

    public boolean isCancelled() {
        return STATUS_CANCELLED.equals(this.status);
    }
}