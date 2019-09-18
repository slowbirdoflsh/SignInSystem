package com.lingsh.service;

import com.lingsh.bean.User;
import com.lingsh.constant.Constant;
import com.lingsh.dao.AdminUserDaoImpl;
import com.lingsh.dao.UserDao;
import com.lingsh.dao.UserDaoImpl;
import com.lingsh.utils.FormUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 用户服务类
 * 将jsp的逻辑代码和业务合集
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-8 下午11:59
 */

public class UserService extends BaseService implements Constant {
    /**
     * 日志
     */
    private final static Logger LOGGER = LogManager.getLogger(UserService.class);

    /**
     * 预先实例化 操作数据库的对象
     */
    private final static UserDao USER_DAO = new UserDaoImpl();
    private final static UserDao ADMIN_DAO = new AdminUserDaoImpl();

    /**
     * 已登录用户列表
     * 可以预存已登录用户 无需每次登录都查询数据库
     */
    private static Map<String, User> loginUsers = new HashMap<>(10);

    /**
     * 登录操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String login(String json) {
        LOGGER.info(String.format("login\t 登录前 先查看所有已登录用户\n %s", loginUsers));

        Map params = FormUtils.fromJson(json);
        LOGGER.info(String.format("login\t 前端传入参数列表 %s", params));

        String account = gets(params, ACCOUNT);
        String password = gets(params, PASSWORD);
        String auth = gets(params, AUTH);
        String timestamp = gets(params, TIMESTAMP);

        User user = getUser(account, auth);
        LOGGER.info(String.format("login\t 数据库查询到的用户 user:%s", user));

        if (Objects.isNull(user) || !Objects.equals(user.getPassword(), password)) {
            LOGGER.error(String.format("login\terror %s", ERROR_INPUT_USER_PWD));
            return retJ(FAILED, ERROR_INPUT_USER_PWD);
        }

        String id = concatId("#", auth, account, timestamp);
        loginUsers.put(id, user);
        LOGGER.info(String.format("login\t 当前登录列表 users: %s", loginUsers));

        return retJ(SUCCESS, SUCCESS_MSG);
    }

    /**
     * 注册/新建用户操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String signup(String json) {
        LOGGER.info(String.format("signup\t json: %s", json));

        Map map = FormUtils.fromJson(json);
        String account = gets(map, ACCOUNT);
        String password = gets(map, PASSWORD);
        String name = gets(map, NAME);
        String auth = gets(map, AUTH);

        User user = getUser(account, auth);
        if (Objects.nonNull(user)) {
            return retJ(FAILED, ERROR_USER_REGISTERED);
        }

        User newUser = new User(null, account, password, name);
        boolean result = setUser(newUser, auth);

        LOGGER.info(String.format("signup\t new user: %s", newUser));
        if (!result) {
            return retJ(FAILED, ERROR_DATABASE_OPT);
        }
        return retJ(SUCCESS, SUCCESS_SIGNUP);
    }

    /**
     * 忘记密码操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String forget(String json) {
        LOGGER.info(String.format("forget\tjson: %s", json));

        Map map = FormUtils.fromJson(json);
        String auth = gets(map, AUTH);
        String account = gets(map, ACCOUNT);
        String name = gets(map, NAME);

        User user = getUser(account, auth);
        if (Objects.isNull(user)) {
            return retJ(FAILED, ERROR_USER_NOT_FOUND);
        }
        LOGGER.info(String.format("forget\thave found: %s", user));

        if (!Objects.equals(user.getName(), name)) {
            return retJ(FAILED, ERROR_INPUT);
        }
        return retJ(SUCCESS, user.getPassword());
    }

    /**
     * 修改密码操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String change(String json) {
        LOGGER.info(String.format("change\t %s", json));
        Map map = FormUtils.fromJson(json);

        String auth = gets(map, AUTH);
        String account = gets(map, ACCOUNT);
        String pwd = gets(map, PASSWORD);
        String[] pwds = pwd.split(SPLIT);

        User user = getUser(account, auth);
        if (Objects.isNull(user)) {
            return retJ(FAILED, ERROR_USER_NOT_FOUND);
        }
        if (!Objects.equals(user.getPassword(), pwds[1])) {
            return retJ(FAILED, ERROR_INPUT_USER_PWD);
        }

        user.setPassword(pwds[0]);
        boolean result = upUser(user, auth);
        if (!result) {
            return retJ(FAILED, ERROR_DATABASE_OPT);
        }

        return retJ(SUCCESS, SUCCESS_CHANGE_PWD);
    }

    /**
     * 删除用户操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String delete(String json) {
        LOGGER.info(String.format("delete\tjson: %s", json));

        Map map = FormUtils.fromJson(json);
        String account = gets(map, ACCOUNT);
        User user = getUser(account, AUTH_USER);
        if (Objects.isNull(user)) {
            return retJ(FAILED, ERROR_USER_NOT_FOUND);
        }

        boolean result = USER_DAO.deleteByAccount(account);
        if (!result) {
            return retJ(FAILED, ERROR_DATABASE_OPT);
        }
        return retJ(SUCCESS, SUCCESS_DELETE_USER + "\n" + FormUtils.toJson(user));
    }

    /**
     * 搜索用户编号操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String search(String json) {
        LOGGER.info(String.format("search\t json: %s", json));

        Map map = FormUtils.fromJson(json);
        String search = gets(map, SEARCH);

        User user = USER_DAO.queryByAccount(search);
        String result = FormUtils.toJson(user);

        return retJ(SUCCESS, result);
    }

    /**
     * 修改用户操作
     *
     * @param json 前端传入的数据 参数列表
     * @return 修改用户是否成功 {result, message}
     */
    public static String update(String json) {
        LOGGER.info(String.format("update\tjson: %s", json));

        Map map = FormUtils.fromJson(json);
        String account = gets(map, ACCOUNT);
        String password = gets(map, PASSWORD);
        String name = gets(map, NAME);

        User user = getUser(account, AUTH_USER);
        if (Objects.isNull(user)) {
            return retJ(FAILED, ERROR_USER_NOT_FOUND);
        }

        user.setPassword(password);
        user.setName(name);

        boolean result = upUser(user, AUTH_USER);

        LOGGER.info(String.format("update\tuser:%s result:%s", user, result));
        if (!result) {
            return retJ(FAILED, ERROR_DATABASE_OPT);
        }

        return retJ(SUCCESS, SUCCESS_UPDATE_USER);
    }

