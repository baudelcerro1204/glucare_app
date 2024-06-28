package com.uade.glucare.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.uade.glucare.model.GlucoseMeasurement;
import com.uade.glucare.model.User;

@Repository
public interface GlucoseMeasurementRepository extends JpaRepository<GlucoseMeasurement, Long> {
    List<GlucoseMeasurement> findByUser(User user);
    List<GlucoseMeasurement> findByUserIdAndDate(Long userId, LocalDate date);
    @Query("SELECT g.date AS date, AVG(g.value) AS averageValue FROM GlucoseMeasurement g WHERE g.user.id = :userId GROUP BY g.date")
    List<DailyAverage> findDailyAveragesByUserId(Long userId);
    @Query("SELECT YEAR(g.date) AS year, WEEK(g.date) AS week, AVG(g.value) AS averageValue FROM GlucoseMeasurement g WHERE g.user.id = :userId GROUP BY YEAR(g.date), WEEK(g.date)")
    List<WeeklyAverage> findWeeklyAveragesByUserId(Long userId);

    @Query("SELECT YEAR(g.date) AS year, MONTH(g.date) AS month, AVG(g.value) AS averageValue FROM GlucoseMeasurement g WHERE g.user.id = :userId GROUP BY YEAR(g.date), MONTH(g.date)")
    List<MonthlyAverage> findMonthlyAveragesByUserId(Long userId);

    @Query("SELECT g FROM GlucoseMeasurement g WHERE g.user.id = :userId ORDER BY g.date, g.time")
    List<GlucoseMeasurement> findAllByUserIdOrderByDateTime(Long userId);

    interface DailyAverage {
        LocalDate getDate();
        double getAverageValue();
    }

    interface WeeklyAverage {
        int getYear();
        int getWeek();
        double getAverageValue();
    }

    interface MonthlyAverage {
        int getYear();
        int getMonth();
        double getAverageValue();
    }
}