package com.lingsh.dao;

import com.lingsh.bean.Sign;

import java.util.List;
import java.util.Map;

/**
 * 签到情况表 业务操作定义
 * 增删查改
 *
 * @author lingsh
 */
public interface SignDao {
    /**
     * 添加签到记录
     *
     * @param sign 被添加的签到记录
     * @return 是否被添加成功
     */
    boolean addSign(Sign sign);

    /**
     * 删除签到记录
     *
     * @param sign 被删除的签到记录
     * @return 是否被删除成功
     */
    boolean deleteSign(Sign sign);

    /**
     * 通过记录的id 删除指定记录
     *
     * @param id 指定删除记录的id
     * @return 是否被删除成功
     */
    boolean deleteSignById(Integer id);

    /**
     * 通过记录的用户id 删除指定记录
     *
     * @param userId 指定删除记录的用户id
     * @return 是否被删除成功
     */
    boolean deleteSignByUserId(Integer userId);

    /**
     * 通过记录的id 查找指定记录
     *
     * @param id 被查找记录的id
     * @return 返回被查找的记录
     */
    Sign queryById(Integer id);

    /**
     * 通过记录的用户id 查找指定记录
     *
     * @param userId 被查找记录的用户id
     * @return 返回被查找的记录
     */
    Sign queryByUserId(Integer userId);

    /**
     * 查找所有签到记录
     *
     * @return 以列表的形式返回签到记录
     */
    List<Sign> queryAll();

    /**
     * 查找所有签到记录 附加用户姓名
     *
     * @return Map<sign.id               ,       sign.userId               ,       user.name               ,       sign.singDate>
     */
    List<Map> queryAllWithName();

    /**
     * 查找所有签到记录 附加用户姓名 筛选条件为用户姓名
     *
     * @param name 筛选条件 用户姓名
     * @return Map<sign.id       ,       sign.userId       ,       user.name       ,       sign.singDate>
     */
    List<Map> queryAllWithNameByName(String name);

    /**
     * 更新签到记录
     *
     * @param sign 新的签到记录
     * @return 是否被更新成功
     */
    boolean updateSign(Sign sign);
}
