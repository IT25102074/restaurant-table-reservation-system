package com.reservesmart.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * OOP: INHERITANCE — Customer inherits all User fields and methods.
 * OOP: POLYMORPHISM — Overrides getDashboardUrl() to return customer dashboard.
 */
@Entity
@DiscriminatorValue("CUSTOMER")
@Getter @Setter
public class Customer extends User {

    // Constructors

    public Customer() {
        super();
        this.setRole("CUSTOMER");
    }

    public Customer(String fullName, String email, String password, String phone) {
        super(fullName, email, password, phone, "CUSTOMER");
    }

    // Overridden Methods

    /**
     * OOP: POLYMORPHISM — Customer-specific dashboard URL.
     */
    @Override
    public String getDashboardUrl() {
        return "/customer/dashboard";
    }

    // Customer-Specific Methods

    public String makeReservation() {
        return "Redirect to reservation form";
    }

    public String cancelReservation() {
        return "Redirect to my reservations";
    }

    public String submitFeedback() {
        return "Redirect to feedback form";
    }
}