package com.lingsh.test;

import java.util.ArrayList;
import java.util.List;

/**
 * description
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-4 上午9:58
 */

public class Test {

    public static void main(String[] args) {
        assert 6 < 5;
        System.out.println("6 < 5");
        assert 5 < 6;
        System.out.println("5 < 6");
    }

    private static String get(StringBuilder test) {
        test.append("password");
        return "success";
    }
}
