CREATE DATABASE star_points
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE star_points;
CREATE TABLE sys_user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
    nick_name VARCHAR(20) DEFAULT "未命名用户" COMMENT '昵称',
    password VARCHAR(255) DEFAULT NULL COMMENT '密码',
    phone_number VARCHAR(20) DEFAULT NULL UNIQUE COMMENT '手机号',
    email VARCHAR(255) DEFAULT NULL UNIQUE COMMENT '邮箱',
    status TINYINT DEFAULT 1 COMMENT '账户状态',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'

) COMMENT = '用户表';

CREATE TABLE point_account (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
    user_id BIGINT NOT NULL UNIQUE COMMENT '用户id',
    available_points INT DEFAULT 0 NOT NULL COMMENT '可用余额',
    total_earned_points INT DEFAULT 0 NOT NULL COMMENT '累计获得积分',
    total_used_points INT DEFAULT 0 NOT NULL COMMENT '累计使用积分',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    CONSTRAINT fk_account_user FOREIGN KEY (user_id) REFERENCES sys_user(id)

) COMMENT = '积分账户表';

CREATE TABLE point_txn (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
    user_id BIGINT NOT NULL COMMENT '用户id',
    biz_id BIGINT DEFAULT NULL COMMENT '关联业务id',
    biz_type VARCHAR(50) NOT NULL COMMENT '业务类型',
    change_type TINYINT NOT NULL COMMENT '变动类型 1增加 2减少',
    points INT NOT NULL COMMENT '变动积分',
    balance_after INT NOT NULL COMMENT '变动后余额',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    CONSTRAINT fk_txn_user FOREIGN KEY (user_id) REFERENCES sys_user(id),
    INDEX idx_txn_user_id (user_id),
    INDEX idx_txn_biz_type (biz_type)

) COMMENT = '积分流水表';

CREATE TABLE point_rule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
    rule_name VARCHAR(255) NOT NULL COMMENT '规则名称',
    biz_type VARCHAR(50) NOT NULL UNIQUE COMMENT '规则类型 register / login / ',
    point_value INT NOT NULL DEFAULT 0 COMMENT '奖励积分',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '状态 1启用 0禁用',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'

) COMMENT = '积分规则表';

CREATE TABLE goods (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '商品ID',
    goods_name VARCHAR(255) NOT NULL COMMENT '商品名称',
    goods_type TINYINT NOT NULL COMMENT '商品类型 1实体 2虚拟',
    description TEXT DEFAULT NULL COMMENT '描述',
    point_price INT NOT NULL COMMENT '所需积分',
    stock INT NOT NULL COMMENT '库存',
    image VARCHAR(255) DEFAULT NULL COMMENT '商品图片',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '商品状态 1上架 0下架',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'

) COMMENT='商品表';

CREATE TABLE exchange_orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '订单ID',
    order_no VARCHAR(64) UNIQUE NOT NULL COMMENT '订单号',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    goods_id BIGINT NOT NULL COMMENT '商品ID',
    goods_name VARCHAR(255) NOT NULL COMMENT '商品名称',
    points INT NOT NULL COMMENT '消耗积分',
    status TINYINT NOT NULL DEFAULT 0 COMMENT '订单状态 0未完成 1已完成 2取消',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES sys_user(id),
    CONSTRAINT fk_orders_goods FOREIGN KEY (goods_id) REFERENCES goods(id),
    INDEX idx_orders_user_id (user_id),
    INDEX idx_orders_goods_id (goods_id)

) COMMENT='订单表';