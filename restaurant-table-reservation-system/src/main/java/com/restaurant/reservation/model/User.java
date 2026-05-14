package com.restaurant.reservation.model;

import jakarta.persistence.*;

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

    //Abstract Methods

    /**
     * OOP: ABSTRACTION — Subclasses must define their own dashboard URL.
     * OOP: POLYMORPHISM — Customer and Admin return different URLs.
     */
    public abstract String getDashboardUrl();

    // Concrete Methods

    public void login() {
        System.out.println(fullName + " logged in.");
    }

    public void logout() {
        System.out.println(fullName + " logged out.");
    }

    public void updateProfile(String fullName, String phone) {
        this.fullName = fullName;
        this.phone = phone;
    }

    //  Getters & Setters

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