    /**
     * 验证是否登录操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String valid(String json) {
        LOGGER.info(String.format("valid\t %s", json));
        Map map = FormUtils.fromJson(json);

        String id = gets(map, ID);
        LOGGER.info(String.format("valid\t get id: %s\nall users: %s", id, loginUsers));

        if (loginUsers.containsKey(id)) {
            return retJ(SUCCESS, SUCCESS_MSG);
        }

        return retJ(FAILED, ERROR_VALID_FAILD);
    }

    /**
     * 登出操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String logout(String json) {
        LOGGER.info(String.format("logout\t json: %s", json));

        Map map = FormUtils.fromJson(json);
        String id = gets(map, ID);
        User user = loginUsers.remove(id);

        if (Objects.isNull(user)) {
            return retJ(FAILED, ERROR_USER_NOT_FOUND);
        }
        return retJ(SUCCESS, user.getAccount() + SUCCESS_LOGOUT);
    }

    /**
     * 获取用户操作
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String getData(String json) {
        LOGGER.info(String.format("getData\t json: %s", json));
        return retJ(SUCCESS, getUsersJson());
    }

    private static String getUsersJson() {
        List<User> users = USER_DAO.queryAllUsers();
        String result = FormUtils.toJson(users);
        LOGGER.info(String.format("getUsersJson\t result: %s", result));
        return result;
    }

    /**
     * 通过认证权限获取用户
     * 管理员/普通用户
     *
     * @param account 用户账号
     * @param auth    权限
     * @return 输入权限下的用户
     */
    static User getUser(String account, String auth) {
        if (Objects.equals(AUTH_USER, auth)) {
            return USER_DAO.queryByAccount(account);
        } else if (Objects.equals(AUTH_ADMIN, auth)) {
            return ADMIN_DAO.queryByAccount(account);
        }
        return null;
    }

    /**
     * 通过不同权限添加不同用户
     *
     * @param user 被添加用户的对象
     * @param auth 权限
     * @return 是否添加成功
     */
    private static boolean setUser(User user, String auth) {
        if (Objects.equals(AUTH_USER, auth)) {
            return USER_DAO.addUser(user);
        } else if (Objects.equals(AUTH_ADMIN, auth)) {
            return ADMIN_DAO.addUser(user);
        }
        return false;
    }

    /**
     * 通过不同权限更新用户
     *
     * @param user 被更新用户
     * @param auth 权限
     * @return 是否更新成功
     */
    private static boolean upUser(User user, String auth) {
        if (Objects.equals(AUTH_USER, auth)) {
            return USER_DAO.update(user);
        } else if (Objects.equals(AUTH_ADMIN, auth)) {
            return ADMIN_DAO.update(user);
        }
        return false;
    }
}
