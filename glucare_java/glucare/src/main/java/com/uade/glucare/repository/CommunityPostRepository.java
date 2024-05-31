package com.uade.glucare.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uade.glucare.model.CommunityPost;

@Repository
public interface CommunityPostRepository extends JpaRepository<CommunityPost, Long> {
    @SuppressWarnings("null")
    List<CommunityPost> findAll();

    List<CommunityPost> findAllByOrderByDateDesc();
}
