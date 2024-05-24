package com.uade.glucare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.PredictionRepository;
import com.uade.glucare.model.Prediction;

@Service
public class predictionService {

    @Autowired
    private PredictionRepository predictionRepository;

    public Prediction savePrediction(Prediction prediction) {
        return predictionRepository.save(prediction);
    }
    
}
