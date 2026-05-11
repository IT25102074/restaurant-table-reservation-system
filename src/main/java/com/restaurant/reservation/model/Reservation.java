package com.restaurant.reservation.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "reservations")
public class Reservation extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @NotNull(message = "Date is required")
    @FutureOrPresent(message = "Reservation date must be today or in the future")
    @Column(nullable = false)
    private LocalDate date;

    @NotNull(message = "Time is required")
    @Column(nullable = false)
    private LocalTime time;

    @Min(value = 1, message = "Number of guests must be at least 1")
    @Column(nullable = false)
    private Integer numberOfGuests;

    public Reservation() {
    }

    public Reservation(User user, LocalDate date, LocalTime time, Integer numberOfGuests) {
        this.user = user;
        this.date = date;
        this.time = time;
        this.numberOfGuests = numberOfGuests;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getTime() {
        return time;
    }

    public void setTime(LocalTime time) {
        this.time = time;
    }

    public Integer getNumberOfGuests() {
        return numberOfGuests;
    }

    public void setNumberOfGuests(Integer numberOfGuests) {
        this.numberOfGuests = numberOfGuests;
    }
}
