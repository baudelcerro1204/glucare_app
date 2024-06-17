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

import com.uade.glucare.dto.PhysicalActivityDTO;
import com.uade.glucare.model.PhysicalActivity;
import com.uade.glucare.service.PhysicalActivityService;
import com.uade.glucare.service.dao.PhysicalActivityDAO;

@RestController
@RequestMapping("/activity")
public class PhysicalActivityController {
    @Autowired
    private PhysicalActivityService physicalActivityService;

    @Autowired
    private PhysicalActivityDAO physicalActivityDAO;

    @PostMapping("/{userId}")
    public PhysicalActivity savePhysicalActivity(@PathVariable Long userId,
            @RequestBody PhysicalActivity physicalActivity) {
        return physicalActivityService.savePhysicalActivity(userId, physicalActivity);
    }

    @GetMapping("/byDate")
    public List<PhysicalActivityDTO> getPhysicalActivityByDate(@RequestParam Long userId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return physicalActivityDAO.findAllByUserIdAndDate(userId, date);
    }

}
