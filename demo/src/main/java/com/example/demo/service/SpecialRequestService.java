package com.example.demo.service;
import com.example.demo.dto.SpecialRequest;
import com.example.demo.dto.SpecialRequestResponse;
import com.example.demo.repository.specialRequestRepository;
import com.example.demo.dto.SpecialRequest;
import com.example.demo.model.Customer;  // chage at the merge
import com.example.demo.model.specialRequestModel;
import com.example.demo.repository.CustomerRepository; // merge ekedi balala change krnn
import com.example.demo.repository.specialRequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SpecialRequestService {
    private final SpecialRequest SpecialRequest;
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



}
