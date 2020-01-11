/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.7.28 : Database - mall_wallet
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mall_wallet` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `tes`;

/*Table structure for table `app_version` */

DROP TABLE IF EXISTS `app_version`;

CREATE TABLE `app_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_cate` varchar(255) NOT NULL COMMENT 'APP类型0-安卓1-IOS',
  `app_url` varchar(255) NOT NULL COMMENT '地址URL',
  `app_version` varchar(255) NOT NULL COMMENT 'APP版本',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `app_content` varchar(255) NOT NULL COMMENT '升级内容',
  `status` int(1) NOT NULL COMMENT '记录状态0-有效1-失效',
  PRIMARY KEY (`id`),
  KEY `app_cate` (`app_cate`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='APP版本表';

/*Table structure for table `coin` */

DROP TABLE IF EXISTS `coin`;

CREATE TABLE `coin` (
  `name` varchar(10) NOT NULL COMMENT '货币名称',
  `unit` varchar(10) NOT NULL COMMENT '单位',
  `name_cn` varchar(10) NOT NULL COMMENT '中文名称',
  `can_auto_withdraw` int(1) DEFAULT NULL COMMENT '是否能自动提币 0-否 1-是',
  `can_recharge` int(1) DEFAULT NULL COMMENT '是否能充币 0-否 1-是',
  `can_transfer` int(1) DEFAULT NULL COMMENT '是否能转账 0-否 1-是',
  `can_withdraw` int(1) DEFAULT NULL COMMENT '是否能提币 0-否 1-是',
  `cny_rate` decimal(18,8) DEFAULT NULL COMMENT '人民币汇率',
  `sgd_rate` decimal(18,8) DEFAULT NULL COMMENT '美元汇率',
  `usd_rate` decimal(18,8) DEFAULT NULL COMMENT 'USDT汇率',
  `cold_wallet_address` varchar(255) DEFAULT NULL COMMENT '冷钱包地址',
  `enable_rpc` int(1) DEFAULT NULL COMMENT '是否支持rpc接口 0-否 1-是',
  `has_legal` int(1) NOT NULL COMMENT '是否是法币 0-否 1-是',
  `is_platform_coin` int(1) NOT NULL COMMENT '是否为平台币0-,1-',
  `master_address` varchar(64) DEFAULT NULL COMMENT '主充值地址',
  `max_daily_withdraw_rate` decimal(18,8) DEFAULT NULL COMMENT '单日最大提币量',
  `max_tx_fee` double NOT NULL COMMENT '最大提币手续费',
  `min_tx_fee` double NOT NULL COMMENT '最小提币手续费',
  `max_withdraw_amount` decimal(18,8) DEFAULT NULL COMMENT '最大提币数量',
  `min_withdraw_amount` decimal(18,8) DEFAULT NULL COMMENT '最小提币数量',
  `min_recharge_amount` decimal(18,8) DEFAULT NULL COMMENT '最小充币数量',
  `miner_fee` decimal(18,8) DEFAULT NULL COMMENT '矿工费',
  `sorts` int(4) NOT NULL COMMENT '排序',
  `status` int(1) NOT NULL COMMENT '状态 0-正常 1-非法',
  `withdraw_scale` int(2) DEFAULT '4' COMMENT '提币精度',
  `withdraw_threshold` decimal(18,8) DEFAULT NULL COMMENT '自动提现阈值',
  PRIMARY KEY (`name`),
  KEY `unit` (`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='币种信息表';

insert  into `coin`(`name`,`unit`,`name_cn`,`can_auto_withdraw`,`can_recharge`,`can_transfer`,`can_withdraw`,`cny_rate`,`sgd_rate`,`usd_rate`,`cold_wallet_address`,`enable_rpc`,`has_legal`,`is_platform_coin`,`master_address`,`max_daily_withdraw_rate`,`max_tx_fee`,`min_tx_fee`,`max_withdraw_amount`,`min_withdraw_amount`,`min_recharge_amount`,`miner_fee`,`sorts`,`status`,`withdraw_scale`,`withdraw_threshold`) values 
('BTC','BTC','BTC',1,1,1,1,100230.00000000,14082.00000000,14000.00000000,'13dfr678ijhgfr56y7ujhgfty',1,0,0,'13dfr678ijhgfr56y7ujhgfty',10000.00000000,0.01,0.01,1000.00000000,1.00000000,1.00000000,0.01000000,4,0,8,2.00000000),
('ERC20USDT','USDT','USDT',1,1,1,1,0.50000000,1.00000000,1.00000000,'0x0000001',1,0,0,'0x0000001',1.00000000,1,1,1000.00000000,4.00000000,0.00000000,0.10000000,1,0,8,5.00000000),
('OMNIUSDT','USDT','USDT',1,1,1,1,0.50000000,1.00000000,1.00000000,'0x0000002',1,0,0,'0x0000002',1.00000000,1,1,1000.00000000,1.00000000,0.00000000,0.10000000,1,0,8,1.00000000),
('TEA','TEA','TEA',1,1,1,1,0.50000000,6.00000000,0.50000000,'0x0000003',1,0,1,'0x0000003',1.00000000,1,1,1000.00000000,10.00000000,0.00000000,0.00000000,1,0,8,4.00000000);



