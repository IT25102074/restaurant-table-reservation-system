package com.reservesmart.service;

import com.reservesmart.dto.FeedbackDTO;
import com.reservesmart.model.Feedback;
import com.reservesmart.model.User;
import com.reservesmart.repository.FeedbackRepository;
import com.reservesmart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * OOP: ENCAPSULATION — All feedback logic is hidden inside this service.
 * OOP: INFORMATION HIDING — Controller never touches FeedbackRepository directly.
 */
@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    @Autowired
    private UserRepository userRepository;

    //CREATE

    public Feedback submitFeedback(Long userId, String message, int rating) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found."));

        validateFeedback(message, rating);

        Feedback feedback = new Feedback(user, message, rating);

        // OOP: calling method defined in Feedback model
        feedback.submitFeedback();

        return feedbackRepository.save(feedback);
    }

    // READ
    public List<Feedback> getMyFeedback(Long userId) {
        return feedbackRepository.findByUserUserIdOrderByCreatedAtDesc(userId);
    }

    public Feedback getFeedbackById(Long feedbackId) {
        return feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new IllegalArgumentException("Feedback not found."));
    }

    public List<Feedback> getAllFeedback() {
        return feedbackRepository.findAllByOrderByCreatedAtDesc();
    }

    // UPDATE

    public Feedback updateFeedback(Long feedbackId, Long userId,
                                   String message, int rating) {

        Feedback feedback = getFeedbackById(feedbackId);

        // Only owner can update
        if (!feedback.getUser().getUserId().equals(userId)) {
            throw new IllegalArgumentException("You can only edit your own feedback.");
        }

        validateFeedback(message, rating);

        // OOP: calling method defined in Feedback model
        feedback.updateFeedback(message, rating);

        return feedbackRepository.save(feedback);
    }

    //  DELETE

    public void deleteFeedback(Long feedbackId, Long userId, String role) {

        Feedback feedback = getFeedbackById(feedbackId);

        // Customer can only delete own feedback; Admin can delete any
        if (!"ADMIN".equals(role) && !feedback.getUser().getUserId().equals(userId)) {
            throw new IllegalArgumentException("You can only delete your own feedback.");
        }

        feedbackRepository.delete(feedback);
    }

    //  ADMIN: FILTER BY RATING
    public List<Feedback> filterByRating(Integer rating) {
        if (rating == null) return getAllFeedback();
        return feedbackRepository.findByRatingOrderByCreatedAtDesc(rating);
    }

    //  PRIVATE VALIDATION

    /**
     * OOP: ENCAPSULATION — Validation logic hidden inside service.
     * OOP: INFORMATION HIDING — Controller never validates directly.
     */
    private void validateFeedback(String message, int rating) {
        if (message == null || message.trim().isEmpty()) {
            throw new IllegalArgumentException("Feedback message cannot be empty.");
        }
        if (message.trim().length() < 10) {
            throw new IllegalArgumentException("Feedback message must be at least 10 characters.");
        }
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5.");
        }
    }

    // ─── DTO Conversion ─────────────────────────────────────────────────────

    public FeedbackDTO toDTO(Feedback f) {
        FeedbackDTO dto = new FeedbackDTO();
        dto.setFeedbackId(f.getFeedbackId());
        dto.setUserName(f.getUser().getFullName());
        dto.setUserEmail(f.getUser().getEmail());
        dto.setMessage(f.getMessage());
        dto.setRating(f.getRating());
        dto.setCreatedAt(f.getCreatedAt());
        return dto;
    }

    public List<FeedbackDTO> toDTOList(List<Feedback> feedbacks) {
        return feedbacks.stream().map(this::toDTO).collect(Collectors.toList());
    }
}