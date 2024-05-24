package com.uade.glucare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.DiaryEntryRepository;
import com.uade.glucare.model.DiaryEntry;

@Service
public class diaryEntryService {
    
    @Autowired
    private DiaryEntryRepository diaryEntryRepository;
    
    public DiaryEntry saveDiaryEntry(DiaryEntry diaryEntry) {
        return diaryEntryRepository.save(diaryEntry);
    }

}

