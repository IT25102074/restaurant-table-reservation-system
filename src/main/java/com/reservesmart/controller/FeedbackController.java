package com.reservesmart.controller;

import com.reservesmart.model.Feedback;
import com.reservesmart.service.FeedbackService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/feedback")
public class FeedbackController {
    private final FeedbackService feedbackService;

    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    private Long getSessionUserId(HttpSession session) {
        Object userId = session.getAttribute("loggedInUser");
        if (userId instanceof Long id) {
            return id;
        }
        if (userId instanceof Integer id) {
            return id.longValue();
        }
        return null;
    }

    private boolean isAdmin(HttpSession session) {
        Object role = session.getAttribute("userRole");
        return role != null && "ADMIN".equalsIgnoreCase(role.toString());
    }

    @PostMapping("/create")
    public ResponseEntity<String> createFeedback(@RequestBody Feedback feedback, HttpSession session) {
        Long sessionUserId = getSessionUserId(session);
        if (sessionUserId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please login first");
        }

        String returnMessage = feedbackService.createFeedback(sessionUserId, feedback.getContent());
        return ResponseEntity.ok(returnMessage);
    }

    @GetMapping("/all")
    public ResponseEntity<List<Feedback>> getAllFeedbacks(HttpSession session) {
        if (!isAdmin(session)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        List<Feedback> feedbackList = feedbackService.getAllFeedbacks();
        return ResponseEntity.ok(feedbackList);
    }

    @GetMapping("/my")
    public ResponseEntity<List<Feedback>> getMyFeedbacks(
            @RequestParam(required = false) Long userId,
            @RequestParam(required = false) String keyword,
            HttpSession session) {
        Long sessionUserId = getSessionUserId(session);
        if (sessionUserId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Long effectiveUserId = sessionUserId;
        if (isAdmin(session) && userId != null) {
            effectiveUserId = userId;
        }

        List<Feedback> feedbackList = feedbackService.getFeedbacksByUserId(effectiveUserId, keyword);
        return ResponseEntity.ok(feedbackList);
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateFeedback(@RequestBody Feedback feedback, HttpSession session) {
        Long sessionUserId = getSessionUserId(session);
        if (sessionUserId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please login first");
        }

        try {
            String returnMessage = isAdmin(session)
                    ? feedbackService.updateFeedback(feedback)
                    : feedbackService.updateFeedbackForUser(sessionUserId, feedback);
            return ResponseEntity.ok(returnMessage);
        } catch (SecurityException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ex.getMessage());
        } catch (Exception ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteFeedback(@PathVariable Long id, HttpSession session) {
        Long sessionUserId = getSessionUserId(session);
        if (sessionUserId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please login first");
        }

        try {
            String returnMessage = isAdmin(session)
                    ? feedbackService.deleteFeedback(id)
                    : feedbackService.deleteFeedbackForUser(id, sessionUserId);
            return ResponseEntity.ok(returnMessage);
        } catch (SecurityException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }
}
