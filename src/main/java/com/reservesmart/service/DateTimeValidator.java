package com.reservesmart.service;

import com.reservesmart.model.Reservation;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * OOP: POLYMORPHISM — Implements ReservationValidator for date/time checking.
 * OOP: ENCAPSULATION — Date/time logic is hidden inside this class.
 */
@Component
public class DateTimeValidator implements ReservationValidator {

    /**
     * Checks that reservation date/time is not in the past.
     */
    @Override
    public void validate(Reservation reservation) {
        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();

        LocalDate resDate = reservation.getReservationDate();
        LocalTime resTime = reservation.getReservationTime();

        if (resDate == null) {
            throw new IllegalArgumentException("Reservation date cannot be empty.");
        }

        if (resDate.isBefore(today)) {
            throw new IllegalArgumentException("Reservation date cannot be in the past.");
        }

        if (resDate.isEqual(today) && resTime.isBefore(now)) {
            throw new IllegalArgumentException("Reservation time cannot be in the past.");
        }
    }
}