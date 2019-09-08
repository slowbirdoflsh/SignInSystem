package com.lingsh.dao;

/**
 * 管理员用户 数据库操作方法
 * 复用用户的方法 只是表名不同
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-7 上午9:51
 */

public class AdminUserDaoImpl extends UserDaoImpl {
    public AdminUserDaoImpl(){
        setTableName("admin_users");
    }
}
