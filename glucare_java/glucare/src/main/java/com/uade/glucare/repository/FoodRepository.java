package com.uade.glucare.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uade.glucare.model.Food;
import com.uade.glucare.model.User;

@Repository
public interface FoodRepository extends JpaRepository<Food, Long> {
    List<Food> findByUserId(Long userId);
    List<Food> findByUserIdAndDate(Long userId, LocalDate date);
}