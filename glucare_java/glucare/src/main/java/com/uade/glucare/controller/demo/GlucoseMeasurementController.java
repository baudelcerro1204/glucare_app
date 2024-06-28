package com.uade.glucare.controller.demo;

import com.uade.glucare.dto.GlucoseMeasurementDTO;
import com.uade.glucare.model.GlucoseMeasurement;
import com.uade.glucare.repository.GlucoseMeasurementRepository;
import com.uade.glucare.service.GlucoseMeasurementService;
import com.uade.glucare.service.dao.GlucoseMeasurementDAO;
import com.uade.glucare.service.dao.ReminderDAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/glucose")
public class GlucoseMeasurementController {

    @Autowired
    private GlucoseMeasurementService glucoseMeasurementService;

    @Autowired
    private GlucoseMeasurementDAO glucoseMeasurementDAO;

    @PostMapping("/{userId}")
    public GlucoseMeasurement saveGlucoseMeasurement(@PathVariable Long userId,
            @RequestBody GlucoseMeasurement glucoseMeasurement) {
        return glucoseMeasurementService.saveGlucoseMeasurement(userId, glucoseMeasurement);
    }

    @GetMapping("/{userId}")
    public List<GlucoseMeasurement> getGlucoseMeasurements(@PathVariable Long userId) {
        return glucoseMeasurementService.getGlucoseMeasurements(userId);
    }

    @PutMapping("/{measurementId}")
    public GlucoseMeasurement updateGlucoseMeasurement(@PathVariable Long measurementId,
            @RequestBody GlucoseMeasurement glucoseMeasurement) {
        return glucoseMeasurementService.updateGlucoseMeasurement(measurementId, glucoseMeasurement);
    }

    @GetMapping("/byDate")
    public List<GlucoseMeasurementDTO> getMeasurementsByDate(@RequestParam Long userId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return glucoseMeasurementDAO.findAllByUserIdAndDate(userId, date);
    }

    @DeleteMapping("/{measurementId}")
    public void deleteGlucoseMeasurement(@PathVariable Long measurementId) {
        glucoseMeasurementService.deleteGlucoseMeasurement(measurementId);
    }

    @GetMapping("/daily-average/{userId}")
    public List<GlucoseMeasurementRepository.DailyAverage> getDailyAverages(@PathVariable Long userId) {
        return glucoseMeasurementService.getDailyAverages(userId);
    }

    @GetMapping("/weekly-average/{userId}")
    public List<GlucoseMeasurementRepository.WeeklyAverage> getWeeklyAverages(@PathVariable Long userId) {
        return glucoseMeasurementService.getWeeklyAverages(userId);
    }

    @GetMapping("/monthly-average/{userId}")
    public List<GlucoseMeasurementRepository.MonthlyAverage> getMonthlyAverages(@PathVariable Long userId) {
        return glucoseMeasurementService.getMonthlyAverages(userId);
    }

    @GetMapping("/history/{userId}")
    public List<GlucoseMeasurementDTO> getAllMeasurements(@PathVariable Long userId) {
        return glucoseMeasurementDAO.getAllMeasurements(userId);
    }

}
