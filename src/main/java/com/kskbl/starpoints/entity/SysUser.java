package com.kskbl.starpoints.entity;

import lombok.Data;

@Data
public class SysUser {

    private Integer id;

    private String nickName; // 昵称
    private String phoneNumber; // 手机号
    private String password; // 密码
    private String email; // 邮箱


}
