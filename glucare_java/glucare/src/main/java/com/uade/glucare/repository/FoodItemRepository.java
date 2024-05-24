package com.uade.glucare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.uade.glucare.model.FoodItem;

@Repository
public interface FoodItemRepository extends JpaRepository<FoodItem, Long> {
    
}
