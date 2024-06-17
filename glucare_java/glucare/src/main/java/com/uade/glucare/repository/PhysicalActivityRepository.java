package com.uade.glucare.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uade.glucare.model.PhysicalActivity;
import com.uade.glucare.model.User;

@Repository
public interface PhysicalActivityRepository extends JpaRepository<PhysicalActivity, Long> {
    List<PhysicalActivity> findByUserId(Long userId);
    List<PhysicalActivity> findByUserIdAndDate(Long userId, LocalDate date);
}