package com.kskbl.starpoints.service;

import com.kskbl.starpoints.dto.UserGetInfoDTO;
import com.kskbl.starpoints.dto.UserRegisterDTO;
import com.kskbl.starpoints.entity.SysUser;

public interface UserService {

    // 注册
    SysUser register(UserRegisterDTO dto);

    // 查询信息
    SysUser getInfo(UserGetInfoDTO dto);
}
