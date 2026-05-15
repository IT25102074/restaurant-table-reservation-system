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

    //create obj (SR)
    public SpecialRequestResponse submitResponse(SpecialRequestResponse request) {
        specialRequestModel SR = new specialRequestModel();
        SR.setCustomerID(request.getCustomerID());
        SR.setRequest(request.getResponse());
        SR.setTime(request.getSubmitted());

        //create -> to db
        SR saved = specialRequestRepository.save(SR);
        return mapToResponse(saved);
    }

    //all responses from db
    public List<SpecialRequestResponse> getAllRequests(){
        return SpecialRequestRepository.findAll()
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    //responses bu customer
    public List<SpecialRequestResponse> getRequestByCusID(Long CustomerID){
        return SpecialRequestRepository.findByCustomerID(CustomerID)
                .stream()       //conv to a stream
                .map(this::mapToResponse)
                .collect(Collectors.toList());  //conv stream to list
    }

    //delete
    public void deleteSpecialRequest(Long id){
        SpecialRequestRepository.deleteById(id);
    }

    //update
    public SpecialRequestResponse updateRequest(Long id, SpecialRequest request){   //has string var in dto, if nee, change it to class name
        specialRequestModel SR1 = specialRequestRepository.findByID(id); //didnt put the exception
        SR1.setRequest(request.getRequest());

        specialRequestModel updated = specialRequestRepository.save(SR1);
        return mapToResponse(updated);
    }

    //mapping logic hiding
    private SpecialRequestResponse mapToResponse(specialRequestModel specialRequest){
        SpecialRequestResponse response = new SpecialRequestResponse();
        response.setId(specialRequest.getId()); //from model, not from the dto (same name, only c/s changes)
        response.setResponse(specialRequest.getRequest());
        response.setSubmitted(specialRequest.getTime());

        return response;//from model class, not from the dto
    }


   /* private final SpecialRequest SpecialRequest;
    private final CustomerRepository CusotmerRepository; //merge ekedi change krnn
    private final specialRequestRepository specialRequestRepository;

    public Object submitSpecialRequest(SpecialRequest specialRequest){
        Customer customer = customerRepository.findById(request.getCustomerId())
                .orElseThrow(() -> new RuntimeException("Customer not found")); //mek sample ekk merge ekedi change krnn


        SpecialRequest request = new SpecialRequest();
        request.setCustomer(customer);   // change krnn pancho
        request.setRequest(specialRequest.getRequest());
        //isaccepted - try to implement

        return specialRequestRepository.save(request);


        //mapping entity to dto (response)
        SpecialRequestResponse response = new SpecialRequestResponse();
        response.setId(saved.getID());
        response.setResponse(saved.getResponse());
        response.setSubmitted(saved.getSubmitted());

        return response;
    }

    //SpecialREquest only - unidentified error
    public List<specialRequestRepository> getSpecialRequestAll(){
        return specialRequestRepository.findAll();
    }

    public List<SpecialRequest> getSpecialRequestByCustomer(Long CustomerID){
        return specialRequestRepository.findByCustomerID(CustomerID);
    }

*/

}
