package com.lingsh.test;

import com.google.gson.Gson;
import com.lingsh.service.UserService;
import com.lingsh.utils.ReflectUtils;

import java.util.HashMap;

/**
 * description
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-11 上午9:14
 */

public class TestReflect {
    public static void main(String[] args) {
        String method = "logout";

        HashMap<String, String> map = new HashMap<>();
        map.put("id", "123456");
        String json = new Gson().toJson(map);
        String result = (String) ReflectUtils.bindValueToMethod(new UserService(), method, json);

        System.out.println(result);
    }
}
