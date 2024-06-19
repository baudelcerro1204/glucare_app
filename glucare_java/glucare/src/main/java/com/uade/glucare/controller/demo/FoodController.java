package com.uade.glucare.controller.demo;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.uade.glucare.dto.FoodDTO;
import com.uade.glucare.model.Food;
import com.uade.glucare.service.FoodService;
import com.uade.glucare.service.dao.FoodDAO;

@RestController
@RequestMapping("/food")
public class FoodController {
     @Autowired
    private FoodService foodService;

    @Autowired
    private FoodDAO foodDAO;

    @PostMapping("/{userId}")
    public Food saveFood(@PathVariable Long userId,
            @RequestBody Food food) {
        return foodService.saveFood(userId, food);
    }

    @GetMapping("/byDate")
    public List<FoodDTO> getFoodByDate(@RequestParam Long userId, 
                                       @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return foodDAO.findAllByUserIdAndDate(userId, date);
    }
}
