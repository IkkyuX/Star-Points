package com.kskbl.starpoints.entity;

import lombok.Data;

@Data
public class PointAccount {

    private Integer id;

    private Integer userId; // 用户id
    private Integer availablePoints; // 可使用积分
    private Integer totalEarnedPoints; // 累计获得积分
    private Integer totalUsedPoints; // 累计使用积分

}
