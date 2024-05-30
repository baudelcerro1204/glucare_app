package com.uade.glucare.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.ReminderRepository;
import com.uade.glucare.model.Reminder;
import com.uade.glucare.repository.userRepository;

import jakarta.transaction.Transactional;

import com.uade.glucare.model.User;

@Service
public class reminderService {

    @Autowired
    private ReminderRepository reminderRepository;
    @Autowired
    private userRepository userRepository;

    public Reminder saveReminder(Reminder reminder) {
        // Obtener el usuario autenticado
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User authenticatedUser;

        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            authenticatedUser = userRepository.findByCorreoElectronico(username);
        } else {
            throw new UsernameNotFoundException("User not authenticated");
        }

        // Asigna el usuario al recordatorio
        reminder.setUser(authenticatedUser);

        // Añade el recordatorio a la lista de recordatorios del usuario
        authenticatedUser.getRecordatorios().add(reminder);

        // Guarda el recordatorio en el repositorio
        return reminderRepository.save(reminder);
    }

    @Transactional
    public Reminder updateReminder(Long id, Reminder reminderDetails) {
        Reminder reminder = reminderRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Recordatorio no encontrado con id: " + id));

        reminder.setTitle(reminderDetails.getTitle());
        reminder.setDescription(reminderDetails.getDescription());
        reminder.setDate(reminderDetails.getDate());
        reminder.setTime(reminderDetails.getTime());
        reminder.setRepeatDays(reminderDetails.getRepeatDays());
        reminder.setEtiqueta(reminderDetails.getEtiqueta());

        return reminderRepository.save(reminder);
    }

    public List<Reminder> getReminders() {
        // Obtener el usuario autenticado
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User authenticatedUser;

        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            authenticatedUser = userRepository.findByCorreoElectronico(username);
        } else {
            throw new UsernameNotFoundException("User not authenticated");
        }

        // Devuelve la lista de recordatorios del usuario
        return authenticatedUser.getRecordatorios();
    }
    
}
