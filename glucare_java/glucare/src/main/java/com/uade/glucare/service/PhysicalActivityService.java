package com.uade.glucare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uade.glucare.model.PhysicalActivity;
import com.uade.glucare.model.User;
import com.uade.glucare.repository.PhysicalActivityRepository;
import com.uade.glucare.repository.userRepository;

@Service
public class PhysicalActivityService {
    @Autowired
    private PhysicalActivityRepository physicalActivityRepository;

    @Autowired
    private userRepository userRepository;

    public PhysicalActivity savePhysicalActivity(Long userId, PhysicalActivity physicalActivity) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        physicalActivity.setUser(user);
        return physicalActivityRepository.save(physicalActivity);
    }
}
