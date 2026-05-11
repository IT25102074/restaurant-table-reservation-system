package com.reservesmart.controller;

import com.reservesmart.model.RestaurantTable;
import com.reservesmart.model.User;
import com.reservesmart.service.TableService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class TableController {

    @Autowired
    private TableService tableService;


    // CUSTOMER ROUTES
    /**
     * Customer: view available tables + recommendation
     */
    @GetMapping("/customer/tables")
    public String customerTables(@RequestParam(required = false) Integer guests,
                                 HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"CUSTOMER".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        List<RestaurantTable> availableTables = tableService.getAvailableTables();
        model.addAttribute("tables", availableTables);

        // Table recommendation
        if (guests != null && guests > 0) {
            RestaurantTable recommended = tableService.recommendTable(guests);
            model.addAttribute("recommended", recommended);
            model.addAttribute("guests", guests);
        }

        return "customer/tables";
    }


    // ADMIN ROUTES
    /**
     * Admin: view all tables with search/filter
     */
    @GetMapping("/admin/tables")
    public String adminTables(@RequestParam(required = false) String keyword,
                              @RequestParam(required = false) String status,
                              HttpSession session, Model model) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        List<RestaurantTable> tables = tableService.searchTables(keyword, status);
        model.addAttribute("tables", tables);
        model.addAttribute("keyword", keyword);
        model.addAttribute("filterStatus", status);
        return "admin/tables";
    }

    /**
     * Admin: add new table
     */
    @PostMapping("/admin/tables/add")
    public String addTable(@RequestParam String tableNumber,
                           @RequestParam int capacity,
                           @RequestParam String location,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            tableService.addTable(tableNumber, capacity, location);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Table " + tableNumber + " added successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/admin/tables";
    }

    /**
     * Admin: show edit form
     */
    @GetMapping("/admin/tables/edit/{id}")
    public String editTableForm(@PathVariable Long id,
                                HttpSession session, Model model,
                                RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            RestaurantTable table = tableService.getTableById(id);
            model.addAttribute("table", table);
            return "admin/tables";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/tables";
        }
    }

    /**
     * Admin: update table
     */
    @PostMapping("/admin/tables/update/{id}")
    public String updateTable(@PathVariable Long id,
                              @RequestParam int capacity,
                              @RequestParam String location,
                              @RequestParam String status,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            tableService.updateTable(id, capacity, location, status);
            redirectAttributes.addFlashAttribute("successMessage", "Table updated successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/admin/tables";
    }

    /**
     * Admin: delete table
     */
    @PostMapping("/admin/tables/delete/{id}")
    public String deleteTable(@PathVariable Long id,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User loggedIn = (User) session.getAttribute("loggedInUser");
        if (loggedIn == null || !"ADMIN".equals(loggedIn.getRole())) {
            return "redirect:/login";
        }

        try {
            tableService.deleteTable(id);
            redirectAttributes.addFlashAttribute("successMessage", "Table deleted successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/admin/tables";
    }
}