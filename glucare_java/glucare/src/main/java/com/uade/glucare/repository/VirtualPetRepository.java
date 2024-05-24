package com.uade.glucare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.uade.glucare.model.VirtualPet;

@Repository
public interface VirtualPetRepository extends JpaRepository<VirtualPet, Long> {
}
