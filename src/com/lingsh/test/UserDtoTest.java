package com.lingsh.test;

import com.lingsh.bean.User;
import com.lingsh.dao.UserDao;
import com.lingsh.dao.UserDaoImpl;

import java.util.List;

/**
 * 测试数据库连接和DTO
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-3 下午2:51
 */

public class UserDtoTest {
    public static void main(String[] args) {
        // test01();
        // test02();
    }

    private static void test02() {
        UserDao userDao = new UserDaoImpl();
        User user = new User(20, "admin", "123456", "test01");
        // 更新id=20的记录
        System.out.println("---------------更新id=20的记录-------------------");
        System.out.println(userDao.update(user));
        printUsers(userDao.queryAllUsers());
    }

    private static void test01() {
        UserDao userDao = new UserDaoImpl();

        // 打印所有记录
        System.out.println("---------------打印所有记录-------------------");
        printUsers(userDao.queryAllUsers());

        User user01 = new User(10, "this", "is", "test");
        User user02 = new User(15, "there", "are", "test");
        User user03 = new User(20, "here", "is", "test02");
        User user04 = new User(140, "that", "is", "test02");

        // 插入以上数据
        System.out.println("---------------插入以上数据-------------------");
        System.out.println(userDao.addUser(user01));
        System.out.println(userDao.addUser(user02));
        System.out.println(userDao.addUser(user03));
        System.out.println(userDao.addUser(user04));

        // 打印name=test的记录
        System.out.println("---------------打印name=test的记录-------------------");
        printUsers(userDao.queryByName("test"));

        // 打印account=that的记录
        System.out.println("---------------打印account=that的记录-------------------");
        System.out.println(userDao.queryByAccount("that"));

        // 删除name=test的记录
        System.out.println("---------------删除name=test的记录-------------------");
        System.out.println(userDao.deleteByName("test"));
        printUsers(userDao.queryAllUsers());

        // 删除account=that的记录
        System.out.println("---------------删除account=that的记录-------------------");
        System.out.println(userDao.deleteByAccount("that"));
        printUsers(userDao.queryAllUsers());

        // 更新数据
        System.out.println("---------------更新数据-------------------");
        printUsers(userDao.queryByName(user03.getName()));
        user03.setAccount("admin");
        user03.setPassword("123456");
        System.out.println(userDao.update(user03));
        printUsers(userDao.queryByName(user03.getName()));
    }

    private static void printUsers(List<User> users) {
        System.out.println("打印所查询的记录");
        for (User user : users) {
            System.out.println(user);
        }
    }
}
