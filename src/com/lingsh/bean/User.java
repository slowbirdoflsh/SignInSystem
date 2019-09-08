package com.lingsh.bean;

/**
 * User Bean类
 * id 用户编号
 * account 用户登录账号
 * password 用户登录密码
 * name 用户名称
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-3 下午2:40
 */

public class User {
    /**
     * 用户编号 唯一主键
     */
    private Integer id;
    /**
     * 用户登录账号
     */
    private String account;
    /**
     * 用户登录密码
     */
    private String password;
    /**
     * 用户创建者姓名
     */
    private String name;

    /**
     * User 含有属性个数
     */
    public static final Integer SIZE = 4;

    /**
     * 无参构造函数
     * 使用反射必须要有
     */
    public User() {

    }

    public User(Integer id, String account, String password, String name) {
        this.id = id;
        this.account = account;
        this.password = password;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "User {" +
                "id=" + id +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
