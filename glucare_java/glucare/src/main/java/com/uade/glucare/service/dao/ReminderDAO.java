package com.uade.glucare.service.dao;

import java.time.LocalDate;
import java.util.List;

import com.uade.glucare.dto.ReminderDTO;
import com.uade.glucare.model.Reminder;
import com.uade.glucare.repository.ReminderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.stream.Collectors;

@Service
public class ReminderDAO {

    @Autowired
    private ReminderRepository reminderRepository;

    @Transactional(readOnly = true)
    public List<ReminderDTO> findAllByUserId(Long userId) {
        List<Reminder> reminders = reminderRepository.findByUserId(userId);
        return reminders.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ReminderDTO> findAllByUserIdAndDate(Long userId, LocalDate date) {
        List<Reminder> reminders = reminderRepository.findByUserIdAndDate(userId, date);
        return reminders.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    private ReminderDTO convertToDTO(Reminder reminder) {
        ReminderDTO dto = new ReminderDTO();
        dto.setId(reminder.getId());
        dto.setTitle(reminder.getTitle());
        dto.setDescription(reminder.getDescription());
        dto.setDate(reminder.getDate());
        dto.setTime(reminder.getTime());
        dto.setRepeatDays(reminder.getRepeatDays());
        dto.setEtiqueta(reminder.getEtiqueta());
        return dto;
    }
}