/*Table structure for table `country` */

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `zh_name` varchar(255) NOT NULL COMMENT '中文名称',
  `area_code` varchar(255) DEFAULT NULL COMMENT '区域码',
  `en_name` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `language` varchar(255) DEFAULT NULL COMMENT '语言',
  `local_currency` varchar(255) DEFAULT NULL COMMENT '当地币种',
  `sort` int(3) NOT NULL COMMENT '排序',
  PRIMARY KEY (`zh_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `exchange_setting` */

DROP TABLE IF EXISTS `exchange_setting`;

CREATE TABLE `exchange_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `deal_coin_name` varchar(10) NOT NULL COMMENT '交易币种',
  `close_coin_name` varchar(10) NOT NULL COMMENT '结算币种',
  `exchange_min` decimal(19,8) NOT NULL COMMENT '兑换最小值',
  `exchange_max` decimal(19,8) DEFAULT NULL COMMENT '兑换最大值',
  `fee` double NOT NULL COMMENT '手续费',
  `status` int(2) NOT NULL COMMENT '类型0积分兑换1币币兑换',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `deal_coin_name` (`deal_coin_name`,`close_coin_name`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='兑换设置表';

/*Table structure for table `financial_item` */
insert  into `exchange_setting`(`id`,`deal_coin_name`,`close_coin_name`,`exchange_min`,`exchange_max`,`fee`,`status`,`create_time`) values 
(1,'USDT','TEA',1.00000000,10.00000000,1,1,now()),
(2,'TEA','USDT',1.00000000,100.00000000,1,1,now()),
(3,'WPOINTS','TEA',10.00000000,100.00000000,1,0,now());



DROP TABLE IF EXISTS `financial_item`;

CREATE TABLE `financial_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) DEFAULT NULL COMMENT '项目名',
  `coin_name` varchar(10) NOT NULL COMMENT '币种',
  `yield` decimal(18,8) NOT NULL COMMENT '收益率',
  `locked` decimal(18,8) NOT NULL COMMENT '已锁定',
  `number` int(8) NOT NULL COMMENT '抢购人数',
  `coin_minnum` decimal(19,8) NOT NULL COMMENT '最小量',
  `deadline` int(5) NOT NULL COMMENT '锁仓时间',
  `item_state` int(1) NOT NULL COMMENT '项目状态0-不显示1-显示',
  `carry_interest_num` int(5) NOT NULL COMMENT '起息延迟天数',
  `is_top` int(2) NOT NULL COMMENT '是否置顶0否1是',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `item_desc` varchar(255) DEFAULT NULL COMMENT '项目描述',
  `item_id` varchar(255) DEFAULT NULL COMMENT '项目编码',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='理财项目表';

/*Table structure for table `financial_order` */

DROP TABLE IF EXISTS `financial_order`;

CREATE TABLE `financial_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coin_name` varchar(10) NOT NULL COMMENT '币种',
  `coin_num` decimal(18,8) NOT NULL COMMENT '理财数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `frozen_days` int(5) NOT NULL COMMENT '锁仓天数',
  `item_id` varchar(255) DEFAULT NULL COMMENT '项目编码',
  `member_id` bigint(20) NOT NULL COMMENT '用户ID',
  `order_no` bigint(20) DEFAULT NULL COMMENT '订单号',
  `order_state` int(11) NOT NULL COMMENT '订单状态0收益中1已收益2为收益',
  `order_usdt_rate` decimal(18,8) DEFAULT NULL COMMENT '对USDT汇率',
  `carry_interest_time` datetime NOT NULL COMMENT '起息日',
  `plan_revenue_time` datetime NOT NULL COMMENT '计划到期日',
  `real_income` decimal(18,8) DEFAULT NULL COMMENT '实际收益',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `yield` decimal(18,8) DEFAULT NULL COMMENT '收益率',
  `member_phone` varchar(64) DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='理财订单表';

/*Table structure for table `flash_against_record` */

DROP TABLE IF EXISTS `flash_against_record`;

CREATE TABLE `flash_against_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `transaction_type` int(2) DEFAULT NULL COMMENT '变动类型',
  `deal_coin_name` varchar(10) NOT NULL COMMENT '交易币种',
  `balance` decimal(18,8) DEFAULT NULL COMMENT '变动金额',
  `frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '变动冻结金额',
  `account` decimal(18,8) DEFAULT NULL COMMENT '到账金额',
  `close_coin_name` varchar(10) NOT NULL COMMENT '结算币种',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='闪兑记录表';

/*Table structure for table `freeze_release_record` */

DROP TABLE IF EXISTS `freeze_release_record`;

CREATE TABLE `freeze_release_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `member_id` bigint(10) DEFAULT NULL COMMENT '用户id',
  `amount` decimal(18,8) NOT NULL COMMENT '变动金额',
  `now()_balance` decimal(18,8) DEFAULT NULL COMMENT '冻结金额',
  `day` int(4) NOT NULL COMMENT '释放天数',
  `value_day` int(4) NOT NULL COMMENT '剩余释放天数',
  `day_num` decimal(18,8) DEFAULT NULL COMMENT '每天释放金额',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` int(2) DEFAULT NULL COMMENT '类型0释放未结束1已结束',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='冻结释放记录';

/*Table structure for table `hot_address_info` */

DROP TABLE IF EXISTS `hot_address_info`;

CREATE TABLE `hot_address_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '地址',
  `balance` decimal(18,8) NOT NULL DEFAULT '0.00000000' COMMENT '余额',
  `fee_balance` decimal(18,8) NOT NULL DEFAULT '0.00000000' COMMENT '手续费余额',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0-可用1-不可用',
  `coin_name` varchar(10) DEFAULT NULL COMMENT '币种名称',
  `current_hash` varchar(100) DEFAULT NULL COMMENT '当前交易hash',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `coin_name` (`coin_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='热钱包地址表';

/*Table structure for table `hot_transfer_record` */

DROP TABLE IF EXISTS `hot_transfer_record`;

CREATE TABLE `hot_transfer_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `admin_id` bigint(20) DEFAULT NULL COMMENT '操作人ID',
  `coin_name` varchar(255) DEFAULT NULL COMMENT '币种',
  `cold_address` varchar(255) DEFAULT NULL COMMENT '冷钱包地址',
  `amount` decimal(18,8) DEFAULT '0.00000000' COMMENT '转账金额',
  `balance` decimal(18,8) DEFAULT '0.00000000' COMMENT '热钱包余额',
  `miner_fee` decimal(18,8) DEFAULT '0.00000000' COMMENT '矿工费',
  `transaction_number` varchar(255) DEFAULT NULL COMMENT '实际归集数量',
  `transfer_time` datetime DEFAULT NULL COMMENT '归集时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `invite_record` */

DROP TABLE IF EXISTS `invite_record`;

CREATE TABLE `invite_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `invite_member_id` bigint(10) DEFAULT NULL COMMENT '邀请人id',
  `invite_member_phone` varchar(64) DEFAULT NULL COMMENT '邀请人手机号',
  `linked_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '邀请码',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `member_id` varchar(256) DEFAULT NULL COMMENT '用户id',
  `member_icon` varchar(256) DEFAULT NULL COMMENT '用户头像',
  `member_phone` varchar(64) DEFAULT NULL COMMENT '用户手机号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='邀请记录表';

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `phone` varchar(64) NOT NULL COMMENT '手机号码',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '登录密码',
  `salt` varchar(255) DEFAULT NULL COMMENT '登录密码salt值',
  `pay_password` varchar(255) DEFAULT NULL COMMENT '支付密码',
  `pay_salt` varchar(255) DEFAULT NULL COMMENT '支付密码salt值',
  `status` int(1) DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `icon` varchar(500) DEFAULT NULL COMMENT '头像',
  `gender` int(1) DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `country` varchar(255) DEFAULT NULL COMMENT '所在国家',
  `city` varchar(64) DEFAULT NULL COMMENT '所在城市',
  `personalized_signature` varchar(200) DEFAULT NULL COMMENT '个性签名',
  `real_name` varchar(64) DEFAULT NULL COMMENT '真实姓名',
  `inviter_id` bigint(20) DEFAULT NULL COMMENT '邀请人ID',
  `mall_id` varchar(64) DEFAULT NULL COMMENT '商城账号',
  `inviter_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '邀请码',
  `app_cate` int(1) DEFAULT NULL COMMENT 'APP类型0-安卓1-IOS',
  `device_token` varchar(255) DEFAULT NULL COMMENT '当前登录设备deviceToken',
  PRIMARY KEY (`id`),
  KEY `phone` (`phone`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='会员表';

/*Table structure for table `member_authentication` */

DROP TABLE IF EXISTS `member_authentication`;

CREATE TABLE `member_authentication` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NOT NULL COMMENT '用户ID',
  `auth_type` int(1) NOT NULL COMMENT '认证类型0-图片认证1-视频认证2-都有',
  `auth_status` int(1) NOT NULL COMMENT '认证状态0-未认证1-认证审核中2-审核通过3-审核失败',
  `id_card_no` varchar(64) NOT NULL COMMENT '证件号码',
  `real_name` varchar(64) NOT NULL COMMENT '真实姓名',
  `identity_card_img_front` varchar(255) DEFAULT NULL COMMENT '证件正面照',
  `identity_card_img_reverse` varchar(255) DEFAULT NULL COMMENT '证件反面照',
  `identity_card_img_in_hand` varchar(255) DEFAULT NULL COMMENT '证件手持照',
  `video_url` varchar(255) DEFAULT NULL COMMENT '认证视频',
  `reject_reason` varchar(512) DEFAULT NULL COMMENT '拒绝原因',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `kyc_status` int(2) DEFAULT '0' COMMENT 'kyc等级',
  `video_random` varchar(6) DEFAULT NULL COMMENT '视频认证随机数',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='会员实名认证表';

/*Table structure for table `member_deposit` */

DROP TABLE IF EXISTS `member_deposit`;

CREATE TABLE `member_deposit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `address` varchar(255) DEFAULT NULL COMMENT '充值地址',
  `amount` decimal(18,8) DEFAULT '0.00000000' COMMENT '充值金额',
  `create_time` datetime DEFAULT NULL COMMENT '充值时间',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员ID',
  `txid` varchar(255) DEFAULT NULL COMMENT '交易hash',
  `unit` varchar(255) DEFAULT NULL COMMENT '币种',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='会员充值表';

/*Table structure for table `member_points` */

DROP TABLE IF EXISTS `member_points`;

CREATE TABLE `member_points` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `member_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `balance` decimal(18,8) DEFAULT NULL COMMENT '可用余额',
  `frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '冻结余额',
  `is_lock` int(1) DEFAULT '0' COMMENT '钱包是否锁定0-不锁定1-锁定',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='用户积分表';

/*Table structure for table `member_transaction` */

DROP TABLE IF EXISTS `member_transaction`;

CREATE TABLE `member_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `address` varchar(128) DEFAULT NULL COMMENT '地址',
  `coin_unit` varchar(10) NOT NULL COMMENT '币种单位',
  `balance` decimal(18,8) DEFAULT NULL COMMENT '变动可用余额',
  `frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '变动冻结余额',
  `release_balance` decimal(18,8) DEFAULT NULL COMMENT '变动待释放余额',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `fee` decimal(18,8) DEFAULT NULL COMMENT '交易手续费',
  `now()_balance` decimal(18,8) DEFAULT NULL COMMENT '当前余额',
  `now()_frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '当前冻结余额',
  `now()_release_balance` decimal(18,8) DEFAULT NULL COMMENT '当前待释放余额',
  `transaction_type` int(2) DEFAULT NULL COMMENT '变动类型0-待补充',
  `adverse_phone` varchar(64) DEFAULT NULL COMMENT '对方手机号',
  `adverse_address` varchar(128) DEFAULT NULL COMMENT '对方地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='资产变动表';

/*Table structure for table `member_wallet` */

DROP TABLE IF EXISTS `member_wallet`;

CREATE TABLE `member_wallet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `member_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `coin_unit` varchar(10) DEFAULT NULL COMMENT '币种单位',
  `address` varchar(128) DEFAULT NULL COMMENT '充值地址',
  `balance` decimal(18,8) DEFAULT NULL COMMENT '可用余额',
  `frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '冻结余额',
  `release_balance` decimal(18,8) DEFAULT NULL COMMENT '待释放余额',
  `is_lock` int(1) DEFAULT '0' COMMENT '钱包是否锁定0-不锁定1-锁定',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `member_id_2` (`member_id`,`coin_unit`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='用户资产表';

/*Table structure for table `member_wallet_address` */

DROP TABLE IF EXISTS `member_wallet_address`;

CREATE TABLE `member_wallet_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `coin_name` varchar(10) NOT NULL COMMENT '币种名称',
  `coin_unit` varchar(10) NOT NULL COMMENT '币种单位',
  `address` varchar(128) DEFAULT NULL COMMENT '充值地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='用户钱包地址表';

/*Table structure for table `member_wallet_show` */

DROP TABLE IF EXISTS `member_wallet_show`;

CREATE TABLE `member_wallet_show` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `member_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `coin_unit` varchar(10) DEFAULT NULL COMMENT '币种',
  `balance` decimal(18,8) DEFAULT NULL COMMENT '可用余额',
  `frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '冻结余额',
  `release_balance` decimal(18,8) DEFAULT NULL COMMENT '待释放余额',
  `is_lock` int(1) DEFAULT '0' COMMENT '钱包是否锁定0-不锁定1-锁定',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='用户资产展示表';

/*Table structure for table `points_transaction` */

DROP TABLE IF EXISTS `points_transaction`;

CREATE TABLE `points_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `transaction_type` int(2) DEFAULT NULL COMMENT '变动类型0积分兑换、1积分划转商城、2商城积分划转钱包、3积分静态释放、4积分加速释放',
  `phone` varchar(20) DEFAULT NULL COMMENT '用户手机号',
  `balance` decimal(18,8) DEFAULT NULL COMMENT '变动积分',
  `frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '变动冻结余额',
  `fee` decimal(18,8) DEFAULT NULL COMMENT '交易手续费',
  `now()_points` decimal(18,2) DEFAULT NULL COMMENT '当前积分',
  `now()_frozen_balance` decimal(18,8) DEFAULT NULL COMMENT '当前冻结余额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `transfer_uid` bigint(20) DEFAULT NULL COMMENT '交易人id',
  `transfer_phone` varchar(20) DEFAULT NULL COMMENT '交易人手机号',
  `transfer_name` varchar(20) DEFAULT NULL COMMENT '交易人姓名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分变动表';

/*Table structure for table `speed_up` */

DROP TABLE IF EXISTS `speed_up`;

CREATE TABLE `speed_up` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `invite_member_id` bigint(10) DEFAULT NULL COMMENT '邀请人id',
  `invite_member_phone` varchar(64) DEFAULT NULL COMMENT '邀请人手机号',
  `linked_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '邀请码',
  `number` int(4) NOT NULL COMMENT '邀请人个数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `status` int(2) NOT NULL COMMENT '类型0任务进行中1已结束',
  `release_status` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='加速释放任务表';

/*Table structure for table `speed_up_setting` */

DROP TABLE IF EXISTS `speed_up_setting`;

CREATE TABLE `speed_up_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `stair` varchar(64) NOT NULL COMMENT '阶梯',
  `number` int(4) NOT NULL COMMENT '邀请人数',
  `speed_up_multiple` int(4) NOT NULL COMMENT '释放倍数',
  `min_num` decimal(19,8) NOT NULL COMMENT '最小释放数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='加速释放设置表';


insert  into `speed_up_setting`(`id`,`stair`,`number`,`speed_up_multiple`,`min_num`,`create_time`,`update_time`) values 
(1,'一阶',2,2,1.00000000,now(),NULL),
(2,'二阶',10,3,2.00000000,now(),NULL),
(3,'三阶',15,4,3.00000000,now(),NULL);


/*Table structure for table `sys_department` */

DROP TABLE IF EXISTS `sys_department`;

CREATE TABLE `sys_department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) DEFAULT NULL COMMENT '部门名称',
  `description` varchar(255) DEFAULT NULL COMMENT '部门描述',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='部门表';

/*Table structure for table `sys_dictionary` */

DROP TABLE IF EXISTS `sys_dictionary`;

CREATE TABLE `sys_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `bond` varchar(255) NOT NULL COMMENT '键',
  `value` varchar(255) DEFAULT NULL COMMENT '值',
  `comment` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `bond` (`bond`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='系统字典表';

insert  into `sys_dictionary`(`id`,`bond`,`value`,`comment`,`create_time`,`update_time`) values 
(13,'freezeReleaseDay','30','冻结释放天数',NULL,now()),
(14,'pointsCnyRate','1','积分人民币比率',NULL,NULL),
(15,'speedUpReleaseInterval','1','加速任务释放时间间隔(单位：小时)',NULL,now()),
(17,'memberAuthTypeSimilarity','80','人脸识别相似度',NULL,now()),
(18,'memberAuthType','1','实名认证级别',NULL,NULL),
(19,'memberAuthAuto','0','是否开启自动认证，0是，1否',NULL,now()),
(20,'reportTime','5','举报隐藏次数',NULL,now()),
(21,'releaseVersion','http://124.156.208.223?linkedId=','注册邀请地址',NULL,NULL),
(22,'activePageUrl','http://www.baidu.cn','活动页路径',NULL,NULL);

/*Table structure for table `sys_permission` */

DROP TABLE IF EXISTS `sys_permission`;

CREATE TABLE `sys_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) NOT NULL COMMENT '权限名',
  `description` varchar(255) DEFAULT NULL COMMENT '权限描述',
  `url` varchar(255) DEFAULT NULL COMMENT '权限路径',
  `method` varchar(10) DEFAULT NULL COMMENT '权限方法',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级ID',
  `sort` int(3) DEFAULT NULL COMMENT '排序',
  `type` int(1) DEFAULT NULL COMMENT '权限类型0-菜单显示级1-菜单隐藏级2-按钮级',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `method` (`method`),
  KEY `type` (`type`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='权限表';

/*Table structure for table `sys_role` */

insert  into `sys_permission`(`id`,`title`,`description`,`url`,`method`,`parent_id`,`sort`,`type`,`create_time`,`update_time`) values 
(1,'系统管理','系统管理菜单','/admin/sys','GET',0,0,0,now(),NULL),
(2,'用户管理','系统用户菜单','/admin/sys/user','GET',1,0,0,now(),NULL),
(3,'查询当前用户','查询当前用户','/admin/sys-users/current-user','GET',2,0,2,now(),NULL),
(4,'分页查询用户','分页查询用户','/admin/sys-users/page','POST',2,0,2,now(),NULL),
(5,'查询用户','查询用户','/admin/sys-users/{id}','GET',2,0,2,now(),NULL),
(6,'添加用户','添加用户','/admin/sys-users','POST',2,0,2,now(),NULL),
(7,'删除用户','删除用户','/admin/sys-users','DELETE',2,0,2,now(),NULL),
(8,'修改用户','修改用户','/admin/sys-users/{id}','PUT',2,0,2,now(),NULL),
(9,'修改密码','修改密码','/admin/sys-users/password','PUT',2,0,2,now(),NULL),
(10,'刷新Token','刷新Token','/admin/sys-users/token','GET',2,0,2,now(),NULL),
(11,'用户登出','用户登出','/admin/sys-users/logout','GET',2,0,2,now(),NULL),
(12,'角色管理','系统角色菜单','/admin/sys/role','GET',1,0,0,now(),NULL),
(13,'删除角色','删除角色','/admin/sys-roles','DELETE',12,0,2,now(),NULL),
(14,'查询角色','查询角色','/admin/sys-roles','GET',12,0,2,now(),NULL),
(15,'添加角色','添加角色','/admin/sys-roles','POST',12,0,2,now(),NULL),
(16,'获取用户角色','获取用户角色','/admin/sys-roles/users/{userId}','GET',12,0,2,now(),NULL),
(17,'修改角色','修改角色','/admin/sys-roles/{roleId}','PUT',12,0,2,now(),NULL),
(18,'分配角色','分配角色','/admin/sys-roles/{userId}','POST',12,0,2,now(),NULL),
(19,'权限管理','系统权限菜单','/admin/sys/permission','GET',1,0,0,now(),NULL),
(20,'删除权限','删除权限','/admin/sys-permissions','DELETE',19,0,2,now(),NULL),
(21,'查询权限','查询权限','/admin/sys-permissions/page','POST',19,0,2,now(),NULL),
(22,'添加权限','添加权限','/admin/sys-permissions','POST',19,0,2,now(),NULL),
(23,'修改权限','修改权限','/admin/sys-permissions/{permissionId}','PUT',19,0,2,now(),NULL),
(24,'获取用户权限','获取用户权限','/admin/sys-permissions/users/{userId}','GET',19,0,2,now(),NULL),
(25,'获取角色权限','获取角色权限','/admin/sys-permissions/roles/{roleId}','GET',19,0,2,now(),NULL),
(26,'重置权限','重置权限','/admin/sys-permissions/roles/{roleId}','PUT',19,0,2,now(),NULL),
(27,'查询层级权限','查询层级权限','/admin/sys-permissions/trees','GET',19,0,2,now(),NULL),
(28,'查询用户层级权限','查询用户层级权限','/admin/sys-permissions/trees/{userId}','GET',19,0,2,now(),NULL),
(29,'版本管理','版本管理','/admin/app/revision','GET',1,0,0,now(),NULL),
(30,'新增版本','新增版本','/admin/app-revision','POST',29,0,2,now(),NULL),
(31,'查询','多条件查询版本','/admin/app-revision/page-query','POST',29,0,2,now(),NULL),
(32,'详情','查询版本详情','/admin/app-revision/{id}','GET',29,0,2,now(),NULL),
(33,'内容管理','内容管理','/admin/content','GET',0,0,0,now(),NULL),
(34,'广告(轮播图)管理','广告(轮播图)管理','/admin/banner','GET',33,0,0,now(),NULL),
(35,'删除','删除','/admin/banner','DELETE',34,0,2,now(),NULL),
(36,'新增','新增轮播图','/admin/banner','POST',34,0,2,now(),NULL),
(37,'查询','多条件查询版本','/admin/banner/page-query','POST',34,0,2,now(),NULL),
(38,'置顶','轮播图置顶','/admin/banner/top/{serialNumber}','PATCH',34,0,2,now(),NULL),
(39,'修改','修改轮播图','/admin/banner/{serialNumber}','PUT',34,0,2,now(),NULL),
(40,'帮助管理','系统帮助管理','/admin/system/help','GET',33,0,0,now(),NULL),
(41,'删除','删除帮助','/admin/system-help','DELETE',40,0,2,now(),NULL),
(42,'新增','新增帮助','/admin/system-help','POST',40,0,2,now(),NULL),
(43,'查询','多条件查询帮助','/admin/system-help/page-query','POST',40,0,2,now(),NULL),
(44,'置顶','帮助置顶','/admin/system-help/top/{id}','PUT',40,0,2,now(),NULL),
(45,'取消置顶','帮取消置顶','/admin/system-help/down/{id}','PUT',40,0,2,now(),NULL),
(46,'详情','帮助管理详情','/admin/system-help/{id}','GET',40,0,2,now(),NULL),
(47,'修改','修改帮助','/admin/system-help/{id}','PUT',40,0,2,now(),NULL),
(48,'公告管理','公告管理','/admin/notice','GET',33,0,0,now(),NULL),
(49,'删除','删除公告','/admin/notice','DELETE',48,0,2,now(),NULL),
(50,'新增','新增公告','/admin/notice','POST',48,0,2,now(),NULL),
(51,'查询','多条件查询公告','/admin/notice/page-query','POST',48,0,2,now(),NULL),
(52,'置顶','公告置顶','/admin/notice/top/{id}','PATCH',48,0,2,now(),NULL),
(53,'取消置顶','取消置顶','/admin/notice/down/{id}','PATCH',48,0,2,now(),NULL),
(54,'详情','公告详情','/admin/notice/{id}','GET',48,0,2,now(),NULL),
(55,'修改','修改公告','/admin/notice/{id}','PUT',48,0,2,now(),NULL),
(56,'关闭','关闭公告','/admin/notice/{id}/turn-off','PATCH',48,0,2,now(),NULL),
(57,'启用','启用公告','/admin/notice/{id}/turn-on','PATCH',48,0,2,now(),NULL),
(58,'社区管理','社区管理','/admin/community','GET',0,0,0,now(),NULL),
(59,'话题分类','话题分类','/admin/news/news/type','GET',58,0,0,now(),NULL),
(60,'删除','删除话题分类','/admin/news/news-type/{typeId}','DELETE',59,0,2,now(),NULL),
(61,'新增','新增话题分类','/admin/news/news-type','POST',59,0,2,now(),NULL),
(62,'查询所有分类','查询所有话题分类','/admin/news/news-type','GET',59,0,2,now(),NULL),
(63,'查询上架分类','查询上架话题分类','/admin/news/news-type/is-show','GET',59,0,2,now(),NULL),
(64,'查询','多条件查询话题分类','/admin/news/news-type/page-query','POST',59,0,2,now(),NULL),
(65,'编辑','修改话题分类','/admin/news/news-type/{id}','PUT',59,0,2,now(),NULL),
(66,'话题管理','话题管理','/admin/news/news','GET',58,0,0,now(),NULL),
(67,'删除','删除话题','/admin/news/news/{newsId}','DELETE',66,0,2,now(),NULL),
(69,'查询详情','查询话题详情','/admin/news/news/{newsId}','GET',66,0,2,now(),NULL),
(70,'查询话题','多条件查询话题','/admin/news/news/page-query','POST',66,0,2,now(),NULL),
(73,'是否显示','是否显示话题评论','/admin/news/appraisal','PATCH',66,0,2,now(),NULL),
(74,'查询话题评论','多条件查询话题评论','/admin/news/appraisal/page-query','POST',66,0,2,now(),NULL),
(76,'举报管理','话题管理','/admin/news/report','GET',58,0,0,now(),NULL),
(77,'是否显示','是否显示话题评论','/admin/news/appraisal','PATCH',76,0,2,now(),NULL),
(78,'查询','多条件查询话题评论','/admin/news/appraisal/page-query','POST',76,0,2,now(),NULL),
(79,'系统日志','系统日志菜单','/admin/sys/log','GET',1,0,0,now(),NULL),
(80,'日志查询','查询日志','/admin/sys-log','GET',79,0,2,now(),NULL),
(81,'添加','新增话题信息','admin/news/news','POST',66,0,2,NULL,NULL),
(82,'部门管理','部门管理','/admin/sys/department','GET',1,0,0,NULL,NULL),
(83,'添加','新增部门','/admin/sys-department','POST',82,0,2,NULL,NULL),
(84,'部门列表','分页获取部门列表','/admin/sys-department/page','POST',82,0,2,NULL,NULL),
(85,'删除','删除部门','/admin/sys-department/{id}','DELETE',82,0,2,NULL,NULL),
(86,'获取部门','获取指定部门信息','/admin/sys-department/{id}','GET',82,0,2,NULL,NULL),
(87,'修改','修改制定部门信息','/admin/sys-department/{id}','PUT',82,0,2,NULL,NULL),
(88,'字典管理','系统的字典管理','/admin/sys/dictionary','GET',1,0,0,NULL,NULL),
(89,'添加','新增字典信息','/admin/sys-dictionary','POST',88,0,2,NULL,NULL),
(90,'获取信息','分页获取字典信息','/admin/sys-dictionary/page','POST',88,0,2,NULL,NULL),
(91,'删除','删除指定字典信息','/admin/sys-dictionary/{id}','DELETE',88,0,2,NULL,NULL),
(92,'获取指定','获取指定字典信息\n','/admin/sys-dictionary/{id}','GET',88,0,2,NULL,NULL),
(93,'修改','修改指定字典信息','/admin/sys-dictionary/{id}','PUT',88,0,2,NULL,NULL),
(95,'茶抵贷','茶抵贷管理','/admin/teadebts','GET',0,0,0,NULL,NULL),
(96,'项目管理','茶抵债项目管理','/admin/teadebts/promanage','GET',95,0,0,NULL,NULL),
(97,'订单管理','茶抵债订单管理','/admin/teadebts/ordermanage','GET',95,0,0,NULL,NULL),
(98,'新增','新增茶抵贷','/admin/tea-item','POST',96,0,2,NULL,NULL),
(99,'查询订单','条件查询茶抵贷订单','/admin/tea-item/order/page-query','POST',97,0,2,NULL,NULL),
(100,'查询','条件查询茶抵贷','/admin/tea-item/page-query','POST',96,0,2,NULL,NULL),
(101,'删除','删除茶抵贷','/admin/tea-item/{id}','DELETE',96,0,2,NULL,NULL),
(102,'更改','更改茶抵贷','/admin/tea-item/{id}','PUT',96,0,2,NULL,NULL),
(103,'置顶','是否置顶茶抵贷','/admin/tea-item/{id}/{isTop}','PATCH',96,0,2,NULL,NULL),
(104,'会员管理','会员管理','/admin/members','GET',0,0,0,NULL,NULL),
(105,'会员管理','会员管理','/admin/membermanage','GET',104,0,0,NULL,NULL),
(106,'会员列表','分页获取会员列表','/admin/member/page-query','POST',105,0,2,NULL,NULL),
(107,'积分兑换管理','积分兑换管理','/admin/grade','GET',1,0,0,NULL,NULL),
(108,'实名管理','会员管理下的实名管理','/admin/member/memberaudit','GET',104,0,0,NULL,NULL),
(109,'修改','积分兑换修改','/admin/exchange-setting/{id}','PUT',107,0,2,NULL,NULL),
(110,'列表','积分兑换列表','/admin/exchange-setting/page-query','POST',107,0,2,NULL,NULL),
(111,'币币兑换设置','币币兑换设置','/admin/coin/exchange','GET',1,0,0,NULL,NULL),
(112,'积分加速释放设置','积分加速释放设置','/admin/speed/setting','GET',1,0,0,NULL,NULL),
(113,'获取数据','获取数据','/admin/speed-setting/{id}','GET',112,0,2,NULL,NULL),
(114,'修改','修改积分释放','/admin/speed-setting/{id}','PUT',112,0,2,NULL,NULL),
(116,'TEA理财','TEA理财','/admin/financial','GET',0,0,0,NULL,NULL),
(117,'项目管理','TEA理财的项目管理','/admin/finance/item','GET',116,0,0,NULL,NULL),
(118,'条件查询币理财','分页获取币理财数据','/admin/financial-item/page-query','POST',117,0,2,NULL,NULL),
(119,'新增币理财','新增币理财','/admin/financial-item','POST',117,0,2,NULL,NULL),
(120,'修改币理财','修改币理财信息','/admin/financial-item/{id}','PUT',117,0,2,NULL,NULL),
(121,'删除币理财','删除币理财','/admin/financial-item/{id}','DELETE',117,0,2,NULL,NULL),
(122,'订单管理','TEA理财的订单管理','/admin/financial/item/order','GET',116,0,0,NULL,NULL),
(123,'条件查询币理财订单','条件查询币理财订单','/admin/financial-item/order/page-query','POST',122,0,2,NULL,NULL),
(124,'分页列表','实名管理的分页列表数据','/admin/member-auth/page','POST',108,0,2,NULL,NULL),
(125,'禁用解禁账号','会员管理禁用解禁账号','/admin/member/{memberId}/{status}','PATCH',105,0,2,NULL,NULL),
(126,'删除','举报管理删除','/admin/news/appraisal/{appraisalId}','DELETE',76,0,2,NULL,NULL),
(127,'member详情','用户member详情','/admin/member/{memberId}','GET',105,0,2,NULL,NULL),
(128,'重置密码','重置会员用户的密码','/admin/member/reset-pwd','PATCH',105,0,2,NULL,NULL),
(129,'禁用/解禁','禁用/解禁会员用户的账号','/admin/member/{memberId}/{status}','PATCH',105,0,2,NULL,NULL),
(130,'积分记录','分页查询积分记录','/admin/record/member-transaction/points','POST',105,0,2,NULL,NULL),
(131,'资产记录','分页查询资产记录','/admin/record/member-transaction','POST',105,0,2,NULL,NULL),
(133,'实名详情','实名通过的详情','/admin/member-auth/{id}','GET',108,0,2,NULL,NULL),
(134,'实名不通过','实名审核不通过','/admin/member-auth/no-pass/{id}','PUT',108,0,2,NULL,NULL),
(135,'实名通过','实名审核通过','/admin/member-auth/pass/{id}','PUT',108,0,2,NULL,NULL),
(136,'财务管理','财务管理','/admin/finance/manage','GET',0,0,0,NULL,NULL),
(137,'币种管理','币种管理','/admin/finance/coinManage','GET',136,0,0,NULL,NULL),
(138,'提币审核','提币审核','/admin/finance/withdraw','GET',136,0,0,NULL,NULL),
(139,'提币记录','分页查询提币记录','/admin/withdraw/page','GET',138,0,2,NULL,NULL),
(140,'人工放币','人工单笔打款','/admin/withdraw/handle/{id}','PATCH',138,0,2,NULL,NULL),
(141,'详情','查看提币信息详情','/admin/withdraw/{id}','GET',138,0,2,NULL,NULL),
(142,'一键通过','一键审核通过','/admin/withdraw/pass','PATCH',138,0,2,NULL,NULL),
(143,'一键不通过','一键审核不通过','/admin/withdraw/no-pass','PATCH',138,0,2,NULL,NULL),
(144,'上传图片','上传图片','/admin/upload-cos/image','POST',34,0,2,NULL,NULL),
(145,'批量打款','人工批量打款处理','/admin/withdraw/handle-batch','PATCH',138,0,2,NULL,NULL),
(147,'手续费管理','手续费管理','/admin/finance/feemanage','GET',136,0,0,NULL,NULL),
(148,'分页手续费','分页查询手续费','/admin/finance/member-transaction','POST',147,0,2,NULL,NULL),
(149,'充币记录','充币记录','/admin/finance/chargecoin','GET',136,0,0,NULL,NULL),
(150,'分页充币记录','分页获取充币记录','/admin/finance/member-deposit','POST',149,0,2,NULL,NULL),
(151,'提币明细','提币明细','/admin/finance/pickup','GET',136,0,0,NULL,NULL),
(152,'分页提币明细','分页获取 提币明细','/admin/finance/withdraw-record','POST',151,0,2,NULL,NULL),
(153,'新增币种','币种管理  新增币种','/admin/coin','POST',137,0,2,NULL,NULL),
(154,'查询币种','币种管理  查询币种','/admin/coin','GET',137,0,2,NULL,NULL),
(155,'查询币种详情','查询币种详情','/admin/coin/{name}','GET',137,0,2,NULL,NULL),
(156,'转入冷钱包','转入冷钱包','/admin/coin/transfer','POST',137,0,2,NULL,NULL),
(157,'短信验证','币种管理 短信验证','/admin/coin/code','GET',137,0,2,NULL,NULL),
(158,'修改币种','修改币种详情','/admin/coin/{name}','PATCH',137,0,2,NULL,NULL),
(159,'充币','会员管理 详情 充币','/admin/member-wallet/recharge/{walletId}','PATCH',105,0,2,NULL,NULL),
(160,'重置地址','重置用户钱包地址','/admin/member-wallet/address/{walletId}','PATCH',105,0,2,NULL,NULL),
(161,'禁用/解禁','禁用/解禁用户钱包','/admin/member-wallet/{walletId}/{status}','PATCH',105,0,2,NULL,NULL),
(162,'导出','会员管理导出列表','/admin/export/data-export-member/{statementVO}','GET',105,0,2,NULL,NULL),
(163,'查看明细分页','查看明细分页','/admin/coin/collect-details','GET',137,0,2,NULL,NULL),
(164,'导出','TEA理财 导出','/admin/export/data-export-financial-order/{statementVO}','GET',122,0,2,NULL,NULL),
(165,'导出','茶抵贷 导出','/admin/export/data-export-tea-order/{statementVO}','GET',97,0,2,NULL,NULL),
(166,'添加热钱包','添加钱包','/admin/hot-address/{coinName}','POST',137,0,2,NULL,NULL),
(167,'站内信','站内信','/admin/system/message','GET',1,0,0,NULL,NULL),
(168,'分页信息','分页信息','/admin/message/query','POST',167,0,2,NULL,NULL),
(169,'添加钱包','币种管理 添加钱包','/admin/coin/new/{name}','POST',137,0,2,NULL,NULL),
(170,'删除消息','删除站内消息','/admin/message','DELETE',167,0,2,NULL,NULL),
(171,'获取实名信息','获取实名信息','/admin/member-auth/member/{id}','GET',105,0,2,NULL,NULL),
(172,'新消息已读','新消息标记已读','/admin/message','PATCH',167,0,2,NULL,NULL),
(173,'解锁','锁屏解锁','/admin/sys-users/lock-screen','POST',2,0,2,NULL,NULL),
(174,'自动放币','自动放币','/admin/withdraw/do','POST',138,0,2,NULL,NULL),
(175,'自动放币','自动放币','/admin/withdraw/do','POST',138,0,2,NULL,NULL),
(176,'商城总积分','获取商城总积分','/admin/member/mall-points/{memberId}','GET',105,0,2,NULL,NULL);


DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role` varchar(255) NOT NULL COMMENT '角色名',
  `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Table structure for table `sys_role_permission` */

insert  into `sys_role`(`id`,`role`,`description`,`create_time`,`update_time`) values 
(1,'系统管理员','系统管理员',NULL,NULL);

DROP TABLE IF EXISTS `sys_role_permission`;

CREATE TABLE `sys_role_permission` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `rule_id` bigint(20) NOT NULL COMMENT '权限ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

/*Table structure for table `sys_user` */
insert  into `sys_role_permission`(`role_id`,`rule_id`) values 
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,173),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,18),
(1,19),
(1,20),
(1,21),
(1,22),
(1,23),
(1,24),
(1,25),
(1,26),
(1,27),
(1,28),
(1,29),
(1,30),
(1,31),
(1,32),
(1,79),
(1,80),
(1,82),
(1,83),
(1,84),
(1,85),
(1,86),
(1,87),
(1,88),
(1,89),
(1,90),
(1,91),
(1,92),
(1,93),
(1,107),
(1,109),
(1,110),
(1,111),
(1,112),
(1,113),
(1,114),
(1,167),
(1,168),
(1,170),
(1,172),
(1,33),
(1,34),
(1,35),
(1,36),
(1,37),
(1,38),
(1,39),
(1,144),
(1,40),
(1,41),
(1,42),
(1,43),
(1,44),
(1,45),
(1,46),
(1,47),
(1,48),
(1,49),
(1,50),
(1,51),
(1,52),
(1,53),
(1,54),
(1,55),
(1,56),
(1,57),
(1,58),
(1,59),
(1,60),
(1,61),
(1,62),
(1,63),
(1,64),
(1,65),
(1,66),
(1,67),
(1,69),
(1,70),
(1,73),
(1,74),
(1,81),
(1,76),
(1,77),
(1,78),
(1,126),
(1,95),
(1,96),
(1,98),
(1,100),
(1,101),
(1,102),
(1,103),
(1,97),
(1,99),
(1,165),
(1,104),
(1,105),
(1,106),
(1,125),
(1,127),
(1,128),
(1,129),
(1,130),
(1,131),
(1,159),
(1,160),
(1,161),
(1,162),
(1,171),
(1,176),
(1,108),
(1,124),
(1,133),
(1,134),
(1,135),
(1,116),
(1,117),
(1,118),
(1,119),
(1,120),
(1,121),
(1,122),
(1,123),
(1,164),
(1,136),
(1,137),
(1,153),
(1,154),
(1,155),
(1,156),
(1,157),
(1,158),
(1,163),
(1,166),
(1,169),
(1,138),
(1,139),
(1,140),
(1,141),
(1,142),
(1,143),
(1,145),
(1,174),
(1,175),
(1,147),
(1,148),
(1,149),
(1,150),
(1,151),
(1,152);


DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '登录密码',
  `phone` varchar(16) NOT NULL COMMENT '手机号码',
  `real_name` varchar(32) NOT NULL COMMENT '真实姓名',
  `department_id` bigint(20) NOT NULL COMMENT '部门ID',
  `status` int(1) DEFAULT NULL COMMENT '状态0-可用1-禁用',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `last_login_ip` varchar(30) DEFAULT NULL COMMENT '上次登录IP',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登录时间',
  `qq` varchar(16) DEFAULT NULL COMMENT 'QQ号码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `phone` (`phone`),
  KEY `username` (`username`,`password`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='后台系统用户表';

/*Table structure for table `sys_user_role` */

insert  into `sys_user`(`id`,`username`,`password`,`phone`,`real_name`,`department_id`,`status`,`avatar`,`email`,`last_login_ip`,`last_login_time`,`qq`,`create_time`,`update_time`) values 
(1,'kings','$2a$10$VGQWSB7T0penoR2xAB8lvO7N7nNEMP2efSLFLfckEQetP.lnlA.1y','13639810570','king',2,0,NULL,'dddddd456@163.com',NULL,NULL,'123456',NULL,NULL);

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

/*Table structure for table `tb_activity` */
insert  into `sys_user_role`(`user_id`,`role_id`) values (1,1);


DROP TABLE IF EXISTS `tb_activity`;

CREATE TABLE `tb_activity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id 自增',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` varchar(2048) DEFAULT NULL COMMENT '内容',
  `img_url` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `link_address` varchar(255) DEFAULT NULL COMMENT '图文链接地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `status` int(1) DEFAULT NULL COMMENT '状态0-启用 1-作废',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动表';

/*Table structure for table `tb_banner` */

DROP TABLE IF EXISTS `tb_banner`;

CREATE TABLE `tb_banner` (
  `serial_number` varchar(255) NOT NULL COMMENT '编号',
  `author` varchar(255) DEFAULT NULL COMMENT '创建人',
  `content` text COMMENT '内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `link_url` varchar(1024) DEFAULT NULL,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sorts` int(4) NOT NULL COMMENT '排序',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `status` int(1) NOT NULL COMMENT '状态0正常1非法',
  `sys_advertise_location` int(1) NOT NULL COMMENT '广告位置0app首页轮播1pc首页轮播',
  `url` varchar(255) NOT NULL COMMENT 'url',
  PRIMARY KEY (`serial_number`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统轮播图';

/*Table structure for table `tb_help` */

DROP TABLE IF EXISTS `tb_help`;

CREATE TABLE `tb_help` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `help_title` varchar(255) NOT NULL COMMENT '帮助标题',
  `help_content` text NOT NULL COMMENT '帮助内容',
  `sorts` int(2) DEFAULT NULL COMMENT '排序',
  `is_show` int(1) DEFAULT NULL COMMENT '是否显示0是1否',
  `is_top` int(1) DEFAULT NULL COMMENT '是否置顶0是1否',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='系统帮助表';

/*Table structure for table `tb_news` */

DROP TABLE IF EXISTS `tb_news`;

CREATE TABLE `tb_news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tb_news_type_id` bigint(20) NOT NULL COMMENT '分类id',
  `news_type_name` varchar(50) NOT NULL COMMENT '名称',
  `new_title` varchar(30) NOT NULL COMMENT '标题',
  `new_desc` varchar(1024) DEFAULT NULL COMMENT '文章描述',
  `show_status` char(1) NOT NULL COMMENT '是否显示 0是1否',
  `top_status` char(1) NOT NULL COMMENT '是否置顶 0是1否',
  `browse_amount` int(11) DEFAULT '0' COMMENT '浏览次数',
  `favorite_amount` int(11) DEFAULT '0' COMMENT '收藏次数',
  `thumbs_up_amount` int(11) DEFAULT '0' COMMENT '点赞次数',
  `appraisal_amount` int(11) DEFAULT '0' COMMENT '评论次数',
  `share_amount` int(11) DEFAULT '0' COMMENT '分享次数',
  `sorts` int(11) NOT NULL COMMENT '分类排序',
  `new_content` text NOT NULL COMMENT '文章信息内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `view_pic` varchar(1024) DEFAULT NULL COMMENT '资讯缩略图',
  `img_video` varchar(1024) DEFAULT NULL COMMENT '图片视频url',
  `operator_name` varchar(255) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `tb_news_type_id` (`tb_news_type_id`),
  KEY `new_title` (`new_title`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='文章表';

/*Table structure for table `tb_news_appraisal` */

DROP TABLE IF EXISTS `tb_news_appraisal`;

CREATE TABLE `tb_news_appraisal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tb_news_id` bigint(20) NOT NULL COMMENT '文章id',
  `tb_user_id` bigint(20) NOT NULL COMMENT '用户id',
  `appraisal_content` varchar(2048) DEFAULT NULL COMMENT '评论内容',
  `show_status` char(1) NOT NULL COMMENT '是否显示 0是1否',
  `tip_off_amount` int(11) NOT NULL DEFAULT '0' COMMENT '举报次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='文章评价表';

/*Table structure for table `tb_news_thumbs_up` */

DROP TABLE IF EXISTS `tb_news_thumbs_up`;

CREATE TABLE `tb_news_thumbs_up` (
  `news_id` bigint(20) NOT NULL COMMENT '文章id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章点赞表';

/*Table structure for table `tb_news_type` */

DROP TABLE IF EXISTS `tb_news_type`;

CREATE TABLE `tb_news_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `news_type_name` varchar(50) NOT NULL COMMENT '名称',
  `status` char(1) NOT NULL COMMENT '是否可用 0-是1-否',
  `type_desc` varchar(2048) NOT NULL COMMENT '分类描述',
  `sorts` int(11) NOT NULL COMMENT '分类排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `INDEX_NAME` (`news_type_name`),
  KEY `news_type_name` (`news_type_name`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='文章分类表';

/*Table structure for table `tb_notice` */

DROP TABLE IF EXISTS `tb_notice`;

CREATE TABLE `tb_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `img_url` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `is_show` bit(1) DEFAULT NULL COMMENT '是否显示 0-不显示 1-显示',
  `sorts` int(4) NOT NULL COMMENT '排序',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `is_top` varchar(8) DEFAULT NULL COMMENT '是否置顶 0-置顶 1-不置顶(默认)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='公告表';

/*Table structure for table `tb_sys_msg` */

DROP TABLE IF EXISTS `tb_sys_msg`;

CREATE TABLE `tb_sys_msg` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id 自增',
  `msg_type` char(1) DEFAULT NULL COMMENT '消息类型0-纯文字 1-纯图片2-图文链接',
  `content` text COMMENT '内容',
  `img_url` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `title` varchar(255) DEFAULT NULL COMMENT '图文链接标题',
  `link_address` varchar(255) DEFAULT NULL COMMENT '图文链接地址',
  `push_status` char(1) DEFAULT NULL COMMENT '推送状态0-已推送1-待推送2-已撤回',
  `push_time` datetime DEFAULT NULL COMMENT '推送时间 如果立即推送等于创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(1) DEFAULT NULL COMMENT '状态0-启用 1-作废',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统消息表';

/*Table structure for table `tea_item` */

DROP TABLE IF EXISTS `tea_item`;

CREATE TABLE `tea_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `item_name` varchar(255) DEFAULT NULL COMMENT '项目名',
  `coin_name` varchar(10) NOT NULL COMMENT '币种',
  `yield` decimal(18,8) NOT NULL COMMENT '收益率',
  `locked` decimal(18,8) NOT NULL COMMENT '已锁定',
  `number` int(8) NOT NULL COMMENT '抢购人数',
  `sum` decimal(19,8) NOT NULL COMMENT '总数',
  `odd_num` decimal(19,8) NOT NULL COMMENT '剩余数',
  `deadline` int(5) NOT NULL COMMENT '锁仓时间',
  `coin_minnum` decimal(19,8) NOT NULL COMMENT '起购数量',
  `quota` decimal(19,8) NOT NULL COMMENT '限购数数量',
  `start_time` datetime NOT NULL COMMENT '抵贷开始时间',
  `end_time` datetime NOT NULL COMMENT '抵贷结束时间',
  `pic_url` varchar(1024) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL COMMENT '视频',
  `item_desc` text COMMENT '抵押信息',
  `item_id` varchar(255) DEFAULT NULL COMMENT '项目编码',
  `carry_interest_num` int(5) NOT NULL COMMENT '起息延迟天数',
  `item_state` int(2) NOT NULL COMMENT '项目状态0-不显示1-显示',
  `is_top` int(2) NOT NULL COMMENT '是否置顶0否1是',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='茶抵贷项目表';

/*Table structure for table `tea_order` */

DROP TABLE IF EXISTS `tea_order`;

CREATE TABLE `tea_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `coin_name` varchar(10) NOT NULL COMMENT '币种',
  `coin_num` decimal(18,8) NOT NULL COMMENT '理财数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `frozen_days` int(5) NOT NULL COMMENT '锁仓天数',
  `item_id` varchar(255) DEFAULT NULL COMMENT '项目编码',
  `item_name` varchar(255) DEFAULT NULL COMMENT '项目名',
  `member_id` bigint(20) NOT NULL COMMENT '用户ID',
  `order_no` bigint(20) DEFAULT NULL COMMENT '订单号',
  `order_state` int(2) NOT NULL COMMENT '订单状态0收益中1已收益2未收益',
  `order_usdt_rate` decimal(18,8) DEFAULT NULL COMMENT '对USDT汇率',
  `carry_interest_time` datetime NOT NULL COMMENT '起息日',
  `plan_revenue_time` datetime NOT NULL COMMENT '计划到期日',
  `real_income` decimal(18,8) DEFAULT NULL COMMENT '实际收益',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `yield` decimal(18,8) DEFAULT NULL COMMENT '收益率',
  `member_phone` varchar(64) DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `member_id` (`member_id`,`order_state`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='茶抵贷订单表';

/*Table structure for table `user_message` */

DROP TABLE IF EXISTS `user_message`;

CREATE TABLE `user_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(64) DEFAULT NULL COMMENT '消息标题',
  `title_content` varchar(1024) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL COMMENT '消息内容',
  `member_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8 COMMENT='用户消息表';

/*Table structure for table `wallet_info` */

DROP TABLE IF EXISTS `wallet_info`;

CREATE TABLE `wallet_info` (
  `coin_name` varchar(10) NOT NULL COMMENT '币种',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `balance` decimal(18,8) DEFAULT NULL COMMENT '币数量',
  `fee_balance` decimal(18,8) DEFAULT NULL COMMENT '矿工费数量',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员ID',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `address_id` varchar(100) DEFAULT NULL COMMENT '钱包中的id',
  KEY `IDX_ADDRESS` (`address`) USING BTREE COMMENT '地址索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='钱包地址信息表';

/*Table structure for table `withdraw_record` */

DROP TABLE IF EXISTS `withdraw_record`;

CREATE TABLE `withdraw_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `member_id` bigint(20) NOT NULL COMMENT '会员ID',
  `coin_id` varchar(10) NOT NULL COMMENT '币种',
  `address` varchar(128) NOT NULL COMMENT '到账地址',
  `total_amount` decimal(18,8) NOT NULL COMMENT '总数量',
  `arrived_amount` decimal(18,8) DEFAULT NULL COMMENT '到账数量',
  `fee` decimal(18,8) DEFAULT NULL COMMENT '手续费',
  `is_auto` int(1) NOT NULL COMMENT '是否自动1-是0-否',
  `transaction_number` varchar(255) DEFAULT NULL COMMENT '交易流水',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `deal_time` datetime DEFAULT NULL COMMENT '到账时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '会员备注',
  `status` int(1) NOT NULL COMMENT '记录状态0-审核中1-等待放币2-失败3-成功',
  `can_auto_withdraw` int(1) DEFAULT NULL COMMENT '是否支持自动提币1-是0-否',
  `admin_id` varchar(20) DEFAULT NULL COMMENT '操作人',
  `reason` varchar(255) DEFAULT NULL COMMENT '操作说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB   DEFAULT CHARSET=utf8;

/* Trigger structure for table `member_transaction` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tri_update_member_wallet` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `tri_update_member_wallet` BEFORE INSERT ON `member_transaction` FOR EACH ROW BEGIN
    declare msg_ba decimal(18, 8);
    declare msg_fba decimal(18, 8);
    declare msg_reba decimal(18, 8);
    select balance, frozen_balance, release_balance
    into msg_ba,msg_fba,msg_reba
    from member_wallet
    where member_id = new.member_id
      and coin_unit = new.coin_unit;
    if (new.transaction_type = 1) then
        update member_wallet wallet
        set wallet.frozen_balance = wallet.frozen_balance - ifnull(new.balance,0)
        where wallet.member_id = new.member_id
          and wallet.coin_unit = new.coin_unit;
    else
        if (new.balance + msg_ba < 0 or new.frozen_balance + msg_fba < 0 or new.release_balance + msg_reba < 0) then
            set new.member_id = null;
        else
            update member_wallet wallet
            set wallet.balance        = wallet.balance + ifnull(new.balance,0),
                wallet.frozen_balance = wallet.frozen_balance + ifnull(new.frozen_balance,0),
                wallet.release_balance=wallet.release_balance + ifnull(new.release_balance,0)
            where wallet.member_id = new.member_id
              and wallet.coin_unit = new.coin_unit;
        end if;
    end if;
END */$$


DELIMITER ;

/* Trigger structure for table `points_transaction` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tri_update_member_points` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `tri_update_member_points` BEFORE INSERT ON `points_transaction` FOR EACH ROW begin
	declare
		msg_ba decimal ( 18, 8 );
	declare
			msg_fba decimal ( 18, 8 );
select balance,frozen_balance into msg_ba,msg_fba
		from member_points where member_id = new.member_id;	
if
	new.balance + msg_ba < 0 or new.frozen_balance + msg_fba < 0  then
	set new.member_id = null;
else update member_points points 
	set points.balance = points.balance + new.balance,
	points.frozen_balance = points.frozen_balance + new.frozen_balance 
	where
		points.member_id = new.member_id;
end if;
end */$$


DELIMITER ;

/*Table structure for table `view_user_permission` */

DROP TABLE IF EXISTS `view_user_permission`;

/*!50001 DROP VIEW IF EXISTS `view_user_permission` */;
/*!50001 DROP TABLE IF EXISTS `view_user_permission` */;

/*!50001 CREATE TABLE  `view_user_permission`(
 `id` bigint(20) ,
 `title` varchar(255) ,
 `description` varchar(255) ,
 `url` varchar(255) ,
 `method` varchar(10) ,
 `parent_id` bigint(20) ,
 `sort` int(3) ,
 `type` int(1) ,
 `create_time` datetime ,
 `update_time` datetime ,
 `phone` varchar(16) 
)*/;

/*View structure for view view_user_permission */

/*!50001 DROP TABLE IF EXISTS `view_user_permission` */;
/*!50001 DROP VIEW IF EXISTS `view_user_permission` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_user_permission` AS select distinct `p`.`id` AS `id`,`p`.`title` AS `title`,`p`.`description` AS `description`,`p`.`url` AS `url`,`p`.`method` AS `method`,`p`.`parent_id` AS `parent_id`,`p`.`sort` AS `sort`,`p`.`type` AS `type`,`p`.`create_time` AS `create_time`,`p`.`update_time` AS `update_time`,`u`.`phone` AS `phone` from (((`sys_permission` `p` join `sys_role_permission` `rp`) join `sys_user_role` `ur`) join `sys_user` `u`) where ((`u`.`id` = `ur`.`user_id`) and (`ur`.`role_id` = `rp`.`role_id`) and (`rp`.`rule_id` = `p`.`id`)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

alter table member_authentication add index (member_id);
alter table sys_permission add index (method);
alter table sys_permission add index (type);
alter table coin add index (unit);
alter table hot_address_info add index (coin_name);
alter table member_points add index (member_id);
alter table member add index (phone);
alter table member_wallet add index (member_id);
alter table member_wallet add index (member_id,coin_unit);
alter table sys_user add index (phone);
alter table sys_user add index (username,`password`);
alter table tb_news add index (tb_news_type_id);
alter table tb_news add index (new_title);
alter table tb_news_type add index (news_type_name);
alter table app_version add index (app_cate);
alter table tea_order add index (item_id);
alter table tea_order add index (member_id,order_state);
alter table exchange_setting add index (deal_coin_name,close_coin_name);
alter table sys_dictionary add index (bond);
