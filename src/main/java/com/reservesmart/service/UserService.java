package com.reservesmart.service;

import com.reservesmart.dto.UserDTO;
import com.reservesmart.model.Customer;
import com.reservesmart.model.User;
import com.reservesmart.repository.FeedbackRepository;
import com.reservesmart.repository.NotificationRepository;
import com.reservesmart.repository.ReservationRepository;
import com.reservesmart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * OOP: ENCAPSULATION — All business logic is hidden inside service methods.
 * OOP: INFORMATION HIDING — Controller never touches repository directly.
 */
@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private FeedbackRepository feedbackRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    // ADD these @Autowired at the top of UserService class

    @Autowired
    private NotificationRepository notificationRepository;

    // Register

    /**
     * Registers a new Customer.
     * Validates: unique email, password length, phone format.
     */
    public User registerCustomer(String fullName, String email,
            String password, String phone) {

        // Validate unique email
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException(
                    "Email already registered. Please login.");
        }

        // Validate password length
        if (password == null || password.length() < 6) {
            throw new IllegalArgumentException(
                    "Password must be at least 6 characters.");
        }

        // Validate phone number
        if (phone != null && !phone.matches("\\d{10,15}")) {
            throw new IllegalArgumentException(
                    "Phone number must be 10-15 digits.");
        }

        // OOP: POLYMORPHISM — Customer is subclass of User
        Customer customer = new Customer(fullName, email, password, phone);

        User savedUser = userRepository.save(customer);

        // Send welcome notification
        notificationService.sendRegistrationWelcome(savedUser);

        return savedUser;
    }

    // Login

    /**
     * Validates login credentials.
     */
    public User login(String email, String password) {

        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException(
                    "No account found with that email.");
        }

        User user = userOpt.get();

        // Plain-text password check

        if (!user.getPassword().equals(password)) {
            throw new IllegalArgumentException("Incorrect password.");
        }

        return user;
    }

    // Profile CRUD

    /**
     * Get user by ID.
     */
    public User getUserById(Long userId) {

        return userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));
    }

    /**
     * Update user profile.
     */
    public User updateProfile(Long userId,
            String fullName,
            String email,
            String phone) {

        User user = getUserById(userId);

        if (fullName == null || fullName.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Full name cannot be empty.");
        }

        if (email != null && !email.trim().isEmpty() && !email.equals(user.getEmail())) {
            if (userRepository.existsByEmail(email)) {
                throw new IllegalArgumentException("Email already registered by another user.");
            }
        }

        if (phone != null && !phone.matches("\\d{10,15}")) {
            throw new IllegalArgumentException(
                    "Phone number must be 10-15 digits.");
        }

        // OOP: method from abstract User class
        user.updateProfile(fullName, email, phone);

        return userRepository.save(user);
    }

    /**
     * Delete user account.
     * Deletes child records first to avoid foreign key errors.
     */

    public void deleteAccount(Long userId) {
        User user = getUserById(userId);

        // 1. Delete feedback
        List<com.reservesmart.model.Feedback> feedbacks = feedbackRepository
                .findByUserUserIdOrderByCreatedAtDesc(userId);
        feedbackRepository.deleteAll(feedbacks);

        // 2. Delete notifications
        List<com.reservesmart.model.Notification> notifications = notificationRepository
                .findByUserUserIdOrderByCreatedAtDesc(userId);
        notificationRepository.deleteAll(notifications);

        // 3. Delete reservations
        List<com.reservesmart.model.Reservation> reservations = reservationRepository.findByUserUserId(userId);

        for (com.reservesmart.model.Reservation r : reservations) {
            if ("PENDING".equals(r.getStatus()) || "CONFIRMED".equals(r.getStatus())) {
                r.getTable().markAsAvailable();
            }
        }
        reservationRepository.deleteAll(reservations);

        // 4. Now safe to delete the user
        userRepository.delete(user);
    }

    // Admin: View All Users

    /**
     * Get all users.
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Search users by name or email.
     */
    public List<User> searchUsers(String keyword) {

        List<User> all = userRepository.findAll();

        if (keyword == null || keyword.trim().isEmpty()) {
            return all;
        }

        String kw = keyword.toLowerCase();

        return all.stream()
                .filter(u -> u.getFullName().toLowerCase().contains(kw)
                        || u.getEmail().toLowerCase().contains(kw))
                .toList();
    }

    // Password Reset

    public void generatePasswordResetToken(String email) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            String token = java.util.UUID.randomUUID().toString();
            user.setResetToken(token);
            user.setResetTokenExpiry(java.time.LocalDateTime.now().plusHours(1));
            userRepository.save(user);

            String resetLink = "http://localhost:8080/reset-password?token=" + token;
            notificationService.sendPasswordResetEmail(user, resetLink);
        } else {
            throw new IllegalArgumentException("No account found with that email.");
        }
    }

    public void resetPassword(String token, String newPassword) {
        Optional<User> userOpt = userRepository.findByResetToken(token);
        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("Invalid password reset token.");
        }
        User user = userOpt.get();
        if (user.getResetTokenExpiry() == null || user.getResetTokenExpiry().isBefore(java.time.LocalDateTime.now())) {
            throw new IllegalArgumentException("Password reset token has expired.");
        }

        if (newPassword == null || newPassword.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters.");
        }

        user.setPassword(newPassword);
        user.setResetToken(null);
        user.setResetTokenExpiry(null);
        userRepository.save(user);
    }

    // ─── DTO Conversion ─────────────────────────────────────────────────────

    public UserDTO toDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setUserId(user.getUserId());
        dto.setFullName(user.getFullName());
        dto.setEmail(user.getEmail());
        dto.setPhone(user.getPhone());
        dto.setRole(user.getRole());
        dto.setCreatedAt(user.getCreatedAt());
        dto.setDashboardUrl(user.getDashboardUrl());
        return dto;
    }

    public List<UserDTO> toDTOList(List<User> users) {
        return users.stream().map(this::toDTO).collect(Collectors.toList());
    }
}