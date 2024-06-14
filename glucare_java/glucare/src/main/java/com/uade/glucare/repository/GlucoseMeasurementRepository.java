package com.uade.glucare.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uade.glucare.model.GlucoseMeasurement;
import com.uade.glucare.model.User;

@Repository
public interface GlucoseMeasurementRepository extends JpaRepository<GlucoseMeasurement, Long> {
    List<GlucoseMeasurement> findByUser(User user);
    List<GlucoseMeasurement> findByUserIdAndDate(Long userId, LocalDate date);
}