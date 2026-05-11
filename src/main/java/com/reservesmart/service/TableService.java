package com.reservesmart.service;

import com.reservesmart.model.RestaurantTable;
import com.reservesmart.repository.ReservationRepository;
import com.reservesmart.repository.TableRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * OOP: ENCAPSULATION — All table business logic is hidden inside this service.
 * OOP: INFORMATION HIDING — Controller never touches TableRepository directly.
 */
@Service
public class TableService {

    @Autowired
    private TableRepository tableRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    // CREATE

    public RestaurantTable addTable(String tableNumber, int capacity, String location) {

        if (tableNumber == null || tableNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Table number cannot be empty.");
        }

        if (tableRepository.existsByTableNumber(tableNumber.trim())) {
            throw new IllegalArgumentException("Table number already exists.");
        }

        if (capacity <= 0) {
            throw new IllegalArgumentException("Capacity must be greater than zero.");
        }

        RestaurantTable table = new RestaurantTable(tableNumber.trim(), capacity, location);
        return tableRepository.save(table);
    }

    // READ

    public List<RestaurantTable> getAllTables() {
        return tableRepository.findAll();
    }

    public List<RestaurantTable> getAvailableTables() {
        return tableRepository.findByStatus(RestaurantTable.STATUS_AVAILABLE);
    }

    public RestaurantTable getTableById(Long tableId) {
        return tableRepository.findById(tableId)
                .orElseThrow(() -> new IllegalArgumentException("Table not found."));
    }

    //  UPDATE

    public RestaurantTable updateTable(Long tableId, int capacity,
                                       String location, String status) {
        RestaurantTable table = getTableById(tableId);

        if (capacity <= 0) {
            throw new IllegalArgumentException("Capacity must be greater than zero.");
        }

        table.setCapacity(capacity);
        table.setLocation(location);
        table.setStatus(status);
        return tableRepository.save(table);
    }

    // DELETE

    /**
     * Cannot delete a table that has active (PENDING/CONFIRMED) reservations.
     * OOP: ENCAPSULATION — This business rule is hidden inside the service.
     */
    public void deleteTable(Long tableId) {
        RestaurantTable table = getTableById(tableId);

        boolean hasActiveReservation = reservationRepository
                .findByTableTableId(tableId)
                .stream()
                .anyMatch(r -> r.getStatus().equals("PENDING")
                        || r.getStatus().equals("CONFIRMED"));

        if (hasActiveReservation) {
            throw new IllegalArgumentException(
                    "Cannot delete table with active reservations.");
        }

        tableRepository.delete(table);
    }

    // ─── SEARCH / FILTER ──────────────────────────────────────────────────────

    public List<RestaurantTable> searchTables(String keyword, String status) {
        List<RestaurantTable> all = tableRepository.findAll();

        return all.stream()
                .filter(t -> {
                    boolean matchKeyword = (keyword == null || keyword.isEmpty())
                            || t.getTableNumber().toLowerCase().contains(keyword.toLowerCase())
                            || t.getLocation().toLowerCase().contains(keyword.toLowerCase());

                    boolean matchStatus = (status == null || status.isEmpty())
                            || t.getStatus().equals(status);

                    return matchKeyword && matchStatus;
                })
                .toList();
    }

    // TABLE RECOMMENDATION

    /**
     * Recommends the best available table based on guest count.
     * Finds the smallest table that can fit the guests — avoids wasting large tables.
     *
     * OOP: ENCAPSULATION — Recommendation logic is hidden inside service.
     * OOP: ABSTRACTION — Controller just calls this method and gets a result.
     */
    public RestaurantTable recommendTable(int guestCount) {
        List<RestaurantTable> suitable = tableRepository
                .findByStatusAndCapacityGreaterThanEqual(
                        RestaurantTable.STATUS_AVAILABLE, guestCount);

        if (suitable.isEmpty()) {
            return null; // No suitable table found
        }

        // Return the table with the smallest capacity that still fits the guests
        return suitable.stream()
                .min((a, b) -> Integer.compare(a.getCapacity(), b.getCapacity()))
                .orElse(null);
    }
}