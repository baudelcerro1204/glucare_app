package com.uade.glucare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.uade.glucare.model.Prediction;

@Repository
public interface PredictionRepository extends JpaRepository<Prediction, Long> {
}
