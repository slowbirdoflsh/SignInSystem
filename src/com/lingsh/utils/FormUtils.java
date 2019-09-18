package com.lingsh.utils;

import com.google.gson.Gson;
import com.lingsh.constant.Constant;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * 前端提交表单
 * 所有可能取值
 * 可以转出成json
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-11 上午10:00
 */

public class FormUtils implements Constant {
    /**
     * 前端传入的所有可能关键字 键值
     */
    public static String[] params = {
            METHOD, ACCOUNT, PASSWORD, NAME, AUTH, TIMESTAMP, ID, CONTENT, SEARCH, USER_ID
    };

    /**
     * 逐个遍历可能关键字, "压缩"Map对象
     * 根据Gson默认舍弃null值 可以将其制成有效参数列表
     *
     * @param req request对象
     * @return 前端传入的有效参数列表
     */
    public static Map<String, String> toMap(HttpServletRequest req) {
        Map<String, String> map = new HashMap<>(params.length);
        for (String param : params) {
            map.put(param, req.getParameter(param));
        }
        return map;
    }

    /**
     * "解压"json格式为Map对象
     *
     * @param json 被"压缩"的参数列表
     * @return Map格式的参数列表
     */
    public static Map fromJson(String json) {
        return new Gson().fromJson(json, Map.class);
    }

    /**
     * 将对象转为json格式
     *
     * @param object 被转化对象
     * @return json格式的数据
     */
    public static String toJson(Object object) {
        return new Gson().toJson(object);
    }
}
