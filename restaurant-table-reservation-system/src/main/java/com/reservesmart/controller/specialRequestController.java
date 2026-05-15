package com.reservesmart.controller;

import com.reservesmart.dto.SpecialRequest;
import com.reservesmart.dto.SpecialRequestResponse;
import com.reservesmart.model.specialRequestModel;
import com.reservesmart.service.SpecialRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;



@RestController
@RequestMapping("/api/specialRequest")
@RequiredArgsConstructor
public class specialRequestController {

    private final SpecialRequestService specialRequestService;

    // create
    @PostMapping
    public ResponseEntity<SpecialRequestResponse> submitSpecialRequest(@RequestBody SpecialRequest request) {
        return ResponseEntity.ok(specialRequestService.submitResponse(request));
    }

    // read - all requests
    @GetMapping
    public ResponseEntity<List<SpecialRequestResponse>> getAllRequests() {
        return ResponseEntity.ok(specialRequestService.getAllRequests());
    }

    // read - request by customer
    @GetMapping("/Customer/{CustomerID}")
    public ResponseEntity<List<SpecialRequestResponse>> getRequestByCustomer(@PathVariable Long CustomerID) {
        return ResponseEntity.ok(specialRequestService.getRequestByCusID(CustomerID));
    }

    //update > uses dto - SpecialRequestResponse, specialRequestService
    @PutMapping("/{id}")
    public ResponseEntity<SpecialRequestResponse> updateResponse(@PathVariable Long id, @RequestBody SpecialRequest request) {
        return ResponseEntity.ok(specialRequestService.updateRequest(id, request));
    }


    //delete
    @DeleteMapping("/{ID}")
    public ResponseEntity<Void> deleteRequest(@PathVariable Long ID) {
        specialRequestService.deleteSpecialRequest(ID);
        return ResponseEntity.noContent().build();
    }
}
/*public class specialRequestController {

    private final SpecialRequestService specialRequestService;

    //create
    @PostMapping
    public ResponseEntity<List<SpecialRequestResponse>> submitSpecialRequest(@RequestBody SpecialRequest request){
        return ResponseEntity.ok(SpecialRequestService.submitSpecialRequest(request));
    }

    //read - all
    @GetMapping
    public ResponseEntity<List<SpecialRequestResponse>> getAllRequests(){
        return ResponseEntity.ok(SpecialRequestService.getAllRequests());
    }

    //read - by customer
    @GetMapping("/Customer/{CustomerID}")
    public ResponseEntity<List<SpecialRequestResponse>> getRequestByCustomer(@PathVariable Long CustomerID){
        return ResponseEntity.ok(SpecialRequestService.getRequestByCustomer(CustomerID));
    }


    //update
    @PutMapping("/{ID}")
    public ResponseEntity<SpecialRequestResponse> updateResponse(@PathVariable Long id, @RequestBody SpecialRequest request){
        return ResponseEntity.ok(SpecialRequestService.updateResponse(id, request));
    }

    //delete
    @DeleteMapping
    public ResponseEntity<void>deleteRequest(@PathVariable Long ID){
        SpecialRequestService.deleteRequest(ID);
        return ResponseEntity.noContent().build();

    }




    /*public final SpecialRequestService specialRequestService;

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
    }*/
//}


