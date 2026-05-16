package com.reservesmart.repository;

import com.reservesmart.model.RestaurantTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TableRepository extends JpaRepository<RestaurantTable, Long> {

    // Get all available tables
    List<RestaurantTable> findByStatus(String status);

    // Get tables that can fit the guest count
    List<RestaurantTable> findByStatusAndCapacityGreaterThanEqual(String status, int capacity);

    // Check duplicate table number
    boolean existsByTableNumber(String tableNumber);

    // Find by table number
    Optional<RestaurantTable> findByTableNumber(String tableNumber);
}