package com.restaurant.reservation.controller;

import com.restaurant.reservation.model.Role;
import com.restaurant.reservation.model.User;
import com.restaurant.reservation.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {

	private static final String SESSION_USER_ID = "loggedInUserId";

	private final UserService userService;

	public UserController(UserService userService) {
		this.userService = userService;
	}

	// ================= REGISTER =================

	@GetMapping("/register")
	public String showRegisterPage() {
		return "register";
	}

	@PostMapping("/register")
	public String register(@RequestParam String username,
						   @RequestParam String password,
						   @RequestParam String confirmPassword,
						   Model model) {

		// password check
		if (!password.equals(confirmPassword)) {
			model.addAttribute("error", "Passwords do not match");
			return "register";
		}

		// username check
		User existingUser = userService.findByUsername(username);

		if (existingUser != null) {
			model.addAttribute("error", "Username already exists");
			return "register";
		}

		// create user
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setRole(Role.USER);

		userService.saveUser(user);

		return "redirect:/users/login";
	}

	// ================= LOGIN =================

	@GetMapping("/login")
	public String showLoginPage() {
		return "login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String username,
						@RequestParam String password,
						HttpSession session,
						Model model) {

		User user = userService.findByUsername(username);

		if (user == null) {
			model.addAttribute("error", "Invalid username or password");
			return "login";
		}

		// simple password check
		// if using encrypted passwords, use PasswordEncoder.matches()
		if (!user.getPassword().equals(password)) {
			model.addAttribute("error", "Invalid username or password");
			return "login";
		}

		session.setAttribute(SESSION_USER_ID, user.getId());

		return "redirect:/";
	}

	// ================= LOGOUT =================

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/users/login";
	}

	// ================= USERS LIST =================

	@GetMapping
	public String getAllUsers(Model model) {

		List<User> users = userService.findAllUsers();

		model.addAttribute("users", users);

		return "users";
	}

	// ================= DELETE USER =================

	@GetMapping("/delete/{id}")
	public String deleteUser(@PathVariable Long id) {

		userService.deleteUser(id);

		return "redirect:/users";
	}

	// ================= EDIT USER =================

	@GetMapping("/edit/{id}")
	public String showEditPage(@PathVariable Long id,
							   Model model) {

		User user = userService.findById(id);

		model.addAttribute("user", user);

		return "edit-user";
	}

	@PostMapping("/update")
	public String updateUser(@ModelAttribute User user) {

		userService.updateUser(user);

		return "redirect:/users";
	}
}