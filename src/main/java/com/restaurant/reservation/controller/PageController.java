package com.restaurant.reservation.controller;

import com.restaurant.reservation.model.Reservation;
import com.restaurant.reservation.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class PageController {

    private final ReservationService reservationService;

    @Autowired
    public PageController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        
        boolean isAdmin = auth.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .anyMatch(role -> role.equals("ROLE_ADMIN"));
                
        model.addAttribute("username", username);
        model.addAttribute("isAdmin", isAdmin);

        if (isAdmin) {
            List<Reservation> allReservations = reservationService.findAllReservations();
            model.addAttribute("reservations", allReservations);
        } else {
            List<Reservation> myReservations = reservationService.findReservationsByUser(username);
            model.addAttribute("reservations", myReservations);
        }

        return "dashboard";
    }
}
