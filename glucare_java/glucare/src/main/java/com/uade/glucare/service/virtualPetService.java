package com.uade.glucare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.VirtualPetRepository;
import com.uade.glucare.model.VirtualPet;

@Service
public class virtualPetService {
    
    @Autowired
    private VirtualPetRepository virtualPetRepository;
    
    public VirtualPet saveVirtualPet(VirtualPet virtualPet) {
        return virtualPetRepository.save(virtualPet);
    }

}