package com.lingsh.servlet;

import com.lingsh.service.SignService;
import com.lingsh.service.UserService;
import com.lingsh.utils.FormUtils;
import com.lingsh.utils.ReflectUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

/**
 * 使用Ajax与Servlet交换信息
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-9 下午10:58
 */

public class AjaxServlet extends HttpServlet {

    private final static Logger LOGGER = LogManager.getLogger(AjaxServlet.class);

    private final static UserService USER_SERVICE = new UserService();
    private final static SignService SIGN_SERVICE = new SignService();

    public AjaxServlet() {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");

        System.out.println("ajax --> servlet (by get)");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");

        LOGGER.info("ajax --> servlet (by post)");

        // 获取变量 (方法名method, 参数列表json)
        String method = req.getParameter("method");
        String content = req.getParameter("content");
        String json = FormUtils.toJson(FormUtils.toMap(req));
        LOGGER.info(String.format("POST 前端传入的参数: %s ", json));
        // 通过反射调用方法 工作
        String result = (String) ReflectUtils.bindValueToMethod(getContent(content), method, json);
        LOGGER.info(String.format("后台传出的消息: %s %s\n\n", result, System.currentTimeMillis()));

        resp.setContentType("application/json;charset=utf-8");
        PrintWriter writer = resp.getWriter();
        writer.print(result);
        writer.flush();
    }

    private Object getContent(String content) {
        if (Objects.isNull(content) || Objects.equals(FormUtils.CONTENT_USER, content)) {
            return USER_SERVICE;
        }
        return SIGN_SERVICE;
    }
}
