package com.uade.glucare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.uade.glucare.model.DiaryEntry;

@Repository
public interface DiaryEntryRepository extends JpaRepository<DiaryEntry, Long> {
    
}
