package com.reservesmart.service;

import com.reservesmart.model.Reservation;
import org.springframework.stereotype.Component;

/**
 * OOP: POLYMORPHISM — Implements ReservationValidator for capacity checking.
 * OOP: ENCAPSULATION — Capacity logic is hidden inside this class.
 */
@Component
public class CapacityValidator implements ReservationValidator {

    /**
     * Checks if guest count does not exceed table capacity.
     */
    @Override
    public void validate(Reservation reservation) {
        int tableCapacity = reservation.getTable().getCapacity();
        int guestCount = reservation.getGuestCount();

        if (guestCount <= 0) {
            throw new IllegalArgumentException("Guest count must be greater than zero.");
        }

        if (guestCount > tableCapacity) {
            throw new IllegalArgumentException(
                    "Guest count (" + guestCount + ") exceeds table capacity (" + tableCapacity + ").");
        }
    }
}