package com.example.demo.controller;

import com.example.demo.dto.SpecialRequestResponse;
import com.example.demo.dto.SpecialRequestResponse;
import com.example.demo.model.specialRequestModel;
import com.example.demo.service.SpecialRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/specialRequest")  //change if u need
@RequiredArgsConstructor

public class specialRequestController {
    public final SpecialRequestService specialRequestService;

    //mapping - submit a request
    @PostMapping
    public ResponseEntity<SpecialRequestResponse> submitRequest(@RequestBody specialRequestModel Request) {
        return ResponseEntity.ok(SpecialRequestService.submitRequest(Request));
    }

    //all feedbacks > to admin
    @GetMapping
    public ResponseEntity<List<specialRequestModel>> getAllRequests() {
        return ResponseEntity.ok(SpecialRequestService.getAllRequests());
    }

    //requests by customer > to admin
    @GetMapping("/Customer/{CustomerID}")       //merge ekedi change krnna
    public ResponseEntity<List<specialRequestModel>> getRequestByCus(@PathVariable Long CustomerID) {
        return ResponseEntity.ok(SpecialRequestService.getRequestByCus(CustomerID));
    }
}


//cannot merge cuz