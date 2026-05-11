package com.restaurant.reservation.controller;

import com.restaurant.reservation.model.Role;
import com.restaurant.reservation.model.User;
import com.restaurant.reservation.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {

    private final UserService userService;

    @Autowired
    public LoginController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") User user,
                               BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "register";
        }
        
        if (userService.findByUsername(user.getUsername()) != null) {
            model.addAttribute("error", "Username is already taken!");
            return "register";
        }
        
        user.setRole(Role.USER); // force role to USER during normal registration
        userService.saveUser(user);
        
        return "redirect:/login?registered";
    }
}
