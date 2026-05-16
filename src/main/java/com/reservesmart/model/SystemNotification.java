package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * OOP: INHERITANCE — Inherits from Notification.
 * OOP: POLYMORPHISM — Overrides sendNotification() for in-app display.
 */
@Entity
@DiscriminatorValue("SYSTEM")
@Getter @Setter
public class SystemNotification extends Notification {

    // Constructors

    public SystemNotification() {
        super();
    }

    public SystemNotification(User user, String message) {
        super(user, message);
    }

    // Overridden Methods

    /**
     * OOP: POLYMORPHISM — System notification is saved to DB and shown in UI.
     */
    @Override
    public void sendNotification() {
        // Saved in DB by NotificationService — displayed in customer/notifications.jsp
        System.out.println("[SYSTEM NOTIFICATION] To: "
                + getUser().getFullName() + " | Message: " + getMessage());
    }
}