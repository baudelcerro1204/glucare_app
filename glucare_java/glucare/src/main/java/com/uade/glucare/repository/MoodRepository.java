package com.uade.glucare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.uade.glucare.model.Mood;

@Repository
public interface MoodRepository extends JpaRepository<Mood, Long> {
}
