package com.uade.glucare.service;

import java.time.LocalDate;
import java.util.List;
import java.util.OptionalDouble;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.uade.glucare.dto.GlucoseMeasurementDTO;
import com.uade.glucare.model.GlucoseMeasurement;
import com.uade.glucare.model.User;
import com.uade.glucare.repository.userRepository;
import com.uade.glucare.repository.GlucoseMeasurementRepository;

@Service
public class GlucoseMeasurementService {

    @Autowired
    private GlucoseMeasurementRepository glucoseMeasurementRepository;

    @Autowired
    private userRepository userRepository;

    public GlucoseMeasurement saveGlucoseMeasurement(Long userId, GlucoseMeasurement glucoseMeasurement) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        glucoseMeasurement.setUser(user);
        return glucoseMeasurementRepository.save(glucoseMeasurement);
    }

    public List<GlucoseMeasurement> getGlucoseMeasurements(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return glucoseMeasurementRepository.findByUser(user);
    }

    public GlucoseMeasurement updateGlucoseMeasurement(Long measurementId, GlucoseMeasurement glucoseMeasurement) {
        GlucoseMeasurement existingMeasurement = glucoseMeasurementRepository.findById(measurementId)
                .orElseThrow(() -> new RuntimeException("Measurement not found"));
        existingMeasurement.setValue(glucoseMeasurement.getValue());
        existingMeasurement.setDate(glucoseMeasurement.getDate());
        return glucoseMeasurementRepository.save(existingMeasurement);
    }

    @Transactional(readOnly = true)
    public List<GlucoseMeasurement> findAllByUserIdAndDate(Long userId, LocalDate date) {
        List<GlucoseMeasurement> measurements = glucoseMeasurementRepository.findByUserIdAndDate(userId, date);
        return measurements;
    }

    public void deleteGlucoseMeasurement(Long measurementId) {
        glucoseMeasurementRepository.deleteById(measurementId);
    }

    public List<GlucoseMeasurementRepository.DailyAverage> getDailyAverages(Long userId) {
        return glucoseMeasurementRepository.findDailyAveragesByUserId(userId);
    }

    public List<GlucoseMeasurementRepository.WeeklyAverage> getWeeklyAverages(Long userId) {
        return glucoseMeasurementRepository.findWeeklyAveragesByUserId(userId);
    }

    public List<GlucoseMeasurementRepository.MonthlyAverage> getMonthlyAverages(Long userId) {
        return glucoseMeasurementRepository.findMonthlyAveragesByUserId(userId);
    }

}