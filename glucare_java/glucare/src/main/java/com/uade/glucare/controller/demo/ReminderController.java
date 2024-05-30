package com.uade.glucare.controller.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.uade.glucare.service.reminderService;
import com.uade.glucare.dto.ReminderDTO;
import com.uade.glucare.model.Reminder;
import com.uade.glucare.model.User;
import com.uade.glucare.service.userService;
import com.uade.glucare.service.dao.ReminderDAO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/reminders")
@RequiredArgsConstructor
public class ReminderController {

    @Autowired
    private reminderService reminderService;

    @Autowired
    private ReminderDAO reminderDAO;

    @Autowired
    private userService userService;

    @PostMapping(value = "/save")
    public void saveReminder(@RequestBody Reminder reminder) {
        reminderService.saveReminder(reminder);
    }

    @PutMapping(value = "/update/{id}")
    public void updateReminder(@PathVariable Long id, @RequestBody Reminder reminderDetails) {
        reminderService.updateReminder(id, reminderDetails);
    }

    @DeleteMapping(value = "/delete/{id}")
    public void deleteReminder(@PathVariable Long id) {
        reminderService.deleteReminder(id);
    }

    @GetMapping(value = "/getAll")
    public List<ReminderDTO> getReminders(@RequestParam Long userId) {
        return reminderDAO.findAllByUserId(userId);
    }
}
