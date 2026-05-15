package com.reservesmart.service;

import com.reservesmart.model.*;
import com.reservesmart.repository.NotificationRepository;
// import com.reservesmart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * OOP: ENCAPSULATION — Notification creation logic is hidden here.
 * OOP: POLYMORPHISM — Creates SystemNotification, EmailNotification,
 * SmsNotification
 * all stored as Notification (parent type).
 * OOP: ABSTRACTION — Controller just calls sendReservationCreated() etc.
 */
@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    // @Autowired
    // private UserRepository userRepository;

    @Autowired
    private EmailNotificationService emailNotificationService;

    @Autowired
    private SmsNotificationService smsNotificationService;

    // TRIGGER METHODS (called from ReservationService and UserService)

    public void sendRegistrationWelcome(User user) {
        String message = "Welcome to ReserveSmart! Your account has been created successfully.";

        saveSystemNotification(user, message);
        emailNotificationService.saveEmailNotification(user, message);
        emailNotificationService.sendEmail(user.getEmail(),
                "Welcome to ReserveSmart!", message);
    }

    public void sendPasswordResetEmail(User user, String resetLink) {
        String message = "You requested a password reset. Click the link to reset your password: " + resetLink;

        saveSystemNotification(user, "Password reset email sent.");
        emailNotificationService.saveEmailNotification(user, message);
        emailNotificationService.sendEmail(user.getEmail(),
                "Password Reset Request - ReserveSmart", message);
    }

    public void sendReservationCreated(User user, String tableNumber,
                                       String date, String time) {
        String message = "Your reservation for Table " + tableNumber
                + " on " + date + " at " + time + " has been created. Status: PENDING.";

        saveSystemNotification(user, message);
        emailNotificationService.saveEmailNotification(user, message);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Confirmed — ReserveSmart", message);
        smsNotificationService.saveSmsNotification(user, message);
        smsNotificationService.sendSms(user.getPhone(), message);
    }

    public void sendReservationUpdated(User user, String tableNumber,
                                       String date, String time) {
        String message = "Your reservation for Table " + tableNumber
                + " has been updated to " + date + " at " + time + ".";

        saveSystemNotification(user, message);
        emailNotificationService.saveEmailNotification(user, message);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Updated — ReserveSmart", message);
        smsNotificationService.saveSmsNotification(user, message);
        smsNotificationService.sendSms(user.getPhone(), message);
    }

    public void sendReservationCancelled(User user, String tableNumber) {
        String message = "Your reservation for Table " + tableNumber
                + " has been cancelled.";

        saveSystemNotification(user, message);
        emailNotificationService.saveEmailNotification(user, message);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Cancelled — ReserveSmart", message);
        smsNotificationService.saveSmsNotification(user, message);
        smsNotificationService.sendSms(user.getPhone(), message);
    }

    public void sendReservationConfirmed(User user, String tableNumber,
                                         String date, String time) {
        String message = "Great news! Your reservation for Table " + tableNumber
                + " on " + date + " at " + time + " has been CONFIRMED by the restaurant.";

        saveSystemNotification(user, message);
        emailNotificationService.saveEmailNotification(user, message);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Confirmed - ReserveSmart", message);
        smsNotificationService.saveSmsNotification(user, message);
        smsNotificationService.sendSms(user.getPhone(), message);
    }

    // READ

    public List<Notification> getUserNotifications(Long userId) {
        return notificationRepository.findByUserUserIdOrderByCreatedAtDesc(userId);
    }

    public long countUnread(Long userId) {
        return notificationRepository.countByUserUserIdAndStatus(
                userId, Notification.STATUS_UNREAD);
    }

    // UPDATE

    public void markAsRead(Long notificationId) {
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new IllegalArgumentException("Notification not found."));
        notification.markAsRead();
        notificationRepository.save(notification);
    }

    public void markAllAsRead(Long userId) {
        List<Notification> unread = notificationRepository
                .findByUserUserIdAndStatusOrderByCreatedAtDesc(
                        userId, Notification.STATUS_UNREAD);
        for (Notification n : unread) {
            n.markAsRead();
            notificationRepository.save(n);
        }
    }

    // DELETE

    public void deleteNotification(Long notificationId, Long userId) {
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new IllegalArgumentException("Notification not found."));

        if (!notification.getUser().getUserId().equals(userId)) {
            throw new IllegalArgumentException("You can only delete your own notifications.");
        }
        notificationRepository.delete(notification);
    }

    public void deleteAllNotifications(Long userId) {
        List<Notification> all = notificationRepository
                .findByUserUserIdOrderByCreatedAtDesc(userId);
        notificationRepository.deleteAll(all);
    }

    // PRIVATE HELPER

    /**
     * OOP: POLYMORPHISM — Creates a SystemNotification (subclass of Notification).
     */
    private void saveSystemNotification(User user, String message) {
        SystemNotification notification = new SystemNotification(user, message);
        notification.sendNotification();
        notificationRepository.save(notification);
    }
}