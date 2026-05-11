package com.restaurant.reservation.controller;

import com.restaurant.reservation.model.Role;
import com.restaurant.reservation.model.User;
import com.restaurant.reservation.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;

    @Autowired
    public AdminController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/users")
    public String listUsers(Model model) {
        List<User> users = userService.findAllUsers();
        model.addAttribute("users", users);
        return "admin_users";
    }

    @GetMapping("/users/edit/{id}")
    public String editUserForm(@PathVariable("id") Long id, Model model) {
        User user = userService.findById(id);
        if (user == null) {
            return "redirect:/admin/users";
        }
        // Blank password for the form so it doesn't show hash
        user.setPassword(""); 
        model.addAttribute("user", user);
        return "admin_user_form";
    }

    @PostMapping("/users/update/{id}")
    public String updateUser(@PathVariable("id") Long id, 
                             @ModelAttribute("user") User user,
                             BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "admin_user_form";
        }
        user.setId(id);
        userService.updateUser(user);
        return "redirect:/admin/users?updated";
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id) {
        userService.deleteUser(id);
        return "redirect:/admin/users?deleted";
    }
}
