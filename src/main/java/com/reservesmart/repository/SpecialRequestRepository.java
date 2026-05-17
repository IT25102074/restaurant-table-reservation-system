package com.reservesmart.repository;

import com.reservesmart.model.SpecialRequestModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SpecialRequestRepository extends JpaRepository<SpecialRequestModel, Long> {
    //read
    List<SpecialRequestModel> findByCustomerID(Long CustomerID);
}
