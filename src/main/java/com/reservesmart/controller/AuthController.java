package com.reservesmart.controller;

import com.reservesmart.model.User;
import com.reservesmart.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Handles: Register, Login, Logout
 *
 * OOP: INFORMATION HIDING — Controller calls UserService,
 * never touches UserRepository directly.
 */
@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // Login

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        // If already logged in, redirect to dashboard
        if (session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");
            return "redirect:" + user.getDashboardUrl();
        }
        return "auth/login";
    }

    @PostMapping("/login")
    public String loginSubmit(@RequestParam String emailOrPhone,
                              @RequestParam String password,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        try {
            User user = userService.login(emailOrPhone, password);

            // Store user in session
            session.setAttribute("loggedInUser", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getFullName());

            // OOP: POLYMORPHISM — getDashboardUrl() returns different URL per role
            return "redirect:" + user.getDashboardUrl();

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/login";
        }
    }

    // Register

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");
            return "redirect:" + user.getDashboardUrl();
        }
        return "auth/register";
    }

    @PostMapping("/register")
    public String registerSubmit(@RequestParam String fullName,
                                 @RequestParam String email,
                                 @RequestParam String password,
                                 @RequestParam String phone,
                                 RedirectAttributes redirectAttributes) {
        try {
            userService.registerCustomer(fullName, email, password, phone);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Registration successful! Please login.");
            return "redirect:/login";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/register";
        }
    }

    // Logout

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("successMessage", "Logged out successfully.");
        return "redirect:/login";
    }

    // Root redirect

    @GetMapping("/")
    public String root(HttpSession session) {
        if (session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");
            return "redirect:" + user.getDashboardUrl();
        }
        return "redirect:/login";
    }

    // Forgot Password

    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam String email, RedirectAttributes redirectAttributes) {
        try {
            userService.generatePasswordResetToken(email);
            redirectAttributes.addFlashAttribute("successMessage", "Password reset email sent.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/forgot-password";
    }

    @GetMapping("/reset-password")
    public String resetPasswordPage(@RequestParam(name = "token", required = false) String token, org.springframework.ui.Model model) {
        if (token == null || token.trim().isEmpty()) {
            return "redirect:/login";
        }
        model.addAttribute("token", token);
        return "auth/reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(@RequestParam String token, @RequestParam String newPassword, RedirectAttributes redirectAttributes) {
        try {
            userService.resetPassword(token, newPassword);
            redirectAttributes.addFlashAttribute("successMessage", "Password reset successful. You can now log in.");
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/reset-password?token=" + token;
        }
    }
}