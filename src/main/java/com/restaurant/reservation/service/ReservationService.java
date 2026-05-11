package com.restaurant.reservation.service;

import com.restaurant.reservation.model.Reservation;
import com.restaurant.reservation.model.User;
import java.util.List;

public interface ReservationService {
    void saveReservation(Reservation reservation, String username);
    List<Reservation> findReservationsByUser(String username);
    List<Reservation> findAllReservations();
    Reservation findById(Long id);
    void updateReservation(Reservation reservation);
    void deleteReservation(Long id);
}
