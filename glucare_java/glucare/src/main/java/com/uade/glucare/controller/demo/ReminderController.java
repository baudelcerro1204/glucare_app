package com.uade.glucare.controller.demo;

import java.time.LocalDate;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
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

    @GetMapping("/byDate")
    public List<ReminderDTO> getRemindersByDate(@RequestParam Long userId, 
                                                @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return reminderDAO.findAllByUserIdAndDate(userId, date);
    }

    @GetMapping("/achievements/{userId}")
    public String getUserAchievements(@PathVariable Long userId) {
        // Lógica para calcular los logros del usuario
        boolean achieved = reminderService.checkUserAchievements(userId);
        return achieved ? "¡Felicidades! Has alcanzado tus objetivos." : "Sigue esforzándote, ¡puedes lograrlo!";
    }

    @GetMapping("/motivational-message/{userId}")
    public String getMotivationalMessage(@PathVariable Long userId) {
        // Lógica para obtener un mensaje motivacional
        List<String> messages = List.of(
            "¡Sigue adelante! Estás haciendo un gran trabajo.",
            "No te rindas, ¡cada paso cuenta!",
            "Recuerda por qué empezaste. ¡Puedes hacerlo!",
            "Tu salud es tu mayor tesoro, cuídala.",
            "Recuerda consultar con un especialista antes de hacer ejercicio!",
            "Cada medición cuenta, sigue así.",
            "La diabetes no te define, tú defines cómo manejarla.",
            "No estás solo en esto, sigue adelante.",
            "Sigue monitoreando y cuidando de ti, lo estás haciendo muy bien.",
            "Cuidar tu diabetes es cuidar tu vida, sigue con ese compromiso."
        );
        Random rand = new Random();
        return messages.get(rand.nextInt(messages.size()));
    }

    @GetMapping("/login-message/{userId}")
    public String getLoginMessage(@PathVariable Long userId) {
        // Lógica para obtener un mensaje único cada vez que el usuario inicie sesión
        List<String> messages = List.of(
            "¡Qué bueno verte de nuevo!",
            "¡Hola de nuevo! ¡Sigue con el buen trabajo!"
        );
        Random rand = new Random();
        return messages.get(rand.nextInt(messages.size()));
    }

    @GetMapping("/check-achievements/{userId}")
    public ResponseEntity<Boolean> checkUserAchievements(@PathVariable Long userId) {
        boolean achieved = reminderService.checkUserAchievements(userId);
        return ResponseEntity.ok(achieved);
    }
}
