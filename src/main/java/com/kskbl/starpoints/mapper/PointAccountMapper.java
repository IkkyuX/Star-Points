package com.kskbl.starpoints.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PointAccountMapper {


    @Insert("INSERT INTO point_account(user_id, available_points) VALUES(#{usedId}, 0)")
    int insert(Integer userId);

}
