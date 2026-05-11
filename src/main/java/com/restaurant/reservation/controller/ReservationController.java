package com.restaurant.reservation.controller;

import com.restaurant.reservation.model.Reservation;
import com.restaurant.reservation.service.ReservationService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/reservations")
public class ReservationController {

    private final ReservationService reservationService;

    @Autowired
    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @GetMapping("/new")
    public String showReservationForm(Model model) {
        model.addAttribute("reservation", new Reservation());
        return "reservation";
    }

    @PostMapping("/new")
    public String createReservation(@Valid @ModelAttribute("reservation") Reservation reservation,
                                    BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "reservation";
        }
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        try {
            reservationService.saveReservation(reservation, auth.getName());
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "reservation";
        }
        
        return "redirect:/dashboard?reserved";
    }

    @GetMapping("/edit/{id}")
    public String editReservationForm(@PathVariable("id") Long id, Model model) {
        Reservation reservation = reservationService.findById(id);
        if (reservation == null) {
            return "redirect:/dashboard";
        }
        model.addAttribute("reservation", reservation);
        return "reservation";
    }

    @PostMapping("/update/{id}")
    public String updateReservation(@PathVariable("id") Long id, 
                                    @Valid @ModelAttribute("reservation") Reservation reservation,
                                    BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "reservation";
        }
        reservation.setId(id);
        reservationService.updateReservation(reservation);
        return "redirect:/dashboard?updated";
    }

    @GetMapping("/delete/{id}")
    public String deleteReservation(@PathVariable("id") Long id) {
        reservationService.deleteReservation(id);
        return "redirect:/dashboard?deleted";
    }
}
