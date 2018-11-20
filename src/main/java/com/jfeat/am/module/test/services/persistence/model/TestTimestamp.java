package com.jfeat.am.module.test.services.persistence.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author Code Generator
 * @since 2018-11-20
 */
@TableName("t_test_timestamp")
public class TestTimestamp extends Model<TestTimestamp> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 娴嬭瘯鍚嶇О
     */
	private String name;
    /**
     * 娴嬭瘯绫诲瀷
     */
	private String type;
    /**
     * 鐘舵��
     */
	private String status;
    /**
     * 鍒涘缓鏃堕棿
     */
	@TableField("create_time")
	private Date createTime;
    /**
     * 鏇存柊鏃堕棿
     */
	@TableField("update_time")
	private Date updateTime;
    /**
     * 缁撴潫鏃堕棿
     */
	@TableField("close_time")
	private Date closeTime;
    /**
     * 棰勭害鏃堕棿
     */
	@TableField("time_stamp")
	private Date timeStamp;


	public Long getId() {
		return id;
	}

	public TestTimestamp setId(Long id) {
		this.id = id;
		return this;
	}

	public String getName() {
		return name;
	}

	public TestTimestamp setName(String name) {
		this.name = name;
		return this;
	}

	public String getType() {
		return type;
	}

	public TestTimestamp setType(String type) {
		this.type = type;
		return this;
	}

	public String getStatus() {
		return status;
	}

	public TestTimestamp setStatus(String status) {
		this.status = status;
		return this;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public TestTimestamp setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public TestTimestamp setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
		return this;
	}

	public Date getCloseTime() {
		return closeTime;
	}

	public TestTimestamp setCloseTime(Date closeTime) {
		this.closeTime = closeTime;
		return this;
	}

	public Date getTimeStamp() {
		return timeStamp;
	}

	public TestTimestamp setTimeStamp(Date timeStamp) {
		this.timeStamp = timeStamp;
		return this;
	}

	public static final String ID = "id";

	public static final String NAME = "name";

	public static final String TYPE = "type";

	public static final String STATUS = "status";

	public static final String CREATE_TIME = "create_time";

	public static final String UPDATE_TIME = "update_time";

	public static final String CLOSE_TIME = "close_time";

	public static final String TIME_STAMP = "time_stamp";

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "TestTimestamp{" +
			"id=" + id +
			", name=" + name +
			", type=" + type +
			", status=" + status +
			", createTime=" + createTime +
			", updateTime=" + updateTime +
			", closeTime=" + closeTime +
			", timeStamp=" + timeStamp +
			"}";
	}
}
