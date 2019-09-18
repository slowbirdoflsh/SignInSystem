package com.lingsh.test;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * 测试使用log4j2日志框架的使用
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-8 下午9:26
 */

public class TestLogger {

    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(TestLogger.class);

        logger.info("this is a info");
        logger.error("this is a error");

        Logger log = LogManager.getLogger("test");
        log.info("this is a info");
        log.error("this is a error");
        log.warn("this is a warn");
    }
}
