package com.kskbl.starpoints.mapper;

import com.kskbl.starpoints.entity.SysUser;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {

    // 插入用户
    @Insert("INSERT INTO sys_user(nick_name, phone_number) VALUES(#{nickName}, #{phoneNumber})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(SysUser user);

    // 查找用户
    @Select("SELECT * FROM sys_user WHERE id = #{id}")
    SysUser selectById(Long id);

}
