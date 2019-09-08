package com.lingsh.dao;

import com.lingsh.bean.User;

import java.util.ArrayList;
import java.util.List;

/**
 * DTO具体实现类
 * 实现User bean类的持久化 增删查改
 *
 * 实现接口定义的职责 使用BaseDao的工具
 * 尽量做到 "单一职责原则" 只有一个变量
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-3 下午10:59
 */

public class UserDaoImpl extends BaseDao<User> implements UserDao {
    /**
     * 用户表名称
     */
    private String table_name = "users";

    /**
     * 这个方法 其实很失败
     * 是赶工的时候 贪快而写的
     *
     * @param tableName 设置复用表名 参与以下操作方法的sql
     */
    void setTableName(String tableName) {
        table_name = tableName;
    }

    @Override
    public boolean addUser(User user) {
        String sql = "insert into table_name(id, account, password, name) values(?,?,?,?)";
        sql = sql.replace("table_name", table_name);

        return update(sql, user.getId(), user.getAccount(), user.getPassword(), user.getName());
    }

    @Override
    public boolean deleteById(String id) {
        String sql = "delete from table_name where id=?";
        sql = sql.replace("table_name", table_name);

        return update(sql, id);
    }

    @Override
    public boolean deleteByAccount(String account) {
        String sql = "delete from table_name where account=?";
        sql = sql.replace("table_name", table_name);

        return update(sql, account);
    }

    @Override
    public boolean deleteByName(String name) {
        String sql = "delete from table_name where name=?";
        sql = sql.replace("table_name", table_name);

        return update(sql, name);
    }

    @Override
    public boolean update(User user) {
        String sql = "update table_name set account=?, password=?, name=? where id=?";
        sql = sql.replace("table_name", table_name);

        return update(sql, user.getAccount(), user.getPassword(), user.getName(), user.getId());
    }

    @Override
    public List<User> queryAllUsers() {
        String sql = "select * from table_name";
        sql = sql.replace("table_name", table_name);

        List<User> list = new ArrayList<>();
        query(sql, User.class, list);

        return list;
    }

    @Override
    public User queryById(Integer id) {
        String sql = "select * from table_name where id=?";
        sql = sql.replace("table_name", table_name);

        return query(sql, User.class,null, id);
    }

    @Override
    public User queryByAccount(String account) {
        String sql = "select * from table_name where account=?";
        sql = sql.replace("table_name", table_name);

        System.out.println("Query By Account:" + sql);

        return query(sql, User.class, null, account);
    }

    @Override
    public List<User> queryByName(String name) {
        String sql = "select * from table_name where name=?";
        sql = sql.replace("table_name", table_name);

        List<User> list = new ArrayList<>();
        query(sql, User.class, list, name);

        return list;
    }
}
