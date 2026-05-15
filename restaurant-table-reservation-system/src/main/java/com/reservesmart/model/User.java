package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * OOP: ABSTRACTION — User is an abstract class. Cannot be instantiated directly.
 * OOP: ENCAPSULATION — All fields are private with getters/setters.
 * OOP: INHERITANCE — Customer and Admin inherit from this class.
 */
@Entity
@Table(name = "users")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "dtype", discriminatorType = DiscriminatorType.STRING)
@Getter @Setter
public abstract class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "phone")
    private String phone;

    @Column(name = "role", nullable = false)
    private String role;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "reset_token")
    private String resetToken;

    @Column(name = "reset_token_expiry")
    private LocalDateTime resetTokenExpiry;

    // Constructors

    public User() {
        this.createdAt = LocalDateTime.now();
    }

    public User(String fullName, String email, String password, String phone, String role) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = role;
        this.createdAt = LocalDateTime.now();
    }

    // ─── Abstract Methods

    /**
     * OOP: ABSTRACTION — Subclasses must define their own dashboard URL.
     * OOP: POLYMORPHISM — Customer and Admin return different URLs.
     */
    public abstract String getDashboardUrl();

    // ─── Concrete Methods ─────────────────────────────────────────────────────

    public void login() {
        System.out.println(fullName + " logged in.");
    }

    public void logout() {
        System.out.println(fullName + " logged out.");
    }

    public void updateProfile(String fullName, String email, String phone) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
    }
}