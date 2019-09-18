package com.lingsh.dao;

import com.lingsh.bean.Sign;
import com.lingsh.utils.DBUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 签到记录DAO类
 * 具体实现类
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-6 上午11:09
 */

public class SignDaoImpl extends BaseDao<Sign> implements SignDao {
    static final String TABLE_NAME = "sign";

    @Override
    public boolean addSign(Sign sign) {
        String sql = "insert into table_name(userId, signDate) values(?,?)";
        sql = sql.replace("table_name", TABLE_NAME);

        return update(sql, sign.getUserId(), sign.getSignDate());
    }

    @Override
    public boolean deleteSign(Sign sign) {
        return deleteSignById(sign.getId());
    }

    @Override
    public boolean deleteSignById(Integer id) {
        String sql = "delete from table_name where id=?";
        sql = sql.replace("table_name", TABLE_NAME);

        return update(sql, id);
    }

    @Override
    public boolean deleteSignByUserId(Integer userId) {
        String sql = "delete from table_name where userId=?";
        sql = sql.replace("table_name", TABLE_NAME);

        return update(sql, userId);
    }

    @Override
    public Sign queryById(Integer id) {
        String sql = "select * from table_name where id=?";
        sql = sql.replace("table_name", TABLE_NAME);

        return query(sql, Sign.class, null, id);
    }

    @Override
    public Sign queryByUserId(Integer userId) {
        String sql = "select * from table_name where userId=?";
        sql = sql.replace("table_name", TABLE_NAME);

        return query(sql, Sign.class, null, userId);
    }

    @Override
    public List<Sign> queryAll() {
        String sql = "select * from table_name";
        sql = sql.replace("table_name", TABLE_NAME);

        List<Sign> list = new ArrayList<>();
        query(sql, Sign.class, list);

        return list;
    }

    @Override
    public List<Map> queryAllWithName() {
        String sql = "select sign.id, sign.userId, users.name, sign.signDate " +
                "from sign, users " +
                "where sign.userId=users.id";

        return DBUtils.getResultByQuery(sql);
    }

    @Override
    public List<Map> queryAllWithNameByName(String name) {
        String sql = "select sign.id, sign.userId, users.name, sign.signDate " +
                "from sign, users " +
                "where sign.userId=users.id and users.name='" + name + "'";
        System.out.println("debug SignDao" + sql);

        return DBUtils.getResultByQuery(sql);
    }

    @Override
    public boolean updateSign(Sign sign) {
        String sql = "update table_name set userId=?, signDate=? where id=?";
        sql = sql.replace("table_name", TABLE_NAME);

        return update(sql, sign.getUserId(), sign.getSignDate(), sign.getId());
    }
}
