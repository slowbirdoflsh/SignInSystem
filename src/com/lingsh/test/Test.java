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
        List<String> list = new ArrayList<>();
        list.add("test");
        System.out.println(list.get(0));

        list.clear();
        System.out.println(list.size());
    }
}
