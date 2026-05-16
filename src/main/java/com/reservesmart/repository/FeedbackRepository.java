package com.reservesmart.repository;

import com.reservesmart.model.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Long> {

    // Customer: view own feedback
    List<Feedback> findByUserUserIdOrderByCreatedAtDesc(Long userId);

    // Admin: view all feedback newest first
    List<Feedback> findAllByOrderByCreatedAtDesc();

    // Admin: filter by rating
    List<Feedback> findByRatingOrderByCreatedAtDesc(int rating);
}