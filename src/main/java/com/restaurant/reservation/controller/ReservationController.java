package com.restaurant.reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class ReservationController {

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @PostMapping("/reserve")
    public String reserve(
            @RequestParam String name,
            @RequestParam String date,
            @RequestParam String time,
            @RequestParam int people,
            @RequestParam String phoneNumber,
            @RequestParam String specialRequest
    ) {

        System.out.println("Name: " + name);
        System.out.println("Date: " + date);
        System.out.println("Time: " + time);
        System.out.println("People: " + people);
        System.out.println("Phone: " + phoneNumber);
        System.out.println("Special Request: " + specialRequest);

        return "redirect:/";
    }
}