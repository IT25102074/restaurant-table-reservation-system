package com.restaurant.reservation.controller;

import com.reservesmart.model.User;
import com.reservesmart.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Handles: View profile, Update profile, Delete account
 */
@Controller
@RequestMapping("/profile")
public class UserController {

    @Autowired
    private UserService userService;

    // ─── View Profile ─────────────────────────────────────────────────────────

    @GetMapping
    public String viewProfile(HttpSession session, Model model,
                              RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        try {
            User user = userService.getUserById(loggedIn.getUserId());
            model.addAttribute("user", user);
            return "customer/profile";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/login";
        }
    }

    // ─── Update Profile ───────────────────────────────────────────────────────

    @PostMapping("/update")
    public String updateProfile(@RequestParam String fullName,
                                @RequestParam String phone,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        try {
            User updated = userService.updateProfile(loggedIn.getUserId(), fullName, phone);

            // Refresh session with updated user
            session.setAttribute("loggedInUser", updated);
            session.setAttribute("userName", updated.getFullName());

            redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/profile";
    }

    // ─── Delete Account ───────────────────────────────────────────────────────

    @PostMapping("/delete")
    public String deleteAccount(HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        try {
            userService.deleteAccount(loggedIn.getUserId());
            session.invalidate();
            redirectAttributes.addFlashAttribute("successMessage",
                    "Your account has been deleted.");
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/profile";
        }
    }
}