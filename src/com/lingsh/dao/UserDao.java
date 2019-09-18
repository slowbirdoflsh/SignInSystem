package com.lingsh.dao;

import com.lingsh.bean.User;

import java.util.List;

/**
 * User bean类的持久化接口
 * <p>
 * 定义Dao对User的职责
 * 增加用户: addUser
 * 删除用户: deleteById/Account/Name
 * 查询用户: queryById/Account/Name
 * 更改用户: update
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-3 下午2:40
 */

public interface UserDao {
    /**
     * 添加用户
     *
     * @param user 用户Bean类
     * @return 是否添加成功
     */
    boolean addUser(User user);

    /**
     * 通过用户编号来删除数据库记录
     *
     * @param id 用户编号
     * @return 是否删除成功
     */
    boolean deleteById(String id);

    /**
     * 通过用户账号来删除数据库记录
     *
     * @param account 用户账号
     * @return 是否删除成功
     */
    boolean deleteByAccount(String account);

    /**
     * 通过用户名称来删除数据库记录
     *
     * @param name 用户名称
     * @return 是否删除成功
     */
    boolean deleteByName(String name);

    /**
     * 查询所有用户记录
     *
     * @return 以列表形式返回数据库中所有用户记录
     */
    List<User> queryAllUsers();

    /**
     * 查询指定用户编号的用户记录
     *
     * @param id 被指定用户账号编号
     * @return 返回数据库中所需用户记录
     */
    User queryById(Integer id);

    /**
     * 查询指定用户账号的用户记录
     *
     * @param account 被指定用户账号
     * @return 返回数据库中所需用户记录
     */
    User queryByAccount(String account);

    /**
     * 查询指定用户名称的用户记录
     *
     * @param name 被指定用户名称
     * @return 以列表形式返回数据库中所需用户记录
     */
    List<User> queryByName(String name);

    /**
     * 更新整条用户记录
     *
     * @param user 新的用户记录
     * @return 是否更新成功
     */
    boolean update(User user);
}
