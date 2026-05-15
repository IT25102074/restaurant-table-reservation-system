package com.reservesmart.repository;

import com.reservesmart.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Spring Data JPA repository for User.
 * Provides findByEmail() for login and registration checks.
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Find user by email (used for login and duplicate check)
    Optional<User> findByEmail(String email);

    // Check if email already exists (used for registration validation)
    boolean existsByEmail(String email);

    // Find user by reset token
    Optional<User> findByResetToken(String resetToken);
}