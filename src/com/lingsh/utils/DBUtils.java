package com.lingsh.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

/**
 * 数据库操作工具类
 * 1. 获取数据库连接
 * 2. 释放资源
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-3 下午3:49
 */

public final class DBUtils {
    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    // 静态块 在类加载之前运行 且只运行一次
    static {
        ResourceBundle bundle = ResourceBundle.getBundle("database");
        driver = bundle.getString("driver");
        url = bundle.getString("url");
        username = bundle.getString("username");
        password = bundle.getString("password");
    }

    /**
     * 获得数据库连接
     * 这样是每查询一次都要新建一个连接 使用数据库池会更好
     *
     * @return 新建连接
     */
    public static Connection getConnection() {
        try {
            Class.forName(driver);
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 联表查询的一个尝试
     *
     * @param sql sql语句
     * @return 数据表 字段名:数据 KV列表
     */
    public static List<Map> getResultByQuery(String sql) {
        List<Map> result = new ArrayList<>();
        Connection connection = DBUtils.getConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            assert connection != null;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columns = metaData.getColumnCount();

            while (resultSet.next()) {
                Map<String, Object> map = new HashMap<>(columns);
                for (int i = 1; i <= columns; i++) {
                    String label = metaData.getColumnLabel(i);
                    Object value = resultSet.getObject(label);
                    map.put(label, value);
                }
                result.add(map);
            }

            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            release(resultSet, preparedStatement, connection);
        }

        return null;
    }

    /**
     * 释放资源
     *
     * @param resultSet 结果集
     * @param statement 执行语句
     * @param connection 数据库连接
     */
    public static void release(ResultSet resultSet, Statement statement, Connection connection){
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
