package com.uade.glucare.repository;
import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.uade.glucare.model.User;

@Repository
public interface userRepository extends JpaRepository<User, Long>{
    
    User findByCorreoElectronico(String correoElectronico);
    ArrayList<User> findAll();
    User findByNombre(String nombre);

    @Transactional
    void deleteByCorreoElectronico(String correoElectronico);
    
}
