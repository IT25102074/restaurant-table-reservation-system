package com.restaurant.reservation.repository;

import com.restaurant.reservation.model.Reservation;
import com.restaurant.reservation.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findByUser(User user);
    boolean existsByDateAndTime(LocalDate date, LocalTime time);
}
