package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;

/**
 * OOP: ENCAPSULATION — Feedback fields are private.
 * OOP: ASSOCIATION — Feedback belongs to one User.
 */
@Entity
@Table(name = "feedback")
@Getter @Setter
public class Feedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long feedbackId;

    // OOP: ASSOCIATION — Many feedbacks belong to one User
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "message", nullable = false, columnDefinition = "TEXT")
    private String message;

    @Column(name = "rating", nullable = false)
    private int rating;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    //Constructors ──

    public Feedback() {
        this.createdAt = LocalDateTime.now();
    }

    public Feedback(User user, String message, int rating) {
        this.user = user;
        this.message = message;
        this.rating = rating;
        this.createdAt = LocalDateTime.now();
    }

    // Business Logic Methods

    public void submitFeedback() {
        System.out.println("Feedback submitted by: " + user.getFullName());
    }

    public void updateFeedback(String newMessage, int newRating) {
        this.message = newMessage;
        this.rating = newRating;
    }

    public void deleteFeedback() {
        System.out.println("Feedback deleted.");
    }

    public boolean isPositive() {
        return this.rating >= 4;
    }
}