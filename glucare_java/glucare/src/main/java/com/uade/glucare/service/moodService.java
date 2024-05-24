package com.uade.glucare.service;

import com.uade.glucare.repository.MoodRepository;
import com.uade.glucare.model.Mood;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class moodService {
    
    @Autowired
    private MoodRepository moodRepository;

    public Mood saveMood(Mood mood) {
        return moodRepository.save(mood);
    }

}
