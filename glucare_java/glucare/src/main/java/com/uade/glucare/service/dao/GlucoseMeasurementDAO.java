package com.uade.glucare.service.dao;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.uade.glucare.dto.GlucoseMeasurementDTO;
import com.uade.glucare.model.GlucoseMeasurement;
import com.uade.glucare.repository.GlucoseMeasurementRepository;

@Service
public class GlucoseMeasurementDAO {

    @Autowired
    private GlucoseMeasurementRepository glucoseMeasurementRepository;

    @Transactional(readOnly = true)
    public List<GlucoseMeasurementDTO> findAllByUserIdAndDate(Long userId, LocalDate date) {
        return glucoseMeasurementRepository.findByUserIdAndDate(userId, date).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());

    }

    private GlucoseMeasurementDTO convertToDTO(GlucoseMeasurement glucoseMeasurement) {
        GlucoseMeasurementDTO dto = new GlucoseMeasurementDTO();
        dto.setId(glucoseMeasurement.getId());
        dto.setValue(glucoseMeasurement.getValue());
        dto.setDate(glucoseMeasurement.getDate());
        dto.setTime(glucoseMeasurement.getTime());
        dto.setUserId(glucoseMeasurement.getUser().getId());
        return dto;
    }
}
