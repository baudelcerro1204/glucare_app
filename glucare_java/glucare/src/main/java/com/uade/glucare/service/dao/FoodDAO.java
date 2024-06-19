package com.uade.glucare.service.dao;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.uade.glucare.dto.FoodDTO;
import com.uade.glucare.model.Food;
import com.uade.glucare.repository.FoodRepository;

@Service
public class FoodDAO {
    @Autowired
    private FoodRepository foodRepository;

    @Transactional(readOnly = true)
    public List<FoodDTO> findAllByUserId(Long userId) {
        List<Food> foods = foodRepository.findByUserId(userId);
        return foods.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<FoodDTO> findAllByUserIdAndDate(Long userId, LocalDate date) {
        List<Food> foods = foodRepository.findByUserIdAndDate(userId, date);
        return foods.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    private FoodDTO convertToDTO(Food food) {
        FoodDTO dto = new FoodDTO();
        dto.setNombre(food.getNombre());
        dto.setCalorias(food.getCalorias());
        dto.setProteinas(food.getProteinas());
        dto.setGrasas(food.getGrasas());
        dto.setCarbohidratos(food.getCarbohidratos());
        dto.setDate(food.getDate());
        dto.setTime(food.getTime());
        dto.setUserId(food.getUser().getId());
        return dto;
    }
}
