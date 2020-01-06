/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.5.40 : Database - test_security
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE = ''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS */`test_security` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `test_security`;

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member`
(
    `id`                     bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
    `phone`                  varchar(64)  NOT NULL COMMENT '手机号码',
    `email`                  varchar(100) DEFAULT NULL COMMENT '邮箱',
    `username`               varchar(64)  DEFAULT NULL COMMENT '用户名',
    `nickname`               varchar(64)  DEFAULT NULL COMMENT '昵称',
    `password`               varchar(255) NOT NULL COMMENT '登录密码',
    `salt`                   varchar(255) DEFAULT NULL COMMENT '登录密码salt值',
    `pay_password`           varchar(255) DEFAULT NULL COMMENT '支付密码',
    `pay_salt`               varchar(255) DEFAULT NULL COMMENT '支付密码salt值',
    `status`                 int(1)       DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
    `create_time`            datetime     DEFAULT NULL COMMENT '注册时间',
    `icon`                   varchar(500) DEFAULT NULL COMMENT '头像',
    `gender`                 int(1)       DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
    `birthday`               date         DEFAULT NULL COMMENT '生日',
    `country`                varchar(255) DEFAULT NULL COMMENT '所在国家',
    `city`                   varchar(64)  DEFAULT NULL COMMENT '所在城市',
    `personalized_signature` varchar(200) DEFAULT NULL COMMENT '个性签名',
    `real_name`              varchar(64)  DEFAULT NULL COMMENT '真实姓名',
    `inviter_id`             bigint(20)   DEFAULT NULL COMMENT '邀请人ID',
    `mall_id`                varchar(64)  DEFAULT NULL COMMENT '商城账号',
    `inviter_code`           varchar(64)  DEFAULT NULL COMMENT '邀请码',
    `app_cate`               int(1)       DEFAULT NULL COMMENT 'APP类型0-安卓1-IOS',
    `device_token`           varchar(255) DEFAULT NULL COMMENT '当前登录设备deviceToken',
    PRIMARY KEY (`id`),
    KEY `phone` (`phone`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8 COMMENT ='会员表';

/*Data for the table `member` */

insert into `member`(`id`, `phone`, `email`, `username`, `nickname`, `password`, `salt`, `pay_password`, `pay_salt`,
                     `status`, `create_time`, `icon`, `gender`, `birthday`, `country`, `city`, `personalized_signature`,
                     `real_name`, `inviter_id`, `mall_id`, `inviter_code`, `app_cate`, `device_token`)
values (1, '123456', NULL, 'one', NULL, '$2a$10$hr.Inhewac5vPgWY/RD9ie3b9G4wrYuqzibd2Jui6WhLX0IkorIQO', NULL,
        '$2a$10$kmvTkto46g6G2UBgrOWQSOblYQMMLQXLgGzpVuySYZYoBcfECS8Sq', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL);

/*Table structure for table `sys_department` */

DROP TABLE IF EXISTS `sys_department`;

CREATE TABLE `sys_department`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `name`        varchar(255) DEFAULT NULL COMMENT '部门名称',
    `description` varchar(255) DEFAULT NULL COMMENT '部门描述',
    `parent_id`   bigint(20)   DEFAULT NULL COMMENT '父级ID',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8 COMMENT ='部门表';

/*Data for the table `sys_department` */

insert into `sys_department`(`id`, `name`, `description`, `parent_id`, `create_time`, `update_time`)
values (2, '系统', '系统管理员', 0, '2019-12-28 11:39:28', NULL);

/*Table structure for table `sys_dictionary` */

DROP TABLE IF EXISTS `sys_dictionary`;

CREATE TABLE `sys_dictionary`
(
    `id`          bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `bond`        varchar(255) NOT NULL COMMENT '键',
    `value`       varchar(255) DEFAULT NULL COMMENT '值',
    `comment`     varchar(255) DEFAULT NULL COMMENT '描述',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `bond` (`bond`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 20
  DEFAULT CHARSET = utf8 COMMENT ='系统字典表';

/*Data for the table `sys_dictionary` */

insert into `sys_dictionary`(`id`, `bond`, `value`, `comment`, `create_time`, `update_time`)
values (13, 'freezeReleaseDay', '20', '冻结释放天数', NULL, NULL),
       (14, 'pointsCnyRate', '1', '积分人民币比率', NULL, NULL),
       (15, 'speedUpReleaseInterval', '10', '加速任务释放时间间隔(单位：小时)', NULL, NULL),
       (17, 'memberAuthTypeSimilarity', '80', '人脸识别相似度', NULL, NULL),
       (18, 'memberAuthType', '1', '实名认证级别', NULL, NULL),
       (19, 'memberAuthAuto', '1', '是否开启自动认证', NULL, NULL);

/*Table structure for table `sys_permission` */

DROP TABLE IF EXISTS `sys_permission`;

CREATE TABLE `sys_permission`
(
    `id`          bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `title`       varchar(255) NOT NULL COMMENT '权限名',
    `description` varchar(255) DEFAULT NULL COMMENT '权限描述',
    `url`         varchar(255) DEFAULT NULL COMMENT '权限路径',
    `method`      varchar(10)  DEFAULT NULL COMMENT '权限方法',
    `parent_id`   bigint(20)   DEFAULT NULL COMMENT '父级ID',
    `sort`        int(3)       DEFAULT NULL COMMENT '排序',
    `type`        int(1)       DEFAULT NULL COMMENT '权限类型0-菜单显示级1-菜单隐藏级2-按钮级',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    `value`       varchar(62)  DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `method` (`method`),
    KEY `type` (`type`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 29
  DEFAULT CHARSET = utf8 COMMENT ='权限表';

/*Data for the table `sys_permission` */

insert into `sys_permission`(`id`, `title`, `description`, `url`, `method`, `parent_id`, `sort`, `type`, `create_time`,
                             `update_time`, `value`)
values (1, '系统管理', '系统管理菜单', '/admin/sys', 'GET', 0, 0, 0, '2019-12-02 06:41:47', NULL, NULL),
       (2, '用户管理', '系统用户菜单', '/admin/sys/user', 'GET', 1, 0, 0, '2019-12-02 06:41:47', NULL, NULL),
       (3, '查询当前用户', '查询当前用户', '/admin/sys-users/current-user', 'GET', 2, 0, 2, '2019-12-02 06:41:47', NULL, NULL),
       (4, '分页查询用户', '分页查询用户', '/admin/sys-users/page', 'POST', 2, 0, 2, '2019-12-02 06:41:47', NULL, NULL),
       (5, 'ROLE_ADMIN', '查询用户', '/admin/sys-users/{id}', 'GET', 2, 0, 2, '2019-12-02 06:41:47', NULL, NULL),
       (6, '添加用户', '添加用户', '/admin/sys-users', 'POST', 2, 0, 2, '2019-12-02 06:41:47', NULL, NULL),
       (7, '删除用户', '删除用户', '/admin/sys-users', 'DELETE', 2, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (8, '修改用户', '修改用户', '/admin/s11ys-users/{id}', 'PUT', 2, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (9, '修改密码', '修改密码', '/admin/sys-users/password', 'PUT', 2, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (10, '刷新Token', '刷新Token', '/admin/sys-users/token', 'GET', 2, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (11, 'ROLE_ADMIN', '用户登出', '/admin/sys-users/logout', 'GET', 2, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (12, '角色管理', '系统角色菜单', '/admin/sys/role', 'GET', 1, 0, 0, '2019-12-02 06:41:48', NULL, NULL),
       (13, '删除角色', '删除角色', '/admin/sys-roles', 'DELETE', 12, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (14, '查询角色', '查询角色', '/admin/sys-roles', 'GET', 12, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (15, '添加角色', '添加角色', '/admin/sys-roles', 'POST', 12, 0, 2, '2019-12-02 06:41:48', NULL, NULL),
       (16, '获取用户角色', '获取用户角色', '/admin/sys-roles/users/{userId}', 'GET', 12, 0, 2, '2019-12-02 06:41:49', NULL, NULL),
       (17, '修改角色', '修改角色', '/admin/sys-roles/{roleId}', 'PUT', 12, 0, 2, '2019-12-02 06:41:49', NULL, NULL),
       (18, '分配角色', '分配角色', '/admin/sys-roles/{userId}', 'POST', 12, 0, 2, '2019-12-02 06:41:49', NULL, NULL),
       (19, '权限管理', '系统权限菜单', '/admin/sys/permission', 'GET', 1, 0, 0, '2019-12-02 06:41:49', NULL, NULL),
       (20, '删除权限', '删除权限', '/admin/sys-permissions', 'DELETE', 19, 0, 2, '2019-12-02 06:41:49', NULL, NULL),
       (21, '查询权限', '查询权限', '/admin/sys-permissions/page', 'POST', 19, 0, 2, '2019-12-02 06:41:49', NULL, NULL),
       (22, '添加权限', '添加权限', '/admin/sys-permissions', 'POST', 19, 0, 2, '2019-12-02 06:41:49', NULL, NULL),
       (23, '修改权限', '修改权限', '/admin/sys-permissions/{permissionId}', 'PUT', 19, 0, 2, '2019-12-02 06:41:49', NULL,
        NULL),
       (24, '获取用户权限', '获取用户权限', '/admin/sys-permissions/users/{userId}', 'GET', 19, 0, 2, '2019-12-02 06:41:49', NULL,
        NULL),
       (25, '获取角色权限', '获取角色权限', '/admin/sys-permissions/roles/{roleId}', 'GET', 19, 0, 2, '2019-12-02 06:41:49', NULL,
        NULL),
       (26, '重置权限', '重置权限', '/admin/sys-permissions/roles/{roleId}', 'PUT', 19, 0, 2, '2019-12-02 06:41:49', NULL,
        NULL),
       (27, '查询层级权限', '查询层级权限', '/admin/sys-permissions/trees', 'GET', 19, 0, 2, '2019-12-02 06:41:50', NULL, NULL),
       (28, '查询用户层级权限', '查询用户层级权限', '/admin/sys-permissions/trees/{userId}', 'GET', 19, 0, 2, '2019-12-02 06:41:50',
        NULL, NULL);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role`
