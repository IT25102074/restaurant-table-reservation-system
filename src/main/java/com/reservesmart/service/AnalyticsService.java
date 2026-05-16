package com.reservesmart.service;

import com.reservesmart.model.Reservation;
import com.reservesmart.repository.FeedbackRepository;
// import com.reservesmart.repository.NotificationRepository;
import com.reservesmart.repository.ReservationRepository;
import com.reservesmart.repository.TableRepository;
import com.reservesmart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * OOP: ABSTRACTION — Hides all complex stat calculation from the controller.
 * OOP: ENCAPSULATION — Analytics values computed inside this service, not in
 * JSP.
 * OOP: INFORMATION HIDING — AdminController calls getSummary() and gets a Map
 * back.
 */
@Service
public class AnalyticsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TableRepository tableRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private FeedbackRepository feedbackRepository;

    /**
     * Returns a summary map of all dashboard stats.
     * OOP: ABSTRACTION — Controller only receives the final Map, not the logic.
     */
    public Map<String, Object> getSummary() {
        Map<String, Object> stats = new HashMap<>();

        // Users
        long totalUsers = userRepository.count();
        long totalCustomers = userRepository.findAll().stream()
                .filter(u -> "CUSTOMER".equals(u.getRole())).count();
        long totalAdmins = totalUsers - totalCustomers;

        stats.put("totalUsers", totalUsers);
        stats.put("totalCustomers", totalCustomers);
        stats.put("totalAdmins", totalAdmins);

        // Tables
        long totalTables = tableRepository.count();
        long availableTables = tableRepository.findByStatus("AVAILABLE").size();
        long reservedTables = tableRepository.findByStatus("RESERVED").size();
        long inactiveTables = tableRepository.findByStatus("INACTIVE").size();

        stats.put("totalTables", totalTables);
        stats.put("availableTables", availableTables);
        stats.put("reservedTables", reservedTables);
        stats.put("inactiveTables", inactiveTables);

        // Reservations
        List<Reservation> allReservations = reservationRepository.findAll();
        long totalReservations = allReservations.size();
        long pendingCount = allReservations.stream()
                .filter(r -> "PENDING".equals(r.getStatus())).count();
        long confirmedCount = allReservations.stream()
                .filter(r -> "CONFIRMED".equals(r.getStatus())).count();
        long cancelledCount = allReservations.stream()
                .filter(r -> "CANCELLED".equals(r.getStatus())).count();
        long completedCount = allReservations.stream()
                .filter(r -> "COMPLETED".equals(r.getStatus())).count();

        stats.put("totalReservations", totalReservations);
        stats.put("pendingCount", pendingCount);
        stats.put("confirmedCount", confirmedCount);
        stats.put("cancelledCount", cancelledCount);
        stats.put("completedCount", completedCount);

        // Feedback
        long totalFeedback = feedbackRepository.count();
        double avgRating = feedbackRepository.findAll().stream()
                .mapToInt(f -> f.getRating())
                .average()
                .orElse(0.0);

        // Round to 1 decimal
        avgRating = Math.round(avgRating * 10.0) / 10.0;

        stats.put("totalFeedback", totalFeedback);
        stats.put("avgRating", avgRating);

        return stats;
    }
}