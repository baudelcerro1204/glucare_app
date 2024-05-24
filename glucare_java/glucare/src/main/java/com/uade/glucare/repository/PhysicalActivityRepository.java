package com.uade.glucare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.uade.glucare.model.PhysicalActivity;

@Repository
public interface PhysicalActivityRepository extends JpaRepository<PhysicalActivity, Long> {
}
