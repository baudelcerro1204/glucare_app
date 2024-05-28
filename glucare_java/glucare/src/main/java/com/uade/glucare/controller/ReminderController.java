package com.uade.glucare.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.uade.glucare.service.reminderService;
import com.uade.glucare.model.Reminder;
import com.uade.glucare.model.User;
import com.uade.glucare.service.userService;

@RestController
@RequestMapping("/reminders")
public class ReminderController {

    @Autowired
    private reminderService reminderService;

    @Autowired
    private userService userService;

    @PostMapping("/save")
    public Reminder saveReminder(@RequestBody Reminder reminder, @RequestParam String correoElectronico) {
        User user = userService.getUserByCorreoElectronico(correoElectronico);
        if (user == null) {
            throw new RuntimeException("User not found");
        }
        return reminderService.saveReminder(reminder, user);
    }
}
