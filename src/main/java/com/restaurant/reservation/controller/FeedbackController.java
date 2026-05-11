package com.restaurant.reservation.controller;

import com.restaurant.reservation.dto.FeedbackDTO;
import com.restaurant.reservation.service.FeedbackService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/feedback")
@RequiredArgsConstructor
public class FeedbackController {
    private final FeedbackService feedbackService;

    @PostMapping("/create")
    public ResponseEntity<String> createFeedback(FeedbackDTO feedbackDTO) {
        String returnMessage = feedbackService.createFeedback(feedbackDTO.getUserId(), feedbackDTO.getContent());
        return ResponseEntity.ok(returnMessage);
    }

    @GetMapping("/all")
    public ResponseEntity<List<FeedbackDTO>> getAllFeedbacks() {
        List<FeedbackDTO> feedbackDTOList = feedbackService.getAllFeedbacks();
        return ResponseEntity.ok(feedbackDTOList);
    }
    @GetMapping("/my/{userId}")
    public ResponseEntity<List<FeedbackDTO>> getMyFeedbacks(
            @PathVariable Long userId,
            @RequestParam(required = false) String keyword) {
        List<FeedbackDTO> feedbackDTOList = feedbackService.getFeedbacksByUserId(userId, keyword);
        return ResponseEntity.ok(feedbackDTOList);
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateFeedback(FeedbackDTO feedbackDTO) {
        try {
            String returnMessage = feedbackService.updateFeedback(feedbackDTO);
            return ResponseEntity.ok(returnMessage);
        } catch (Exception ex) {
            return ResponseEntity.status(401).body(ex.getMessage());
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteFeedback(Long id) {
        try {
            FeedbackDTO feedbackDTO = new FeedbackDTO();
            feedbackDTO.setId(id);

            String returnMessage = feedbackService.deleteFeedback(feedbackDTO);
            return ResponseEntity.ok(returnMessage);
        } catch (RuntimeException ex) {
            return ResponseEntity.status(401).body(ex.getMessage());
        }
    }
}
