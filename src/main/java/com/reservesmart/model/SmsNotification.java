package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * OOP: INHERITANCE — Inherits from Notification.
 * OOP: POLYMORPHISM — Overrides sendNotification() to send SMS.
 * OOP: ENCAPSULATION — receiverPhone is private.
 */
@Entity
@DiscriminatorValue("SMS")
@Getter @Setter
public class SmsNotification extends Notification {

    @Column(name = "receiver_phone")
    private String receiverPhone;

    //  Constructors

    public SmsNotification() {
        super();
    }

    public SmsNotification(User user, String message, String receiverPhone) {
        super(user, message);
        this.receiverPhone = receiverPhone;
    }

    //  Overridden Methods
    /**
     * OOP: POLYMORPHISM — SMS notification sends via Twilio (or mock).
     * Actual sending is done in SmsNotificationService.
     */
    @Override
    public void sendNotification() {
        System.out.println("[SMS NOTIFICATION] To: " + receiverPhone
                + " | Message: " + getMessage());
    }
}