package com.lingsh.dao;

import com.lingsh.utils.DBUtils;
import com.lingsh.utils.ReflectUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.List;

/**
 * 操作数据库业务的基类
 * 使用反射方式 转换获取结果类型
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-5 上午9:48
 */

public abstract class BaseDao<T> {

    /**
     * 数据库更新操作 --增加/删除/修改
     * 都可以通过该方法操作数据库
     *
     * @param sql     执行sql语句
     * @param options sql语句占位参数
     * @return 更新操作是否成功
     */
    protected Boolean update(String sql, Object... options) {
        // 1. 获取数据库连接
        Connection connection = DBUtils.getConnection();
        // 2. 初始化执行语句
        PreparedStatement preparedStatement = null;
        int rows = 0;
        try {
            assert connection != null;
            preparedStatement = connection.prepareStatement(sql);
            // 向执行语句填入参数
            for (int i = 0; i < options.length; i++) {
                preparedStatement.setObject(i + 1, options[i]);
            }
            // 获取更新行数
            rows = preparedStatement.executeUpdate();
            System.out.println(String.format("数据库更新了 %d 条记录", rows));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 3. 释放资源 执行语句和连接
            DBUtils.release(null, preparedStatement, connection);
        }
        return rows != 0;
    }

    /**
     * 数据库查询操作
     * 通过list参数控制查询数量(单个或多个)
     *
     * @param sql     sql语句
     * @param clazz   指定获取实例类型
     * @param list    存储查询多条数据时的内容
     * @param options sql语句的占位参数
     * @return 单个实例 / null 内容在list
     */
    protected T query(String sql, Class clazz, List<T> list, Object... options) {
        // 1. 获得数据库连接
        Connection connection = DBUtils.getConnection();
        // 2. 初始化执行语句
        PreparedStatement preparedStatement = null;
        // 3. 初始化结果集
        ResultSet resultSet = null;
        try {
            assert connection != null;
            preparedStatement = connection.prepareStatement(sql);
            if (options != null) {
                for (int i = 0; i < options.length; i++) {
                    preparedStatement.setObject(i + 1, options[i]);
                }
            }

            // 4. 获得查询结果集
            resultSet = preparedStatement.executeQuery();
            // 结果集元单元 可获得结果集列数
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columns = metaData.getColumnCount();

            while (resultSet.next()) {
                // 使用反射方式 获得输入Class的实例
                T bean = (T) ReflectUtils.newIntance(clazz);
                assert bean != null;
                for (int i = 1; i <= columns; i++) {
                    // 通过数据表的列名--Class的Field属性 --> 初始化该实例
                    String label = metaData.getColumnLabel(i);
                    Object value = resultSet.getObject(label);
                    // bean{label:value}
                    ReflectUtils.bindValueToField(bean, label, value);
                }
                // 通过控制输入的List参数来控制获取数据
                // 可以通过一个函数做到两份工作
                if (list == null) {
                    return bean;
                } else {
                    list.add(bean);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 5. 释放资源
            DBUtils.release(resultSet, preparedStatement, connection);
        }

        return null;
    }
}
