package com.reservesmart.controller;

import com.reservesmart.model.Reservation;
import com.reservesmart.model.RestaurantTable;
import com.reservesmart.model.User;
// import com.reservesmart.repository.TableRepository;
import com.reservesmart.service.ReservationService;
import com.reservesmart.service.TableService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Controller
@RequestMapping("/reservations")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private TableService tableService;

    // CUSTOMER ROUTES

    /**
     * Show reservation form.
     * Pre-fills tableId if coming from /customer/tables "Book This Table" button.
     */
    @GetMapping("/new")
    public String newReservationForm(@RequestParam(required = false) Long tableId,
            @RequestParam(required = false) Integer guests,
            HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        List<RestaurantTable> availableTables = tableService.getAvailableTables();
        model.addAttribute("tables", availableTables);
        model.addAttribute("preSelectedTableId", tableId);
        model.addAttribute("preSelectedGuests", guests);
        return "customer/reservation-form";
    }

    /**
     * Submit new reservation.
     */
    @PostMapping("/create")
    public String createReservation(
            @RequestParam Long tableId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate reservationDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime reservationTime,
            @RequestParam int guestCount,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            reservationService.createReservation(
                    loggedIn.getUserId(), tableId,
                    reservationDate, reservationTime, guestCount);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Reservation created successfully! Status: PENDING.");
            return "redirect:/reservations/my";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/reservations/new?tableId=" + tableId;
        }
    }

    /**
     * View my reservations.
     */
    @GetMapping("/my")
    public String myReservations(HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        List<Reservation> reservations = reservationService.getMyReservations(loggedIn.getUserId());
        model.addAttribute("reservations", reservations);
        return "customer/my-reservations";
    }

    /**
     * Show edit form for a reservation.
     */
    @GetMapping("/edit/{id}")
    public String editReservationForm(@PathVariable Long id,
            HttpSession session, Model model,
            RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            Reservation reservation = reservationService.getReservationById(id);

            // Security: only owner can edit
            if (!reservation.getUser().getUserId().equals(loggedIn.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "You can only edit your own reservations.");
                return "redirect:/reservations/my";
            }

            if (reservation.isCancelled()) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Cannot edit a cancelled reservation.");
                return "redirect:/reservations/my";
            }

            model.addAttribute("reservation", reservation);
            model.addAttribute("tables", tableService.getAvailableTables());
            return "customer/reservation-form";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/reservations/my";
        }
    }

    /**
     * Submit reservation update.
     */
    @PostMapping("/update/{id}")
    public String updateReservation(
            @PathVariable Long id,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate reservationDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime reservationTime,
            @RequestParam int guestCount,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            reservationService.updateReservation(
                    id, loggedIn.getUserId(),
                    reservationDate, reservationTime, guestCount);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Reservation updated successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/reservations/my";
    }

    /**
     * Cancel reservation.
     */
    @PostMapping("/cancel/{id}")
    public String cancelReservation(@PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            reservationService.cancelReservation(id, loggedIn.getUserId());
            redirectAttributes.addFlashAttribute("successMessage",
                    "Reservation cancelled. Table is now available.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/reservations/my";
    }

    // ADMIN ROUTES

    /**
     * Admin: view all reservations with status filter.
     */

    @GetMapping("/admin/list")
    public String adminReservations(@RequestParam(required = false) String keyword,
            @RequestParam(required = false) String status,
            HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        List<Reservation> reservations = reservationService.searchReservations(keyword, status);
        model.addAttribute("reservations", reservations);
        model.addAttribute("keyword", keyword);
        model.addAttribute("filterStatus", status);
        return "admin/reservations";
    }

    /**
     * Admin: confirm a reservation.
     */
    @PostMapping("/admin/confirm/{id}")
    public String confirmReservation(@PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            reservationService.confirmReservation(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Reservation confirmed successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/reservations/admin/list";
    }

    /**
     * Admin: cancel any reservation.
     */
    @PostMapping("/admin/cancel/{id}")
    public String adminCancelReservation(@PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            Reservation reservation = reservationService.getReservationById(id);
            reservationService.cancelReservation(id,
                    reservation.getUser().getUserId());
            redirectAttributes.addFlashAttribute("successMessage",
                    "Reservation cancelled by admin.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/reservations/admin/list";
    }
}