package com.reservesmart.service;

import com.reservesmart.model.EmailNotification;
import com.reservesmart.model.User;
import com.reservesmart.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

/**
 * OOP: INHERITANCE — Uses EmailNotification (extends Notification).
 * OOP: POLYMORPHISM — sendNotification() is overridden in EmailNotification.
 * OOP: ENCAPSULATION — Gmail SMTP logic is hidden inside this service.
 */
@Service
public class EmailNotificationService {

    @Autowired(required = false)
    private JavaMailSender mailSender;

    @Autowired
    private NotificationRepository notificationRepository;

    /**
     * Sends a Gmail email notification.
     * If mailSender is not configured, logs to console (mock mode).
     */
    public void sendEmail(String toEmail, String subject, String message) {

        if (toEmail == null || toEmail.isEmpty()) {
            System.out.println("[EMAIL] Skipped — no email address.");
            return;
        }

        if (mailSender != null) {
            try {
                SimpleMailMessage mail = new SimpleMailMessage();
                mail.setTo(toEmail);
                mail.setSubject(subject);
                mail.setText(message + "\n\n— ReserveSmart Team");
                mailSender.send(mail);
                System.out.println("[EMAIL SENT] To: " + toEmail);
            } catch (Exception e) {
                System.err.println("[EMAIL FAILED] " + e.getMessage());
            }
        } else {
            System.out.println("[EMAIL MOCK] To: " + toEmail
                    + " | Subject: " + subject
                    + " | Message: " + message);
        }
    }

    /**
     * Creates and saves an EmailNotification record in DB.
     * OOP: POLYMORPHISM — EmailNotification overrides sendNotification().
     */
    public void saveEmailNotification(User user, String message) {
        EmailNotification notification =
                new EmailNotification(user, message, user.getEmail());
        notification.sendNotification();
        notificationRepository.save(notification);
    }
}