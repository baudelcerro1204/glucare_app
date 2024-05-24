package com.uade.glucare.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import com.uade.glucare.model.DiaryEntry;
import com.uade.glucare.service.diaryEntryService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/diaryEntry")
public class DiaryEntryController {

    @Autowired  
    private diaryEntryService diaryEntryService;

    @PostMapping("/add")
    public DiaryEntry addDiaryEntry(@RequestBody DiaryEntry diaryEntry) {
        return diaryEntryService.saveDiaryEntry(diaryEntry);
    }
    
}
