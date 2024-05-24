package com.uade.glucare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.uade.glucare.model.Medicine;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {
}
