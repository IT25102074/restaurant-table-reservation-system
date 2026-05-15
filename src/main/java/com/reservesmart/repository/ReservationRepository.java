package com.reservesmart.repository;

import com.reservesmart.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {

    // Used by ConflictValidator — checks double booking
    List<Reservation> findByTableTableIdAndReservationDateAndReservationTime(
            Long tableId,
            LocalDate reservationDate,
            LocalTime reservationTime
    );

    // customer view own reservations
    List<Reservation> findByUserUserId(Long userId);

    //admin view all by status
    List<Reservation> findByStatus(String status);

    List<Reservation> findByTableTableId(Long tableId);
}