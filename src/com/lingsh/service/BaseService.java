package com.lingsh.service;

import com.lingsh.utils.FormUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 提供工具方法
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-16 上午10:52
 */

public abstract class BaseService {

    protected static Map<String, String> sets(String ret, String msg) {
        Map<String, String> result = new HashMap<>(2);
        result.put("ret", ret);
        result.put("msg", msg);
        return result;
    }

    protected static String concatId(String split, String... params) {
        StringBuilder stringBuilder = new StringBuilder();
        for (String param : params) {
            stringBuilder.append(param).append(split);
        }
        return stringBuilder.toString();
    }

    protected static String gets(Map map, String param) {
        return (String) map.get(param);
    }

    protected static String retJ(String result, String msg) {
        return FormUtils.toJson(sets(result, msg));
    }
}
