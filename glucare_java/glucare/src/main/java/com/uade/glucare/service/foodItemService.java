package com.uade.glucare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.FoodItemRepository;
import com.uade.glucare.model.FoodItem;

@Service
public class foodItemService {
    
    @Autowired
    private FoodItemRepository foodItemRepository;
    
    public FoodItem saveFoodItem(FoodItem foodItem) {
        return foodItemRepository.save(foodItem);
    }

}
