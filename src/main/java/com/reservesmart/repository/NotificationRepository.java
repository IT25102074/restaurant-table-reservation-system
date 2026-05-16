package com.reservesmart.repository;

import com.reservesmart.model.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    // Get all notifications for a user, newest first
    List<Notification> findByUserUserIdOrderByCreatedAtDesc(Long userId);

    // Count unread notifications (used for badge in header)
    long countByUserUserIdAndStatus(Long userId, String status);

    // Get only unread notifications for a user
    List<Notification> findByUserUserIdAndStatusOrderByCreatedAtDesc(
            Long userId, String status);
}