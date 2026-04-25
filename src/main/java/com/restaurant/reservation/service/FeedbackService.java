package com.restaurant.reservation.service;

import com.restaurant.reservation.dto.FeedbackDTO;
import com.restaurant.reservation.model.Feedback;
import com.restaurant.reservation.repository.FeedbackRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FeedbackService {
    private final FeedbackRepository feedbackRepository;

    public String createFeedback(Long userId, String content) {
        Feedback feedback = new Feedback();
        feedback.setUserId(userId);
        feedback.setContent(content);
        feedback.setDateTime(LocalDateTime.now());

        feedbackRepository.save(feedback);
        return "Feedback created successfully";
    }

    public List<FeedbackDTO> getAllFeedbacks() {
        List<Feedback> feedbacks = feedbackRepository.findAll();

        return feedbacks.stream().map(feedback -> {
            FeedbackDTO feedbackDTO = new FeedbackDTO();
            feedbackDTO.setId(feedback.getId());
            feedbackDTO.setContent(feedback.getContent());
            feedbackDTO.setUserId(feedback.getUserId());
            feedbackDTO.setDatetime(feedback.getDateTime());
            return feedbackDTO;
        }).toList();
    }

    public List<FeedbackDTO> getFeedbacksByUserId(Long userId, String keyword) {
        List<Feedback> feedbacks = feedbackRepository.findByUserId(userId);

        if (keyword != null && !keyword.isEmpty()) {
            feedbacks = feedbacks.stream()
                    .filter(feedback -> feedback.getContent().toLowerCase().contains(keyword.toLowerCase()))
                    .toList();
        }

        return feedbacks.stream().map(feedback -> {
            FeedbackDTO feedbackDTO = new FeedbackDTO();
            feedbackDTO.setId(feedback.getId());
            feedbackDTO.setContent(feedback.getContent());
            feedbackDTO.setUserId(feedback.getUserId());
            feedbackDTO.setDatetime(feedback.getDateTime());
            return feedbackDTO;
        }).toList();
    }


    public String updateFeedback(FeedbackDTO feedbackDTO) throws Exception {
        Optional<Feedback> byId = feedbackRepository.findById(feedbackDTO.getId());

        if (byId.isEmpty()) {
            throw new Exception("Feedback is not found");
        }

        Feedback feedback = byId.get();
        feedback.setContent(feedbackDTO.getContent());

        feedbackRepository.save(feedback);
        return "Feedback updated successfully";
    }

    public String deleteFeedback(FeedbackDTO feedbackDTO) throws RuntimeException {
        Optional<Feedback> byId = feedbackRepository.findById(feedbackDTO.getId());

        if (byId.isEmpty()) {
            throw new RuntimeException("Feedback is not found");
        }

        feedbackRepository.delete(byId.get());
        return "Feedback deleted successfully";
    }
}
