package com.example.demo.repository;

import com.example.demo.dto.SpecialRequest;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface specialRequestRepository extends JpaRepository <specialRequestRepository, Long> {
    //all crud operations are included here
    List<SpecialRequest> findByCustomerID(Long CustomerID);
    List<specialRequestRepository> findByCustomerName(Long CustomerName);
}