package com.reservesmart.service;

import com.reservesmart.dto.SpecialRequestResponse;
import com.reservesmart.model.specialRequestModel;
import com.reservesmart.dto.SpecialRequest;
//import com.reservesmart.model.Customer;
//import com.reservesmart.repository.CustomerRepository;
import com.reservesmart.repository.specialRequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor

public class SpecialRequestService {

    private final specialRequestRepository SpecialRequestRepository;

    // FIX 1: parameter type changed from SpecialRequestResponse -> SpecialRequest
    public SpecialRequestResponse submitResponse(SpecialRequest request) {

        //create obj - SR
        specialRequestModel SR = new specialRequestModel();
        SR.setCustomerID(request.getCustomerID());   // FIX 6: set customerID from request
        SR.setRequest(request.getRequest());

        // SR -> db
        specialRequestModel saved = SpecialRequestRepository.save(SR);
        return mapToResponse(saved);
    }

    //all responses from db
    public List<SpecialRequestResponse> getAllRequests() {
        return SpecialRequestRepository.findAll()
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    //responses by customer
    public List<SpecialRequestResponse> getRequestByCusID(Long CustomerID) {
        return SpecialRequestRepository.findByCustomerID(CustomerID)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }


    //delete
    public void deleteSpecialRequest(Long id) {
        SpecialRequestRepository.deleteById(id);
    }

    // update -> .orElseThrow() not mandatory, but a best practice
    public SpecialRequestResponse updateRequest(Long id, SpecialRequest request) {
        specialRequestModel SR1 = SpecialRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Special request not found with id: " + id));
        SR1.setRequest(request.getRequest());

        specialRequestModel updated = SpecialRequestRepository.save(SR1);
        return mapToResponse(updated);
    }


    //mapping logic hiding (abstraction)
    private SpecialRequestResponse mapToResponse(specialRequestModel specialRequest) {
        SpecialRequestResponse response = new SpecialRequestResponse();
        response.setId(specialRequest.getId());
        response.setResponse(specialRequest.getRequest());
        response.setSubmitted(specialRequest.getTime());
        return response;
    }
}

