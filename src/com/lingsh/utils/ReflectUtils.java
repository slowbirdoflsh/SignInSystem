package com.lingsh.utils;

import java.lang.reflect.Field;

/**
 * 反射工具类
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-5 上午9:13
 */

public class ReflectUtils {
    /**
     * Class : 类的模板
     *      属性/方法/内部类/接口/继承/构造方法
     */
    public static void bindValueToField(Object obj, String name, Object value) {
        try {
            Class clazz = obj.getClass();
            Field field = clazz.getDeclaredField(name);
            field.setAccessible(true);
            field.set(obj, value);
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static Object newIntance(Class clazz) {
        try {
            // 必须要求类包含无参的构造方法
            return clazz.newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
    }
}
