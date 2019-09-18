package com.lingsh.test;

import com.lingsh.service.UserService;
import com.lingsh.utils.FormUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * description
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-11 下午1:07
 */

public class TestUserService {

    public static void main(String[] args) {
        Map<String, String> map = new HashMap<>(2);
        map.put("method", "logout");
        map.put("id", "123456");

        String toJson = FormUtils.toJson(map);
        String result = UserService.valid(toJson);
    }
}
