package com.reservesmart.model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

/**
 * OOP: INHERITANCE — Admin inherits all User fields and methods.
 * OOP: POLYMORPHISM — Overrides getDashboardUrl() to return admin dashboard.
 */
@Entity
@DiscriminatorValue("ADMIN")
@Getter @Setter
public class Admin extends User {

    // Constructors

    public Admin() {
        super();
        this.setRole("ADMIN");
    }

    public Admin(String fullName, String email, String password, String phone) {
        super(fullName, email, password, phone, "ADMIN");
    }

    // Overridden Methods

    /**
     * OOP: POLYMORPHISM — Admin-specific dashboard URL.
     */
    @Override
    public String getDashboardUrl() {
        return "/admin/dashboard";
    }

    //  Admin-Specific Methods
    public String manageUsers() {
        return "Redirect to admin users page";
    }

    public String manageTables() {
        return "Redirect to admin tables page";
    }

    public String manageReservations() {
        return "Redirect to admin reservations page";
    }

    public String viewAnalytics() {
        return "Redirect to admin analytics page";
    }
}