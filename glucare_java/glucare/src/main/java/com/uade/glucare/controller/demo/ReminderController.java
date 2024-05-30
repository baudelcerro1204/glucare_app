package com.uade.glucare.controller.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.uade.glucare.service.reminderService;
import com.uade.glucare.model.Reminder;
import com.uade.glucare.model.User;
import com.uade.glucare.service.userService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/reminders")
@RequiredArgsConstructor
public class ReminderController {

    @Autowired
    private reminderService reminderService;

    @Autowired
    private userService userService;

    @PostMapping(value = "/save")
    public String saveReminder() {
        return "Reminder saved";
    }
}
