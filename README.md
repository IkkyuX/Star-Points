# Star Points

一个基于 Spring Boot + MyBatis + MySQL 的积分系统项目，用于实现用户注册、积分账户管理、积分流水记录、积分商城商品管理与积分兑换订单等核心能力。

## 项目目标

本项目当前定位为一个最小可运行的 MVP（Minimum Viable Product），优先完成积分系统的核心业务闭环：

- 用户注册
- 初始化积分账户
- 查询用户信息
- 商品管理
- 积分发放与流水记录
- 积分兑换商品
- 生成兑换订单

## 技术栈

- Java 17
- Spring Boot
- MyBatis / MyBatis-Plus（视当前代码实现而定）
- MySQL 8.x
- Lombok
- Validation
- Swagger / SpringDoc OpenAPI
- Maven

## 项目结构

```text
starpoints
├── database                 # 数据库脚本
│   └── star_points.sql
├── doc                      # 项目文档
├── src
│   ├── main
│   │   ├── java/com/kskbl/starpoints
│   │   │   ├── controller   # 接口层
│   │   │   ├── dto          # 请求参数对象
│   │   │   ├── entity       # 实体类
│   │   │   ├── mapper       # 数据访问层
│   │   │   ├── service      # 业务接口
│   │   │   └── service/impl # 业务实现
│   │   └── resources
│   │       └── application.yaml
│   └── test
└── pom.xml
```

## 当前数据库设计

当前 MVP 数据库包含以下核心表：

- `sys_user`：用户表
- `point_account`：积分账户表
- `point_txn`：积分流水表
- `point_rule`：积分规则表
- `goods`：商品表
- `exchange_orders`：兑换订单表

数据库脚本位置：

```text
/database/star_points.sql
```

## 当前已实现/规划模块

### 1. 用户模块
- 用户注册
- 查询用户详情

### 2. 积分模块
- 初始化积分账户
- 查询积分账户
- 查询积分流水
- 手动增加积分（建议作为测试接口）

### 3. 商品模块
- 商品新增
- 商品列表
- 商品详情

### 4. 订单模块
- 积分兑换商品
- 查询用户订单
- 查询订单详情

## 推荐 MVP 接口清单

### 用户接口
- `POST /user/register` 用户注册
- `GET /user/info?userId=1` 查询用户详情

### 积分接口
- `GET /point/account/{userId}` 查询积分账户
- `POST /point/add` 增加积分
- `GET /point/txn/{userId}` 查询积分流水

### 商品接口
- `POST /goods/add` 新增商品
- `GET /goods/list` 商品列表
- `GET /goods/{id}` 商品详情

### 订单接口
- `POST /order/exchange` 积分兑换商品
- `GET /order/user/{userId}` 查询用户订单
- `GET /order/{orderId}` 查询订单详情

## 本地运行说明

### 1. 克隆项目

```bash
git clone https://github.com/IkkyuX/Star-Points.git
cd Star-Points
```

### 2. 创建数据库

请先在本地 MySQL 中执行：

```sql
CREATE DATABASE star_points DEFAULT CHARACTER SET utf8mb4;
```

然后执行：

```text
database/star_points.sql
```

### 3. 配置数据库连接

修改文件：

```text
src/main/resources/application.yaml
```

示例配置：

```yaml
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/star_points?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    username: root
    password: 你的数据库密码

mybatis:
  configuration:
    map-underscore-to-camel-case: true
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
```

### 4. 启动项目

在 IDE 中直接启动：

```text
StarpointsApplication
```

或使用 Maven：

```bash
./mvnw spring-boot:run
```

### 5. 接口文档

项目启动后可访问：

```text
http://localhost:8080/swagger-ui.html
```

如果该地址不可用，也可尝试：

```text
http://localhost:8080/swagger-ui/index.html
```

## 团队协作建议

### 分支建议

建议至少使用以下分支策略：

- `main`：稳定可运行版本
- `dev`：日常集成开发分支
- `feature/xxx`：功能开发分支

示例：

- `feature/user-register`
- `feature/point-account`
- `feature/order-exchange`

### 提交规范建议

推荐 commit message 使用简单清晰的风格，例如：

- `feat: 完成用户注册接口`
- `feat: 新增积分账户查询接口`
- `fix: 修复订单兑换库存扣减问题`
- `docs: 更新 README`
- `refactor: 调整 service 层结构`

### 开发约定

- Controller 只负责接收请求和返回结果
- Service 负责业务逻辑
- Mapper 负责数据库操作
- DTO 用于接收前端参数
- Entity 对应数据库表
- 所有重要业务操作尽量补充日志和异常处理
- 涉及“注册 + 初始化积分账户”“兑换 + 扣积分 + 生成订单”的逻辑建议加事务

## 后续迭代方向

当前版本是最小 MVP，后续可以继续扩展：

- 登录/鉴权
- 用户等级体系
- 签到任务
- 积分过期机制
- 商品分类/SKU
- 收货地址管理
- 优惠券/虚拟商品
- 后台权限管理
- 统一返回体 Result
- 全局异常处理
- 单元测试与接口测试

## 常见问题

### 1. 程序启动成功但接口报 404
请检查：
- Controller 是否加了 `@RestController`
- 方法是否加了 `@GetMapping` / `@PostMapping`
- 请求路径是否正确

### 2. 注入失败：`No qualifying bean of type ...`
请检查：
- Service 实现类是否加了 `@Service`
- Mapper 是否加了 `@Mapper`
- 启动类包路径是否能扫描到对应类

### 3. 数据库连接失败
请检查：
- MySQL 是否启动
- 数据库名是否是 `star_points`
- `application.yaml` 的用户名密码是否正确

## 贡献说明

欢迎团队成员在开发前先阅读本文件，了解项目结构、数据库设计和当前开发范围。提交代码前请至少保证：

- 本地能正常启动
- 核心 SQL 能正常执行
- 新增接口可以通过 Swagger 或 Postman 基本验证

## 项目仓库

```text
https://github.com/IkkyuX/Star-Points.git
```