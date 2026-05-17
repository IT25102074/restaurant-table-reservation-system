package com.reservesmart.controller;

import com.reservesmart.dto.SpecialRequestDTO;
import com.reservesmart.dto.SpecialRequestResponseDTO;
import com.reservesmart.service.SpecialRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/SpecialRequest")
@RequiredArgsConstructor
public class SpecialRequestController {

    private final SpecialRequestService specialRequestService;

    // create
    @PostMapping
    public ResponseEntity<SpecialRequestResponseDTO> submitSpecialRequest(@RequestBody SpecialRequestDTO request) {
        return ResponseEntity.ok(specialRequestService.submitResponse(request));
    }

    // read - all requests
    @GetMapping
    public ResponseEntity<List<SpecialRequestResponseDTO>> getAllRequests() {
        return ResponseEntity.ok(specialRequestService.getAllRequests());
    }

    // read - request by customer
    @GetMapping("/Customer/{CustomerID}")
    public ResponseEntity<List<SpecialRequestResponseDTO>> getRequestByCustomer(@PathVariable Long CustomerID) {
        return ResponseEntity.ok(specialRequestService.getRequestByCusID(CustomerID));
    }

    //update > uses dto - SpecialRequestResponse, specialRequestService
    @PutMapping("/{id}")
    public ResponseEntity<SpecialRequestResponseDTO> updateResponse(@PathVariable Long id, @RequestBody SpecialRequestDTO request) {
        return ResponseEntity.ok(specialRequestService.updateRequest(id, request));
    }

    // accept
    @PatchMapping("/{id}/accept")
    public ResponseEntity<Void> acceptRequest(@PathVariable Long id) {
        specialRequestService.acceptRequest(id);
        return ResponseEntity.ok().build();
    }

    // reject
    @PatchMapping("/{id}/reject")
    public ResponseEntity<Void> rejectRequest(@PathVariable Long id) {
        specialRequestService.rejectRequest(id);
        return ResponseEntity.ok().build();
    }

    //delete
    @DeleteMapping("/{ID}")
    public ResponseEntity<Void> deleteRequest(@PathVariable Long ID) {
        specialRequestService.deleteSpecialRequest(ID);
        return ResponseEntity.noContent().build();
    }
}
