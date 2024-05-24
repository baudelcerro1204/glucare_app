package com.uade.glucare.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.ReminderRepository;
import com.uade.glucare.model.Reminder;

@Service
public class reminderService {

    @Autowired
    private ReminderRepository reminderRepository;

    public Reminder saveReminder(Reminder reminder) {
        return reminderRepository.save(reminder);
    }
    
}
