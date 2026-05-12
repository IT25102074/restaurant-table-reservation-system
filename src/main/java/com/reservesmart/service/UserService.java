package com.reservesmart.service;

import com.reservesmart.model.Admin;
import com.reservesmart.model.Customer;
import com.reservesmart.model.User;
import com.reservesmart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * OOP: ENCAPSULATION — All business logic is hidden inside service methods.
 * OOP: INFORMATION HIDING — Controller never touches repository directly.
 */
@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // ─── Register ─────────────────────────────────────────────────────────────

    /**
     * Registers a new Customer.
     * Validates: unique email, password length, phone format.
     */
    public User registerCustomer(String fullName, String email,
                                 String password, String phone) {
        // Validate unique email
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already registered. Please login.");
        }

        // Validate password length
        if (password == null || password.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters.");
        }

        // Validate phone (basic: 10 digits)
        if (phone != null && !phone.matches("\\d{10,15}")) {
            throw new IllegalArgumentException("Phone number must be 10-15 digits.");
        }

        // OOP: POLYMORPHISM — Creating a Customer (subclass of User)
        Customer customer = new Customer(fullName, email, password, phone);
        return userRepository.save(customer);
    }

    // ─── Login ────────────────────────────────────────────────────────────────

    /**
     * Validates login credentials.
     * Returns the User if valid, throws exception if not.
     */
    public User login(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("No account found with that email.");
        }

        User user = userOpt.get();

        // Simple plain-text check (Phase 9 can add BCrypt)
        if (!user.getPassword().equals(password)) {
            throw new IllegalArgumentException("Incorrect password.");
        }

        return user;
    }

    // ─── Profile CRUD ─────────────────────────────────────────────────────────

    /**
     * Get user by ID.
     */
    public User getUserById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));
    }

    /**
     * Update user profile (name and phone only — email/role not changeable).
     */
    public User updateProfile(Long userId, String fullName, String phone) {
        User user = getUserById(userId);

        if (fullName == null || fullName.trim().isEmpty()) {
            throw new IllegalArgumentException("Full name cannot be empty.");
        }

        if (phone != null && !phone.matches("\\d{10,15}")) {
            throw new IllegalArgumentException("Phone number must be 10-15 digits.");
        }

        // OOP: calling method defined in abstract User class
        user.updateProfile(fullName, phone);
        return userRepository.save(user);
    }

    /**
     * Delete user account.
     */
    public void deleteAccount(Long userId) {
        User user = getUserById(userId);
        userRepository.delete(user);
    }

    // ─── Admin: View All Users ────────────────────────────────────────────────

    /**
     * Get all users (admin use).
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Search users by name or email (admin use).
     */
    public List<User> searchUsers(String keyword) {
        List<User> all = userRepository.findAll();
        if (keyword == null || keyword.trim().isEmpty()) return all;

        String kw = keyword.toLowerCase();
        return all.stream()
                .filter(u -> u.getFullName().toLowerCase().contains(kw)
                        || u.getEmail().toLowerCase().contains(kw))
                .toList();
    }
}