package com.kskbl.starpoints.controller;

import com.kskbl.starpoints.dto.UserGetInfoDTO;
import com.kskbl.starpoints.dto.UserRegisterDTO;
import com.kskbl.starpoints.entity.SysUser;
import com.kskbl.starpoints.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {


    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public SysUser register(@RequestBody UserRegisterDTO dto) {
        return userService.register(dto);
    }

    @PostMapping("/info")
    public SysUser getInfo(@RequestBody UserGetInfoDTO dto) {
        return userService.getInfo(dto);
    }





}
