package com.restaurant.reservation.service;

import com.restaurant.reservation.model.Reservation;
import com.restaurant.reservation.model.User;
import com.restaurant.reservation.repository.ReservationRepository;
import com.restaurant.reservation.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationServiceImpl implements ReservationService {

    private final ReservationRepository reservationRepository;
    private final UserRepository userRepository;

    @Autowired
    public ReservationServiceImpl(ReservationRepository reservationRepository, UserRepository userRepository) {
        this.reservationRepository = reservationRepository;
        this.userRepository = userRepository;
    }

    @Override
    public void saveReservation(Reservation reservation, String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
        reservation.setUser(user);
        
        // Basic double booking check (can be improved based on business logic)
        if (reservationRepository.existsByDateAndTime(reservation.getDate(), reservation.getTime())) {
            throw new RuntimeException("Time slot is already booked.");
        }
        
        reservationRepository.save(reservation);
    }

    @Override
    public List<Reservation> findReservationsByUser(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return reservationRepository.findByUser(user);
    }

    @Override
    public List<Reservation> findAllReservations() {
        return reservationRepository.findAll();
    }

    @Override
    public Reservation findById(Long id) {
        return reservationRepository.findById(id).orElse(null);
    }

    @Override
    public void updateReservation(Reservation reservation) {
        Reservation existing = findById(reservation.getId());
        if (existing != null) {
            existing.setDate(reservation.getDate());
            existing.setTime(reservation.getTime());
            existing.setNumberOfGuests(reservation.getNumberOfGuests());
            reservationRepository.save(existing);
        }
    }

    @Override
    public void deleteReservation(Long id) {
        reservationRepository.deleteById(id);
    }
}
