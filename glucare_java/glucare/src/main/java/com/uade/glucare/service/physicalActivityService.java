package com.uade.glucare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.PhysicalActivityRepository;
import com.uade.glucare.model.PhysicalActivity;

@Service
public class physicalActivityService {
    
    @Autowired
    private PhysicalActivityRepository physicalActivityRepository;
    
    public PhysicalActivity savePhysicalActivity(PhysicalActivity physicalActivity) {
        return physicalActivityRepository.save(physicalActivity);
    }

}