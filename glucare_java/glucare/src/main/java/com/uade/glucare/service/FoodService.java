package com.uade.glucare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uade.glucare.model.Food;
import com.uade.glucare.model.User;
import com.uade.glucare.repository.FoodRepository;
import com.uade.glucare.repository.userRepository;

@Service
public class FoodService {
    @Autowired
    private FoodRepository foodRepository;

    @Autowired
    private userRepository userRepository;

    public Food saveFood(Long userId, Food food) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        food.setUser(user);
        return foodRepository.save(food);
    }
}
