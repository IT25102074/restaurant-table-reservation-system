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
        String smsMessage = "Welcome to ReserveSmart! Your account is created.";

        saveSystemNotification(user, message);
        emailNotificationService.saveEmailNotification(user, message);
        emailNotificationService.sendEmail(user.getEmail(),
                "Welcome to ReserveSmart!", message);
        smsNotificationService.saveSmsNotification(user, smsMessage);
        smsNotificationService.sendSms(user.getPhone(), smsMessage);
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
        String emailMessage = "Dear " + user.getFullName() + ",\n\nYour reservation for Table " + tableNumber
                + " on " + date + " at " + time + " has been created. The current status is PENDING.\n\nThank you,\nReserveSmart Team";
        
        String smsMessage = "ReserveSmart: Reservation for Table " + tableNumber + " on " + date + " at " + time + " created. Status: PENDING.";

        saveSystemNotification(user, emailMessage);
        emailNotificationService.saveEmailNotification(user, emailMessage);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Confirmed — ReserveSmart", emailMessage);
        smsNotificationService.saveSmsNotification(user, smsMessage);
        smsNotificationService.sendSms(user.getPhone(), smsMessage);
    }

    public void sendReservationUpdated(User user, String tableNumber,
                                       String date, String time) {
        String emailMessage = "Dear " + user.getFullName() + ",\n\nYour reservation for Table " + tableNumber
                + " has been successfully updated to " + date + " at " + time + ".\n\nThank you,\nReserveSmart Team";
        
        String smsMessage = "ReserveSmart: Reservation for Table " + tableNumber + " updated to " + date + " at " + time + ".";

        saveSystemNotification(user, emailMessage);
        emailNotificationService.saveEmailNotification(user, emailMessage);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Updated — ReserveSmart", emailMessage);
        smsNotificationService.saveSmsNotification(user, smsMessage);
        smsNotificationService.sendSms(user.getPhone(), smsMessage);
    }

    public void sendReservationCancelled(User user, String tableNumber) {
        String emailMessage = "Dear " + user.getFullName() + ",\n\nYour reservation for Table " + tableNumber
                + " has been cancelled.\n\nWe hope to see you another time.\nReserveSmart Team";
        
        String smsMessage = "ReserveSmart: Reservation for Table " + tableNumber + " has been cancelled.";

        saveSystemNotification(user, emailMessage);
        emailNotificationService.saveEmailNotification(user, emailMessage);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Cancelled — ReserveSmart", emailMessage);
        smsNotificationService.saveSmsNotification(user, smsMessage);
        smsNotificationService.sendSms(user.getPhone(), smsMessage);
    }

    public void sendReservationConfirmed(User user, String tableNumber,
                                         String date, String time) {
        String emailMessage = "Dear " + user.getFullName() + ",\n\nGreat news! Your reservation for Table " + tableNumber
                + " on " + date + " at " + time + " has been CONFIRMED by the restaurant.\n\nSee you soon!\nReserveSmart Team";
        
        String smsMessage = "ReserveSmart: Reservation for Table " + tableNumber + " on " + date + " at " + time + " is CONFIRMED!";

        saveSystemNotification(user, emailMessage);
        emailNotificationService.saveEmailNotification(user, emailMessage);
        emailNotificationService.sendEmail(user.getEmail(),
                "Reservation Confirmed - ReserveSmart", emailMessage);
        smsNotificationService.saveSmsNotification(user, smsMessage);
        smsNotificationService.sendSms(user.getPhone(), smsMessage);
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