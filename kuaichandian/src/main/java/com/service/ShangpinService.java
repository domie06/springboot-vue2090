package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.ShangpinEntity;
import java.util.Map;

/**
 * 商品表 服务类
 * @since 2021-03-08
 */
public interface ShangpinService extends IService<ShangpinEntity> {

     PageUtils queryPage(Map<String, Object> params);

}