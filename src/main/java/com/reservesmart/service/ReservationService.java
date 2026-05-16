package com.reservesmart.service;

import com.reservesmart.dto.ReservationDTO;
import com.reservesmart.model.Reservation;
import com.reservesmart.model.RestaurantTable;
import com.reservesmart.model.User;
import com.reservesmart.repository.ReservationRepository;
import com.reservesmart.repository.TableRepository;
import com.reservesmart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * OOP: ENCAPSULATION — All reservation business logic is hidden here.
 * OOP: INFORMATION HIDING — Controller never touches repositories directly.
 */
@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private TableRepository tableRepository;

    @Autowired
    private UserRepository userRepository;

    // OOP: POLYMORPHISM — Each validator implements ReservationValidator differently
    @Autowired
    private ConflictValidator conflictValidator;

    @Autowired
    private CapacityValidator capacityValidator;

    @Autowired
    private DateTimeValidator dateTimeValidator;

    @Autowired
    private NotificationService notificationService;

    // CREATE

    /**
     * Creates a new reservation after running all 3 validators.
     * On success: marks table as RESERVED.
     */
    public Reservation createReservation(Long userId, Long tableId,
                                         LocalDate date, LocalTime time,
                                         int guestCount) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));

        RestaurantTable table = tableRepository.findById(tableId)
                .orElseThrow(() -> new IllegalArgumentException("Table not found."));

        // Build reservation object for validation
        Reservation reservation = new Reservation(user, table, date, time, guestCount);

        // OOP: POLYMORPHISM — run all validators (each validates differently)
        dateTimeValidator.validate(reservation);
        capacityValidator.validate(reservation);
        conflictValidator.validate(reservation);

        // Mark table as reserved
        table.markAsReserved();
        tableRepository.save(table);

        //add notificaton part
        Reservation saved = reservationRepository.save(reservation);
        notificationService.sendReservationCreated(
                user,
                table.getTableNumber(),
                date.toString(),
                time.toString()
        );
        return saved;
    }

    // READ

    /**
     * Get all reservations for a specific customer.
     */
    public List<Reservation> getMyReservations(Long userId) {
        return reservationRepository.findByUserUserId(userId);
    }

    /**
     * Get all reservations (admin use).
     */
    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    /**
     * Get single reservation by ID.
     */
    public Reservation getReservationById(Long reservationId) {
        return reservationRepository.findById(reservationId)
                .orElseThrow(() -> new IllegalArgumentException("Reservation not found."));
    }

    //UPDATE

    /**
     * Updates date, time, and guest count of an existing reservation.
     * Re-runs all validators after update.
     */
    public Reservation updateReservation(Long reservationId, Long userId,
                                         LocalDate newDate, LocalTime newTime,
                                         int newGuestCount) {

        Reservation reservation = getReservationById(reservationId);

        // Only owner can update
        if (!reservation.getUser().getUserId().equals(userId)) {
            throw new IllegalArgumentException("You can only update your own reservations.");
        }

        if (reservation.isCancelled()) {
            throw new IllegalArgumentException("Cannot update a cancelled reservation.");
        }

        // Apply new values
        reservation.updateReservation(newDate, newTime, newGuestCount);

        // Re-run all validators
        dateTimeValidator.validate(reservation);
        capacityValidator.validate(reservation);
        conflictValidator.validate(reservation);

        // Sahan: notify customer of reservation update
        Reservation updated = reservationRepository.save(reservation);
        notificationService.sendReservationUpdated(
                reservation.getUser(),
                reservation.getTable().getTableNumber(),
                newDate.toString(),
                newTime.toString()
        );
        return updated;

    }

    // CANCEL

    /**
     * Cancels a reservation and frees the table back to AVAILABLE.
     */
    public void cancelReservation(Long reservationId, Long userId) {
        Reservation reservation = getReservationById(reservationId);

        // Only owner can cancel
        if (!reservation.getUser().getUserId().equals(userId)) {
            throw new IllegalArgumentException("You can only cancel your own reservations.");
        }

        if (reservation.isCancelled()) {
            throw new IllegalArgumentException("Reservation is already cancelled.");
        }

        // OOP: cancelReservation() in Reservation model frees the table
        reservation.cancelReservation();
        tableRepository.save(reservation.getTable());
        reservationRepository.save(reservation);
        // Sahan: notify customer of cancellation
        notificationService.sendReservationCancelled(
                reservation.getUser(),
                reservation.getTable().getTableNumber()
        );
    }

    // ADMIN: CONFIRM

    /**
     * Admin confirms a PENDING reservation.
     */
    public void confirmReservation(Long reservationId) {
        Reservation reservation = getReservationById(reservationId);

        if (!reservation.getStatus().equals(Reservation.STATUS_PENDING)) {
            throw new IllegalArgumentException("Only PENDING reservations can be confirmed.");
        }

        reservation.confirmReservation();
        reservationRepository.save(reservation);
        // Sahan: notify customer of confirmation
        notificationService.sendReservationConfirmed(
                reservation.getUser(),
                reservation.getTable().getTableNumber(),
                reservation.getReservationDate().toString(),
                reservation.getReservationTime().toString()
        );
    }

    // ADMIN: FILTER

    /**
     * Filter reservations by status (admin use).
     */
    public List<Reservation> filterByStatus(String status) {
        if (status == null || status.isEmpty()) {
            return getAllReservations();
        }
        return reservationRepository.findByStatus(status);
    }

    // ADD searchReservations function

    /**
     * Admin: search reservations by customer name or table number.
     * OOP: ENCAPSULATION — Search logic is hidden inside service.
     */
    public List<Reservation> searchReservations(String keyword, String status) {
        List<Reservation> all = reservationRepository.findAll();

        return all.stream()
                .filter(r -> {
                    boolean matchKeyword = (keyword == null || keyword.trim().isEmpty())
                            || r.getUser().getFullName().toLowerCase()
                            .contains(keyword.toLowerCase())
                            || r.getTable().getTableNumber().toLowerCase()
                            .contains(keyword.toLowerCase());

                    boolean matchStatus = (status == null || status.trim().isEmpty())
                            || r.getStatus().equals(status);

                    return matchKeyword && matchStatus;
                })
                .toList();
    }

    // ─── DTO Conversion ─────────────────────────────────────────────────────

    public ReservationDTO toDTO(Reservation r) {
        ReservationDTO dto = new ReservationDTO();
        dto.setReservationId(r.getReservationId());
        dto.setUserName(r.getUser().getFullName());
        dto.setUserEmail(r.getUser().getEmail());
        dto.setTableNumber(r.getTable().getTableNumber());
        dto.setTableCapacity(r.getTable().getCapacity());
        dto.setTableLocation(r.getTable().getLocation());
        dto.setTableId(r.getTable().getTableId());
        dto.setReservationDate(r.getReservationDate());
        dto.setReservationTime(r.getReservationTime());
        dto.setGuestCount(r.getGuestCount());
        dto.setStatus(r.getStatus());
        dto.setCreatedAt(r.getCreatedAt());
        return dto;
    }

    public List<ReservationDTO> toDTOList(List<Reservation> reservations) {
        return reservations.stream().map(this::toDTO).collect(Collectors.toList());
    }

}