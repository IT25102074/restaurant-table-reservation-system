package com.reservesmart.service;



import com.reservesmart.model.Reservation;

/**
 * OOP: ABSTRACTION — Defines a contract for all validators.
 * OOP: POLYMORPHISM — Multiple validators implement this differently.
 * OOP: INFORMATION HIDING — Controller never validates directly, calls service instead.
 */
public interface ReservationValidator {

    /**
     * Validates the given reservation.
     * @param reservation the reservation to validate
     * @throws IllegalArgumentException if validation fails
     */
    void validate(Reservation reservation);
}