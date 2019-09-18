package com.lingsh.service;

import com.lingsh.bean.Sign;
import com.lingsh.bean.User;
import com.lingsh.constant.Constant;
import com.lingsh.dao.SignDao;
import com.lingsh.dao.SignDaoImpl;
import com.lingsh.utils.FormUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 签到记录服务类
 * 操作方法集合
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-9 下午2:22
 */

public class SignService extends BaseService implements Constant {

    /**
     * 日志
     */
    private final static Logger LOGGER = LogManager.getLogger(SignService.class);

    /**
     * 预先实例化 操作数据库的对象
     */
    private final static SignDao SIGN_DAO = new SignDaoImpl();

    /**
     * 新建签到记录
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String register(String json) {
        LOGGER.info(String.format("register\t json: %s", json));

        Map params = FormUtils.fromJson(json);
        String account = gets(params, ACCOUNT);
        String signDate = gets(params, TIMESTAMP);

        User user = UserService.getUser(account, AUTH_USER);
        if (Objects.isNull(user)) {
            LOGGER.error("register\t user查不到 奇怪的错误");
            return retJ(FAILED, ERROR_USER_NOT_FOUND);
        }

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
        signDate = Objects.nonNull(signDate) ? signDate : simpleDateFormat.format(new Date());
        Sign sign = new Sign(user.getId(), signDate);

        boolean result = SIGN_DAO.addSign(sign);
        if (!result) {
            LOGGER.error("recorder\t添加签到记录失败 --by db");
            return retJ(FAILED, ERROR_INSERT_SIGN);
        }

        return retJ(SUCCESS, SUCCESS_INSERT_SIGN);
    }

    /**
     * 根据用户名称查找签到记录
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String search(String json) {
        LOGGER.info(String.format("search\tjson: %s", json));

        Map map = FormUtils.fromJson(json);
        String userName = gets(map, SEARCH);

        List<Map> maps = SIGN_DAO.queryAllWithNameByName(userName);
        LOGGER.info(String.format("search\tcontent: %s", maps));
        if (Objects.isNull(maps)) {
            return retJ(FAILED, ERROR_SEARCH_NULL);
        }

        return retJ(SUCCESS, FormUtils.toJson(maps));
    }

    /**
     * 更新签到记录
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String update(String json) {
        LOGGER.info(String.format("update\tjson: %s", json));

        Map map = FormUtils.fromJson(json);
        String id = gets(map, ID);
        String userId = gets(map, USER_ID);
        String name = gets(map, Constant.NAME);
        String timestamp = gets(map, TIMESTAMP);

        Sign sign = SIGN_DAO.queryById(Integer.parseInt(id));
        if (Objects.isNull(sign)) {
            return retJ(FAILED, ERROR_SIGN_NOT_FOUND);
        }

        sign.setUserId(Integer.parseInt(userId));
        sign.setSignDate(timestamp);

        boolean result = SIGN_DAO.updateSign(sign);
        if (!result) {
            return retJ(FAILED, ERROR_DATABASE_OPT);
        }

        return retJ(SUCCESS, SUCCESS_UPDATE_SIGN);
    }

    /**
     * 删除签到记录
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String delete(String json) {
        LOGGER.info(String.format("delete\tjson: %s", json));

        Map map = FormUtils.fromJson(json);
        String id = gets(map, ID);

        Sign sign = SIGN_DAO.queryById(Integer.parseInt(id));
        if (Objects.isNull(sign)) {
            return retJ(FAILED, ERROR_SIGN_NOT_FOUND);
        }
        boolean result = SIGN_DAO.deleteSignById(Integer.parseInt(id));
        if (!result) {
            return retJ(FAILED, ERROR_DATABASE_OPT);
        }

        return retJ(SUCCESS, FormUtils.toJson(sign));
    }

    /**
     * 获取签到记录数据
     *
     * @param json 参数列表
     * @return {result, message}
     */
    public static String getData(String json) {
        LOGGER.info(String.format("getData\t json: %s", json));
        return retJ(SUCCESS, getSignsJson());
    }

    private static String getSignsJson() {
        List<Map> maps = SIGN_DAO.queryAllWithName();
        String result = FormUtils.toJson(maps);
        LOGGER.info(String.format("getSignsJson\t result: %s", result));
        return result;
    }
}
