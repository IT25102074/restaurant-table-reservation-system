package com.reservesmart.service;

import com.reservesmart.dto.SpecialRequestResponseDTO;
import com.reservesmart.model.Reservation;
import com.reservesmart.model.SpecialRequestModel;
import com.reservesmart.dto.SpecialRequestDTO;
import com.reservesmart.repository.ReservationRepository;
import com.reservesmart.repository.SpecialRequestRepository;
import com.reservesmart.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SpecialRequestService {

    private final SpecialRequestRepository specialRequestRepository;
    private final ReservationRepository reservationRepository;
    private final NotificationService notificationService;

    public SpecialRequestResponseDTO submitResponse(SpecialRequestDTO request) {

        Reservation reservation = reservationRepository.findById(request.getReservationId())
                .orElseThrow(() -> new RuntimeException("Reservation not found"));

        if (reservation.isCancelled()){
            throw new RuntimeException("Reservation cancelled");
        }

        //create obj - SR
        SpecialRequestModel SR = new SpecialRequestModel();
        SR.setReservationId(request.getReservationId());
        SR.setCustomerID(reservation.getUser().getUserId());  // customerID from request
        SR.setRequest(request.getRequest());

        // SR -> db
        SpecialRequestModel saved = specialRequestRepository.save(SR);
        
        notificationService.sendSpecialRequestCreated(reservation.getUser(), request.getRequest());
        
        return mapToResponse(saved);
    }

    //all responses from db
    public List<SpecialRequestResponseDTO> getAllRequests() {
        return specialRequestRepository.findAll()
            .stream()
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    //responses by customer
    public List<SpecialRequestResponseDTO> getRequestByCusID(Long CustomerID) {
        return specialRequestRepository.findByCustomerID(CustomerID)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    //delete
    public void deleteSpecialRequest(Long id) {
        specialRequestRepository.deleteById(id);
    }

    // update -> .orElseThrow() not mandatory, but a best practice
    public SpecialRequestResponseDTO updateRequest(Long id, SpecialRequestDTO request) {
        SpecialRequestModel SR1 = specialRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Special request not found with id: " + id));
        SR1.setRequest(request.getRequest());

        SpecialRequestModel updated = specialRequestRepository.save(SR1);
        return mapToResponse(updated);
    }

    public void acceptRequest(Long id) {
        SpecialRequestModel request = specialRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Special request not found with id: " + id));
        request.setStatus("ACCEPTED");
        specialRequestRepository.save(request);

        Reservation reservation = reservationRepository.findById(request.getReservationId())
                .orElseThrow(() -> new RuntimeException("Reservation not found"));
        notificationService.sendSpecialRequestAccepted(reservation.getUser(), request.getRequest());
    }

    public void rejectRequest(Long id) {
        SpecialRequestModel request = specialRequestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Special request not found with id: " + id));
        request.setStatus("REJECTED");
        specialRequestRepository.save(request);

        Reservation reservation = reservationRepository.findById(request.getReservationId())
                .orElseThrow(() -> new RuntimeException("Reservation not found"));
        notificationService.sendSpecialRequestRejected(reservation.getUser(), request.getRequest());
    }

    //mapping logic hiding (abstraction)
    private SpecialRequestResponseDTO mapToResponse(SpecialRequestModel specialRequest) {
        SpecialRequestResponseDTO response = new SpecialRequestResponseDTO();
        response.setId(specialRequest.getId());
        response.setCustomerID(specialRequest.getCustomerID());
        response.setReservationId(specialRequest.getReservationId());  //getting reservationId
        response.setResponse(specialRequest.getRequest());
        response.setSubmitted(specialRequest.getTime());
        response.setStatus(specialRequest.getStatus());
        return response;
    }
}
