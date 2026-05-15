package com.reservesmart.repository;

import com.reservesmart.model.specialRequestModel;
import com.reservesmart.dto.SpecialRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface specialRequestRepository extends JpaRepository <specialRequestModel, Long> {
    //all crud operations are included here
    //read
    List<specialRequestModel> findByCustomerID(Long CustomerID);


    // List<specialRequestRepository> findByCustomerName(Long CustomerName);
}