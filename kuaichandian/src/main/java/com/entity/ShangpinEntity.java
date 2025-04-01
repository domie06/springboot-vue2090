package com.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;

import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 商品表
 *
 * @email
 * @date 2021-03-08
 */
@TableName("shangpin")
public class ShangpinEntity<T> implements Serializable {
    private static final long serialVersionUID = 1L;


    public ShangpinEntity() {

    }

    public ShangpinEntity(T t) {
    try {
    BeanUtils.copyProperties(this, t);
    } catch (IllegalAccessException | InvocationTargetException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
    }
    }


    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    @TableField(value = "id")

    private Integer id;


    /**
     * 商品名称
     */
    @TableField(value = "hx_types")

    private Integer hxTypes;


    /**
     * 商品单价
     */
    @TableField(value = "money")

    private Double money;


    /**
     * 商品图片
     */
    @TableField(value = "img_photo")

    private String imgPhoto;


    /**
     * 商品描述
     */
    @TableField(value = "shangpin_content")

    private String shangpinContent;


    /**
	 * 设置：主键
	 */
    public Integer getId() {
        return id;
    }


    /**
	 * 获取：主键
	 */

    public void setId(Integer id) {
        this.id = id;
    }
    /**
	 * 设置：商品名称
	 */
    public Integer getHxTypes() {
        return hxTypes;
    }


    /**
	 * 获取：商品名称
	 */

    public void setHxTypes(Integer hxTypes) {
        this.hxTypes = hxTypes;
    }
    /**
	 * 设置：商品单价
	 */
    public Double getMoney() {
        return money;
    }


    /**
	 * 获取：商品单价
	 */

    public void setMoney(Double money) {
        this.money = money;
    }
    /**
	 * 设置：商品图片
	 */
    public String getImgPhoto() {
        return imgPhoto;
    }


    /**
	 * 获取：商品图片
	 */

    public void setImgPhoto(String imgPhoto) {
        this.imgPhoto = imgPhoto;
    }
    /**
	 * 设置：商品描述
	 */
    public String getShangpinContent() {
        return shangpinContent;
    }


    /**
	 * 获取：商品描述
	 */

    public void setShangpinContent(String shangpinContent) {
        this.shangpinContent = shangpinContent;
    }

    @Override
    public String toString() {
    return "Shangpin{" +
            "id=" + id +
            ", hxTypes=" + hxTypes +
            ", money=" + money +
            ", imgPhoto=" + imgPhoto +
            ", shangpinContent=" + shangpinContent +
    "}";
    }
    }
