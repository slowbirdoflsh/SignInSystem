package com.lingsh.test;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.lingsh.service.UserService;
import com.lingsh.utils.FormUtils;
import com.lingsh.utils.ReflectUtils;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * description
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-11 上午9:57
 */

public class TestGson {
    public static void main(String[] args) {
        new TestGson().test1();
    }

    void test1() {
        Map<String, String> map = new HashMap<>(10);
        map.put("account", "admin");
        map.put("password", "123456");
        map.put("auth", "user");
        map.put("method", null);
        System.out.println(map);

        String json = new Gson().toJson(map);
        System.out.println(json);

        Map fromJson = new Gson().fromJson(json, Map.class);
        System.out.println(fromJson);
        System.out.println(fromJson.get("account"));

        UserService us = (UserService) ReflectUtils.newIntance(UserService.class);
        String login = (String) ReflectUtils.bindValueToMethod(us, "login", json);
        System.out.println(login);
    }
}
