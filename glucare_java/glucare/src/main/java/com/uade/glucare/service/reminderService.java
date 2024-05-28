package com.uade.glucare.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.ReminderRepository;
import com.uade.glucare.model.Reminder;
import com.uade.glucare.model.User;

@Service
public class reminderService {

    @Autowired
    private ReminderRepository reminderRepository;

    public Reminder saveReminder(Reminder reminder, User user) {
        // Asigna el usuario al recordatorio
        reminder.setUser(user);
        
        // Añade el recordatorio a la lista de recordatorios del usuario
        user.getRecordatorios().add(reminder);

        // Guarda el recordatorio en el repositorio
        return reminderRepository.save(reminder);
    }
    
}
