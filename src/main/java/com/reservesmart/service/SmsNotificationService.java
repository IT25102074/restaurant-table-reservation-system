package com.reservesmart.service;

import com.reservesmart.model.SmsNotification;
import com.reservesmart.model.User;
import com.reservesmart.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

/**
 * OOP: INHERITANCE — Uses SmsNotification (extends Notification).
 * OOP: POLYMORPHISM — sendNotification() is overridden in SmsNotification.
 * OOP: ENCAPSULATION — SMS sending logic is hidden inside this service.
 *
 * Runs in MOCK mode by default (prints to console).
 * To enable real SMS: set twilio.enabled=true in application.properties.
 */
@Service
public class SmsNotificationService {

    @Value("${twilio.enabled:false}")
    private boolean twilioEnabled;

    @Value("${twilio.account.sid:}")
    private String accountSid;

    @Value("${twilio.auth.token:}")
    private String authToken;

    @Value("${twilio.phone.number:}")
    private String twilioPhone;

    @Autowired
    private NotificationRepository notificationRepository;

    public void sendSms(String toPhone, String message) {

        if (toPhone == null || toPhone.isEmpty()) {
            System.out.println("[SMS] Skipped — no phone number.");
            return;
        }

        if (twilioEnabled) {
            Twilio.init(accountSid, authToken);
            Message.creator(new PhoneNumber("+94" + toPhone),
                new PhoneNumber(twilioPhone), message).create();
            System.out.println("[SMS TWILIO] To: " + toPhone + " | " + message);
        } else {
            System.out.println("[SMS MOCK] To: " + toPhone + " | " + message);
        }
    }

    public void saveSmsNotification(User user, String message) {
        SmsNotification notification =
                new SmsNotification(user, message, user.getPhone());
        notification.sendNotification();
        notificationRepository.save(notification);
    }
}