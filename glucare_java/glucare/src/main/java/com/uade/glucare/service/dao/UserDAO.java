package com.uade.glucare.service.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uade.glucare.dto.UserDTO;
import com.uade.glucare.model.User;
import com.uade.glucare.repository.userRepository;

@Service
public class UserDAO {
    
    @Autowired
    private userRepository userRepository;

    public UserDTO findByUserId(Long userId) {
        User user = userRepository.findUserById(userId);
        return convertToDTO(user);
    }

    public static UserDTO convertToDTO(User user) {
        if (user == null) {
            return null;
        }
        
        return new UserDTO(
            user.getNombre(),
            user.getCorreoElectronico(),
            user.getEdad()
        );
    }

}
