DROP TABLE IF EXISTS `t_test_timestamp`;
CREATE TABLE `t_test_timestamp`(
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '测试名称',
  `type` varchar(26) DEFAULT NULL COMMENT '测试类型',
  `status` varchar(20) NOT NULL COMMENT '状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `close_time` datetime DEFAULT NULL COMMENT '结束时间',
  `time_stamp` datetime DEFAULT NULL COMMENT '预约时间',
  PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

