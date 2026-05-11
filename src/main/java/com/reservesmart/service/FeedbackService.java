package com.reservesmart.service;

import com.reservesmart.model.Feedback;
import com.reservesmart.repository.FeedbackRepository;

import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class FeedbackService {
    private final FeedbackRepository feedbackRepository;

    public FeedbackService(FeedbackRepository feedbackRepository) {
        this.feedbackRepository = feedbackRepository;
    }

    public String createFeedback(Long userId, String content) {
        if (content == null || content.isBlank()) {
            throw new IllegalArgumentException("Feedback content is required");
        }
        if (content.length() > 200) {
            throw new IllegalArgumentException("Feedback content must be 200 characters or less");
        }

        Feedback feedback = new Feedback();
        feedback.setUserId(userId);
        feedback.setContent(content.trim());
        feedback.setDateTime(LocalDateTime.now());

        feedbackRepository.save(feedback);
        return "Feedback created successfully";
    }

    public List<Feedback> getAllFeedbacks() {
        return feedbackRepository.findAll();
    }

    public List<Feedback> getFeedbacksByUserId(Long userId, String keyword) {
        List<Feedback> feedbacks = feedbackRepository.findByUserId(userId);

        if (keyword != null && !keyword.isEmpty()) {
            String search = keyword.toLowerCase();
            feedbacks = feedbacks.stream()
                    .filter(feedback -> feedback.getContent() != null &&
                            feedback.getContent().toLowerCase().contains(search))
                    .toList();
        }

        return feedbacks;
    }

    public String updateFeedback(Feedback feedbackRequest) throws Exception {
        validateFeedbackUpdate(feedbackRequest);

        Optional<Feedback> byId = feedbackRepository.findById(feedbackRequest.getId());

        if (byId.isEmpty()) {
            throw new Exception("Feedback is not found");
        }

        Feedback feedback = byId.get();
        feedback.setContent(feedbackRequest.getContent().trim());

        feedbackRepository.save(feedback);
        return "Feedback updated successfully";
    }

    public String updateFeedbackForUser(Long userId, Feedback feedbackRequest) throws Exception {
        validateFeedbackUpdate(feedbackRequest);

        Optional<Feedback> byId = feedbackRepository.findById(feedbackRequest.getId());

        if (byId.isEmpty()) {
            throw new Exception("Feedback is not found");
        }

        Feedback feedback = byId.get();
        if (!Objects.equals(feedback.getUserId(), userId)) {
            throw new SecurityException("You are not allowed to update this feedback");
        }

        feedback.setContent(feedbackRequest.getContent().trim());
        feedbackRepository.save(feedback);
        return "Feedback updated successfully";
    }

    public String deleteFeedback(Long id) throws RuntimeException {
        Optional<Feedback> byId = feedbackRepository.findById(id);

        if (byId.isEmpty()) {
            throw new RuntimeException("Feedback is not found");
        }

        feedbackRepository.delete(byId.get());
        return "Feedback deleted successfully";
    }

    public String deleteFeedbackForUser(Long id, Long userId) {
        Optional<Feedback> byId = feedbackRepository.findById(id);

        if (byId.isEmpty()) {
            throw new RuntimeException("Feedback is not found");
        }

        Feedback feedback = byId.get();
        if (!Objects.equals(feedback.getUserId(), userId)) {
            throw new SecurityException("You are not allowed to delete this feedback");
        }

        feedbackRepository.delete(feedback);
        return "Feedback deleted successfully";
    }

    private void validateFeedbackUpdate(Feedback feedbackRequest) {
        if (feedbackRequest.getId() == null) {
            throw new IllegalArgumentException("Feedback id is required");
        }
        if (feedbackRequest.getContent() == null || feedbackRequest.getContent().isBlank()) {
            throw new IllegalArgumentException("Feedback content is required");
        }
        if (feedbackRequest.getContent().length() > 200) {
            throw new IllegalArgumentException("Feedback content must be 200 characters or less");
        }
    }
}
