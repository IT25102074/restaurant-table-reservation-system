package com.reservesmart.controller;

import com.reservesmart.model.User;
import com.reservesmart.service.AnalyticsService;
import com.reservesmart.service.FeedbackService;
import com.reservesmart.service.ReservationService;
// import com.reservesmart.service.TableService;
import com.reservesmart.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

/**
 * OOP: INFORMATION HIDING — AdminController calls services only.
 *
 * OOP: POLYMORPHISM — getDashboardUrl() in User ensures only ADMIN can reach
 * here.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    // @Autowired
    // private TableService tableService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private AnalyticsService analyticsService;

    // Role Guard Helper
    private boolean isAdmin(HttpSession session) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        return loggedIn != null && "ADMIN".equals(loggedIn.getRole());
    }

    // DASHBOARD

    /**
     * Admin dashboard with full analytics summary.
     * OOP: ABSTRACTION — getSummary() hides all calculation logic.
     */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        Map<String, Object> stats = analyticsService.getSummary();
        model.addAttribute("stats", stats);
        model.addAttribute("recentReservations",
                reservationService.getAllReservations().stream()
                        .limit(5).toList());
        model.addAttribute("recentFeedback",
                feedbackService.getAllFeedback().stream()
                        .limit(5).toList());

        return "admin/dashboard";
    }

    // USER MANAGEMENT
    @GetMapping("/users")
    public String manageUsers(@RequestParam(required = false) String keyword,
                              HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("users", userService.searchUsers(keyword));
        model.addAttribute("keyword", keyword);
        return "admin/users";
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        if (!isAdmin(session))
            return "redirect:/login";

        User loggedIn = (User) session.getAttribute("loggedInUser");

        // Admin cannot delete themselves
        if (loggedIn.getUserId().equals(id)) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "You cannot delete your own admin account.");
            return "redirect:/admin/users";
        }

        try {
            userService.deleteAccount(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "User deleted successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/admin/users";
    }
}