package com.reservesmart.service;

import com.reservesmart.model.Reservation;
import com.reservesmart.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * OOP: POLYMORPHISM — Implements ReservationValidator for conflict checking.
 * OOP: ENCAPSULATION — Conflict logic is hidden inside this class.
 */
@Component
public class ConflictValidator implements ReservationValidator {

    @Autowired
    private ReservationRepository reservationRepository;

    /**
     * Checks if the same table is already booked for the same date and time.
     * OOP: INFORMATION HIDING — Controller calls this via service, not directly.
     */
    @Override
    public void validate(Reservation reservation) {
        List<Reservation> existing = reservationRepository
                .findByTableTableIdAndReservationDateAndReservationTime(
                        reservation.getTable().getTableId(),
                        reservation.getReservationDate(),
                        reservation.getReservationTime()
                );

        // Exclude current reservation when updating
        boolean conflict = existing.stream()
                .anyMatch(r -> !r.getReservationId().equals(reservation.getReservationId())
                        && !r.isCancelled());

        if (conflict) {
            throw new IllegalArgumentException(
                    "This table is already booked for the selected date and time."
            );
        }
    }
}