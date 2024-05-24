package com.uade.glucare.service;

import com.uade.glucare.model.Medicine;
import com.uade.glucare.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class medicineService {
    
    @Autowired
    private MedicineRepository medicineRepository;

    public Medicine saveMedicine(Medicine medicine) {
        return medicineRepository.save(medicine);
    }
}
