package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.time.LocalDateTime;

/**
 * OOP: ABSTRACTION — Notification is abstract. sendNotification() must be overridden.
 * OOP: INHERITANCE — SystemNotification, EmailNotification, SmsNotification inherit this.
 * OOP: ENCAPSULATION — Fields are private.
 */
@Entity
@Table(name = "notifications")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "notification_type", discriminatorType = DiscriminatorType.STRING)
@Getter @Setter
public abstract class Notification {

    // Notification status constants
    public static final String STATUS_UNREAD = "UNREAD";
    public static final String STATUS_READ   = "READ";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long notificationId;

    // OOP: ASSOCIATION — Notification belongs to one User
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @JsonIgnore
    private User user;

    @Column(name = "message", nullable = false)
    private String message;

    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    //  Constructors

    public Notification() {
        this.status = STATUS_UNREAD;
        this.createdAt = LocalDateTime.now();
    }

    public Notification(User user, String message) {
        this.user = user;
        this.message = message;
        this.status = STATUS_UNREAD;
        this.createdAt = LocalDateTime.now();
    }

    //Abstract Methods

    /**
     * OOP: POLYMORPHISM — Each subclass sends notification differently.
     * OOP: ABSTRACTION — Subclasses must implement this.
     */
    public abstract void sendNotification();

    // Concrete Methods

    public void markAsRead() {
        this.status = STATUS_READ;
    }

    public boolean isUnread() {
        return STATUS_UNREAD.equals(this.status);
    }
}