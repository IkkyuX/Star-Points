package com.kskbl.starpoints.service.impl;

import com.kskbl.starpoints.dto.UserGetInfoDTO;
import com.kskbl.starpoints.dto.UserRegisterDTO;
import com.kskbl.starpoints.entity.SysUser;
import com.kskbl.starpoints.mapper.PointAccountMapper;
import com.kskbl.starpoints.mapper.UserMapper;
import com.kskbl.starpoints.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PointAccountMapper pointAccountMapper;

    @Override
    public SysUser register(UserRegisterDTO dto) {

        // 创建用户信息
        SysUser user = new SysUser();
        user.setNickName(dto.getNickName());
        user.setPhoneNumber(dto.getPhoneNumber());
        user.setPassword(dto.getPassword());

        // 新增用户
        userMapper.insert(user);

        // 初始化积分账户
        pointAccountMapper.insert(user.getId());


        return user;

    }

    @Override
    public SysUser getInfo(UserGetInfoDTO dto) {

        return userMapper.selectById(dto.getId());

    }



}
