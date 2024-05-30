package com.uade.glucare.controller.demo;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.uade.glucare.dto.UserDTO;
import com.uade.glucare.model.User;
import com.uade.glucare.service.userService;
import com.uade.glucare.service.dao.UserDAO;


@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private userService userService;

    @Autowired
    private UserDAO userDAO;

    @PutMapping("/update/{id}")
public void updateUser(@PathVariable Long id, @RequestBody UserDTO userDTO) {
     userService.updateUser(id, userDTO);
}

    @GetMapping("/profile/{id}")
    public UserDTO getUser(@PathVariable Long id) {
        return userDAO.findByUserId(id);
    }
    
}