(
    `id`          bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `role`        varchar(255) NOT NULL COMMENT '角色名',
    `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8 COMMENT ='角色表';

/*Data for the table `sys_role` */

insert into `sys_role`(`id`, `role`, `description`, `create_time`, `update_time`)
values (1, 'ADMIN', '系统管理员', '2019-12-28 11:40:15', NULL);

/*Table structure for table `sys_role_permission` */

DROP TABLE IF EXISTS `sys_role_permission`;

CREATE TABLE `sys_role_permission`
(
    `role_id` bigint(20) NOT NULL COMMENT '角色ID',
    `rule_id` bigint(20) NOT NULL COMMENT '权限ID'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='角色权限表';

/*Data for the table `sys_role_permission` */

insert into `sys_role_permission`(`role_id`, `rule_id`)
values (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (1, 5),
       (1, 6),
       (1, 7),
       (1, 8),
       (1, 9),
       (1, 10),
       (1, 11),
       (1, 12),
       (1, 13),
       (1, 14),
       (1, 15),
       (1, 16),
       (1, 17),
       (1, 18),
       (1, 19),
       (1, 20),
       (1, 21),
       (1, 22),
       (1, 23),
       (1, 24),
       (1, 25),
       (1, 26),
       (1, 27),
       (1, 28);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user`
(
    `id`              bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `username`        varchar(128) NOT NULL COMMENT '用户名',
    `password`        varchar(128) NOT NULL COMMENT '登录密码',
    `phone`           varchar(16)  NOT NULL COMMENT '手机号码',
    `real_name`       varchar(32)  NOT NULL COMMENT '真实姓名',
    `department_id`   bigint(20)   NOT NULL COMMENT '部门ID',
    `status`          int(1)       DEFAULT NULL COMMENT '状态0-可用1-禁用',
    `avatar`          varchar(255) DEFAULT NULL COMMENT '头像',
    `email`           varchar(64)  DEFAULT NULL COMMENT '邮箱',
    `last_login_ip`   varchar(30)  DEFAULT NULL COMMENT '上次登录IP',
    `last_login_time` datetime     DEFAULT NULL COMMENT '上次登录时间',
    `qq`              varchar(16)  DEFAULT NULL COMMENT 'QQ号码',
    `create_time`     datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time`     datetime     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `phone` (`phone`),
    KEY `username` (`username`, `password`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 16
  DEFAULT CHARSET = utf8 COMMENT ='后台系统用户表';

/*Data for the table `sys_user` */

insert into `sys_user`(`id`, `username`, `password`, `phone`, `real_name`, `department_id`, `status`, `avatar`, `email`,
                       `last_login_ip`, `last_login_time`, `qq`, `create_time`, `update_time`)
values (1, 'one', '$2a$10$hr.Inhewac5vPgWY/RD9ie3b9G4wrYuqzibd2Jui6WhLX0IkorIQO', '123456', '测试', 2, 0, '21321',
        '123456@qq.bn', '127.0.0.1', '2019-12-02 06:41:45', '123456', '2019-12-02 06:41:45', NULL);

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role`
(
    `user_id` bigint(20) NOT NULL COMMENT '用户ID',
    `role_id` bigint(20) NOT NULL COMMENT '角色ID'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='用户角色表';

/*Data for the table `sys_user_role` */

insert into `sys_user_role`(`user_id`, `role_id`)
values (1, 1);

/*Table structure for table `ums_admin` */

DROP TABLE IF EXISTS `ums_admin`;

CREATE TABLE `ums_admin`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT,
    `username`    varchar(64)  DEFAULT NULL,
    `password`    varchar(64)  DEFAULT NULL,
    `icon`        varchar(500) DEFAULT NULL COMMENT '头像',
    `email`       varchar(100) DEFAULT NULL COMMENT '邮箱',
    `nick_name`   varchar(200) DEFAULT NULL COMMENT '昵称',
    `note`        varchar(500) DEFAULT NULL COMMENT '备注信息',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `login_time`  datetime     DEFAULT NULL COMMENT '最后登录时间',
    `status`      int(1)       DEFAULT '1' COMMENT '帐号启用状态：0->禁用；1->启用',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8 COMMENT ='后台用户表';

/*Data for the table `ums_admin` */

insert into `ums_admin`(`id`, `username`, `password`, `icon`, `email`, `nick_name`, `note`, `create_time`, `login_time`,
                        `status`)
values (1, 'test', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', NULL, '测试账号', NULL,
        '2018-09-29 13:55:30', '2018-09-29 13:55:39', 1),
       (3, 'admin', '$2a$10$hr.Inhewac5vPgWY/RD9ie3b9G4wrYuqzibd2Jui6WhLX0IkorIQO',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/170157_yIl3_1767531.jpg', 'admin@163.com',
        '系统管理员', '系统管理员', '2018-10-08 13:32:47', '2019-03-20 15:38:50', 1);

/*Table structure for table `ums_admin_permission_relation` */

DROP TABLE IF EXISTS `ums_admin_permission_relation`;

CREATE TABLE `ums_admin_permission_relation`
(
    `id`            bigint(20) NOT NULL AUTO_INCREMENT,
    `admin_id`      bigint(20) DEFAULT NULL,
    `permission_id` bigint(20) DEFAULT NULL,
    `type`          int(1)     DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='后台用户和权限关系表(除角色中定义的权限以外的加减权限)';

/*Data for the table `ums_admin_permission_relation` */

/*Table structure for table `ums_admin_role_relation` */

DROP TABLE IF EXISTS `ums_admin_role_relation`;

CREATE TABLE `ums_admin_role_relation`
(
    `id`       bigint(20) NOT NULL AUTO_INCREMENT,
    `admin_id` bigint(20) DEFAULT NULL,
    `role_id`  bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 17
  DEFAULT CHARSET = utf8 COMMENT ='后台用户和角色关系表';

/*Data for the table `ums_admin_role_relation` */

insert into `ums_admin_role_relation`(`id`, `admin_id`, `role_id`)
values (13, 3, 1),
       (15, 3, 2),
       (16, 3, 4);

/*Table structure for table `ums_permission` */

DROP TABLE IF EXISTS `ums_permission`;

CREATE TABLE `ums_permission`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT,
    `pid`         bigint(20)   DEFAULT NULL COMMENT '父级权限id',
    `name`        varchar(100) DEFAULT NULL COMMENT '名称',
    `value`       varchar(200) DEFAULT NULL COMMENT '权限值',
    `icon`        varchar(500) DEFAULT NULL COMMENT '图标',
    `type`        int(1)       DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
    `uri`         varchar(200) DEFAULT NULL COMMENT '前端资源路径',
    `status`      int(1)       DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `sort`        int(11)      DEFAULT NULL COMMENT '排序',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 20
  DEFAULT CHARSET = utf8 COMMENT ='后台用户权限表';

/*Data for the table `ums_permission` */

insert into `ums_permission`(`id`, `pid`, `name`, `value`, `icon`, `type`, `uri`, `status`, `create_time`, `sort`)
values (1, 0, '商品', NULL, NULL, 0, NULL, 1, '2018-09-29 16:15:14', 0),
       (2, 1, '商品列表', 'pms:product:read', NULL, 1, '/pms/product/index', 1, '2018-09-29 16:17:01', 0),
       (3, 1, '添加商品', 'pms:product:create', NULL, 1, '/pms/product/add', 1, '2018-09-29 16:18:51', 0),
       (4, 1, '商品分类', 'pms:productCategory:read', NULL, 1, '/pms/productCate/index', 1, '2018-09-29 16:23:07', 0),
       (5, 1, '商品类型', 'pms:productAttribute:read', NULL, 1, '/pms/productAttr/index', 1, '2018-09-29 16:24:43', 0),
       (6, 1, '品牌管理', 'pms:brand:read', NULL, 1, '/pms/brand/index', 1, '2018-09-29 16:25:45', 0),
       (7, 2, '编辑商品', 'pms:product:update', NULL, 2, '/pms/product/updateProduct', 1, '2018-09-29 16:34:23', 0),
       (8, 2, '删除商品', 'pms:product:delete', NULL, 2, '/pms/product/delete', 1, '2018-09-29 16:38:33', 0),
       (9, 4, '添加商品分类', 'pms:productCategory:create', NULL, 2, '/pms/productCate/create', 1, '2018-09-29 16:43:23', 0),
       (10, 4, '修改商品分类', 'pms:productCategory:update', NULL, 2, '/pms/productCate/update', 1, '2018-09-29 16:43:55', 0),
       (11, 4, '删除商品分类', 'pms:productCategory:delete', NULL, 2, '/pms/productAttr/delete', 1, '2018-09-29 16:44:38', 0),
       (12, 5, '添加商品类型', 'pms:productAttribute:create', NULL, 2, '/pms/productAttr/create', 1, '2018-09-29 16:45:25',
        0),
       (13, 5, '修改商品类型', 'pms:productAttribute:update', NULL, 2, '/pms/productAttr/update', 1, '2018-09-29 16:48:08',
        0),
       (14, 5, '删除商品类型', 'pms:productAttribute:delete', NULL, 2, '/pms/productAttr/delete', 1, '2018-09-29 16:48:44',
        0),
       (15, 6, '添加品牌', 'pms:brand:create', NULL, 2, '/pms/brand/add', 1, '2018-09-29 16:49:34', 0),
       (16, 6, '修改品牌', 'pms:brand:update', NULL, 2, '/pms/brand/update', 1, '2018-09-29 16:50:55', 0),
       (17, 6, '删除品牌', 'pms:brand:delete', NULL, 2, '/pms/brand/delete', 1, '2018-09-29 16:50:59', 0),
       (18, 0, '首页', NULL, NULL, 0, NULL, 1, '2018-09-29 16:51:57', 0),
       (19, 0, '获取一个', 'admin:getOne', NULL, 0, '/admin', 1, NULL, 0);

/*Table structure for table `ums_role` */

DROP TABLE IF EXISTS `ums_role`;

CREATE TABLE `ums_role`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT,
    `name`        varchar(100) DEFAULT NULL COMMENT '名称',
    `description` varchar(500) DEFAULT NULL COMMENT '描述',
    `admin_count` int(11)      DEFAULT NULL COMMENT '后台用户数量',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `status`      int(1)       DEFAULT '1' COMMENT '启用状态：0->禁用；1->启用',
    `sort`        int(11)      DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8 COMMENT ='后台用户角色表';

/*Data for the table `ums_role` */

insert into `ums_role`(`id`, `name`, `description`, `admin_count`, `create_time`, `status`, `sort`)
values (1, '商品管理员', '商品管理员', 0, '2018-09-30 15:46:11', 1, 0),
       (2, '商品分类管理员', '商品分类管理员', 0, '2018-09-30 15:53:45', 1, 0),
       (3, '商品类型管理员', '商品类型管理员', 0, '2018-09-30 15:53:56', 1, 0),
       (4, '品牌管理员', '品牌管理员', 0, '2018-09-30 15:54:12', 1, 0);

/*Table structure for table `ums_role_permission_relation` */

DROP TABLE IF EXISTS `ums_role_permission_relation`;

CREATE TABLE `ums_role_permission_relation`
(
    `id`            bigint(20) NOT NULL AUTO_INCREMENT,
    `role_id`       bigint(20) DEFAULT NULL,
    `permission_id` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 19
  DEFAULT CHARSET = utf8 COMMENT ='后台用户角色和权限关系表';

/*Data for the table `ums_role_permission_relation` */

insert into `ums_role_permission_relation`(`id`, `role_id`, `permission_id`)
values (1, 1, 1),
       (2, 1, 2),
       (3, 1, 3),
       (4, 1, 7),
       (5, 1, 8),
       (6, 2, 4),
       (7, 2, 9),
       (8, 2, 10),
       (9, 2, 11),
       (10, 3, 5),
       (11, 3, 12),
       (12, 3, 13),
       (13, 3, 14),
       (14, 4, 6),
       (15, 4, 15),
       (16, 4, 16),
       (17, 4, 17),
       (18, 1, 19);

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;
