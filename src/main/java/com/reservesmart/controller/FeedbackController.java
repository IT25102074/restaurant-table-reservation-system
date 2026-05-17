package com.reservesmart.controller;

import com.reservesmart.model.Feedback;
import com.reservesmart.model.User;
import com.reservesmart.service.FeedbackService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;


    // CUSTOMER ROUTES

    /**
     * Customer: view own feedback + submit form on same page.
     */
    @GetMapping("/my")
    public String myFeedback(HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        List<Feedback> feedbackList =
                feedbackService.getMyFeedback(loggedIn.getUserId());
        model.addAttribute("feedbackList", feedbackList);
        return "customer/feedback";
    }

    /**
     * Customer: submit new feedback.
     */
    @PostMapping("/submit")
    public String submitFeedback(@RequestParam String message,
                                 @RequestParam int rating,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            feedbackService.submitFeedback(loggedIn.getUserId(), message, rating);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Thank you! Your feedback has been submitted.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/feedback/my";
    }

    /**
     * Customer: load edit form (pre-fills the form on the same page).
     */
    @GetMapping("/edit/{id}")
    public String editFeedbackForm(@PathVariable Long id,
                                   HttpSession session, Model model,
                                   RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            Feedback feedback = feedbackService.getFeedbackById(id);

            if (!feedback.getUser().getUserId().equals(loggedIn.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "You can only edit your own feedback.");
                return "redirect:/feedback/my";
            }

            List<Feedback> feedbackList =
                    feedbackService.getMyFeedback(loggedIn.getUserId());

            model.addAttribute("feedbackList", feedbackList);
            model.addAttribute("editFeedback", feedback);
            return "customer/feedback";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/feedback/my";
        }
    }

    /**
     * Customer: submit feedback update.
     */
    @PostMapping("/update/{id}")
    public String updateFeedback(@PathVariable Long id,
                                 @RequestParam String message,
                                 @RequestParam int rating,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            feedbackService.updateFeedback(id, loggedIn.getUserId(), message, rating);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Feedback updated successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/feedback/my";
    }

    /**
     * Customer: delete own feedback.
     */
    @PostMapping("/delete/{id}")
    public String deleteFeedback(@PathVariable Long id,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        try {
            feedbackService.deleteFeedback(id, loggedIn.getUserId(),
                    loggedIn.getRole());
            redirectAttributes.addFlashAttribute("successMessage",
                    "Feedback deleted.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        // Redirect based on role
        if ("ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/feedback/admin/list";
        }
        return "redirect:/feedback/my";
    }


    // ADMIN ROUTES


    /**
     * Admin: view all feedback with rating filter.
     */
    @GetMapping("/admin/list")
    public String adminFeedback(@RequestParam(required = false) Integer rating,
                                HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        List<Feedback> feedbackList = feedbackService.filterByRating(rating);
        model.addAttribute("feedbackList", feedbackList);
        model.addAttribute("filterRating", rating);
        return "admin/feedback";
    }
}