package com.uade.glucare.service.dao;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.uade.glucare.dto.PhysicalActivityDTO;
import com.uade.glucare.model.PhysicalActivity;
import com.uade.glucare.repository.PhysicalActivityRepository;

@Service
public class PhysicalActivityDAO {
    
    @Autowired
    private PhysicalActivityRepository physicalActivityRepository;

    @Transactional(readOnly = true)
    public List<PhysicalActivityDTO> findAllByUserId(Long userId) {
        List<PhysicalActivity> physicalActivities = physicalActivityRepository.findByUserId(userId);
        return physicalActivities.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<PhysicalActivityDTO> findAllByUserIdAndDate(Long userId, LocalDate date) {
        List<PhysicalActivity> physicalActivities = physicalActivityRepository.findByUserIdAndDate(userId, date);
        return physicalActivities.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    private PhysicalActivityDTO convertToDTO(PhysicalActivity physicalActivity) {
        PhysicalActivityDTO dto = new PhysicalActivityDTO();
        dto.setNombre(physicalActivity.getNombre());
        dto.setDate(physicalActivity.getDate());
        dto.setTime(physicalActivity.getTime());
        dto.setUserId(physicalActivity.getUser().getId());
        return dto;
    }
}
