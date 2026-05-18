package com.reservesmart.controller;

import com.reservesmart.model.Notification;
import com.reservesmart.model.User;
import com.reservesmart.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Controller
@RequestMapping("/customer/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public String viewNotifications(HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) {
            return "redirect:/login";
        }

        List<Notification> notifications =
                notificationService.getUserNotifications(loggedIn.getUserId());
        long unreadCount = notificationService.countUnread(loggedIn.getUserId());

        model.addAttribute("notifications", notifications);
        model.addAttribute("unreadCount", unreadCount);
        return "customer/notifications";
    }

    @GetMapping("/recent")
    @ResponseBody
    public List<Notification> getRecentNotifications(HttpSession session) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return List.of();
        List<Notification> notifications = notificationService.getUserNotifications(loggedIn.getUserId());
        return notifications.stream().limit(5).toList();
    }

    @PostMapping("/read/{id}")
    public String markAsRead(@PathVariable Long id, HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        try {
            notificationService.markAsRead(id);
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/customer/notifications";
    }

    @PostMapping("/read-all")
    public String markAllAsRead(HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        notificationService.markAllAsRead(loggedIn.getUserId());
        redirectAttributes.addFlashAttribute("successMessage",
                "All notifications marked as read.");
        return "redirect:/customer/notifications";
    }

    @PostMapping("/delete/{id}")
    public String deleteNotification(@PathVariable Long id, HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        try {
            notificationService.deleteNotification(id, loggedIn.getUserId());
            redirectAttributes.addFlashAttribute("successMessage", "Notification deleted.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/customer/notifications";
    }

    @PostMapping("/delete-all")
    public String deleteAll(HttpSession session, RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null) return "redirect:/login";

        notificationService.deleteAllNotifications(loggedIn.getUserId());
        redirectAttributes.addFlashAttribute("successMessage", "All notifications cleared.");
        return "redirect:/customer/notifications";
    }

    @ControllerAdvice
    public static class GlobalNotificationAdvice {
        @Autowired
        private NotificationService notificationService;

        @ModelAttribute
        public void populateUnreadCount(HttpSession session) {
            User loggedInUser = (User) session.getAttribute("loggedInUser");
            if (loggedInUser != null) {
                long unreadCount = notificationService.countUnread(loggedInUser.getUserId());
                session.setAttribute("unreadCount", unreadCount);
            }
        }
    }
}