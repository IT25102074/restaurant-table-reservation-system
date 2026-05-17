package com.reservesmart.controller;

import com.reservesmart.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * Customer controller
 * 
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.reservesmart.service.ReservationService reservationService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");

        // Role guard — only CUSTOMER can access
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        model.addAttribute("user", loggedIn);
        return "customer/dashboard";
    }

    @GetMapping("/special-requests")
    public String viewSpecialRequests(HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        java.util.List<com.reservesmart.model.Reservation> myReservations = reservationService
                .getMyReservations(loggedIn.getUserId())
                .stream()
                .filter(r -> !r.isCancelled())
                .collect(java.util.stream.Collectors.toList());

        model.addAttribute("reservations", myReservations);
        return "customer/special-requests";
    }
}