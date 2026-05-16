package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * OOP: INHERITANCE — Inherits from Notification.
 * OOP: POLYMORPHISM — Overrides sendNotification() to send Gmail email.
 * OOP: ENCAPSULATION — receiverEmail is private.
 */
@Entity
@DiscriminatorValue("EMAIL")
@Getter @Setter
public class EmailNotification extends Notification {

    @Column(name = "receiver_email")
    private String receiverEmail;

    //  Constructors
    public EmailNotification() {
        super();
    }

    public EmailNotification(User user, String message, String receiverEmail) {
        super(user, message);
        this.receiverEmail = receiverEmail;
    }

    // Overridden Methods
    /**
     * OOP: POLYMORPHISM — Email notification sends via JavaMailSender.
     * Actual sending is done in EmailNotificationService.
     */
    @Override
    public void sendNotification() {
        System.out.println("[EMAIL NOTIFICATION] To: " + receiverEmail
                + " | Message: " + getMessage());
    }
}