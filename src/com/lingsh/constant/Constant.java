package com.lingsh.constant;

/**
 * 前后端约定字段 常量
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-12 上午9:55
 */

public interface Constant {
    /**
     * **********************************************************
     * 表格提交字段
     * 与前端提交表单的关键词
     * **********************************************************
     * <p>
     * 所有方法入口
     * UserService -->
     * login 登录
     * signup 注册/新建用户
     * forget 忘记密码
     * change 修改密码
     * delete 删除用户
     * update 修改用户
     * search 搜索用户账号
     * valid 检验是否登录
     * logout 登出
     * getData 获取用户数据
     * <p>
     * SignService -->
     * register 新建签到记录
     * update 修改签到记录
     * delete 删除签到记录
     * search 搜索用户名称对应的签到记录
     * getData 获取签到记录数据
     */
    String METHOD = "method";
    /**
     * 权限
     * 普通用户 user
     * 管理员用户 admin
     */
    String AUTH = "auth";
    /**
     * 用户账号
     * 登录/查找/删除/更新
     */
    String ACCOUNT = "account";
    /**
     * 用户密码
     * 登录/修改("新密码#旧密码")
     */
    String PASSWORD = "password";
    /**
     * 用户名称 --> 用户
     */
    String NAME = "name";
    /**
     * 用户id --> 签到记录
     */
    String USER_ID = "userId";
    /**
     * timestamp 时间戳 用户登录时的时间
     * 用以构成用户唯一标识
     * <p>
     * 同时 在签到记录中当signDate使用
     */
    String TIMESTAMP = "timestamp";
    /**
     * id 已登录用户唯一标识符
     * "auth#account#timestamp#" 登录用户唯一标识符
     * 前端和后台各自拼接 验证时 直接比对二者即可
     */
    String ID = "id";
    /**
     * 获取内容标识
     * content:none/user --> UserService
     * content:sign --> SignService
     */
    String CONTENT = "content";
    /**
     * 搜索内容
     * 与content搭配使用
     * none/user --> search=id(user) --> 查询用户编号
     * sign --> search=name(user) --> 查询用户名称对应的签到记录
     */
    String SEARCH = "search";

    /**
     * **********************************************************
     * 主页面显示表格内容
     * **********************************************************
     * <p>
     * 用户表 签到表
     */
    String CONTENT_USER = "users";
    String CONTENT_SIGN = "signs";

    /**
     * **********************************************************
     * 后台结果返回字段
     * 后台处理结果所返回的关键词
     * **********************************************************
     * 报错 成功 失败
     */
    String ERROR = "error";
    String SUCCESS = "success";
    String FAILED = "failed";

    /**
     * **********************************************************
     * 提示字段
     * 后台返回前端的提醒消息 定制
     * **********************************************************
     */
    String SUCCESS_MSG = "";
    String SUCCESS_LOGOUT = "用户已登出!";
    String SUCCESS_INSERT_SIGN = "签到成功";
    String SUCCESS_CHANGE_PWD = "修改密码成功";
    String SUCCESS_SIGNUP = "注册用户成功";
    String SUCCESS_UPDATE_USER = "修改用户成功";
    String SUCCESS_DELETE_USER = "删除用户成功";
    String SUCCESS_UPDATE_SIGN = "修改签到记录成功";

    String ERROR_INPUT_USER_PWD = "抱歉, 你的账号或密码输入有误";
    String ERROR_INPUT = "抱歉, 你的输入信息有误";
    String ERROR_VALID_FAILD = "抱歉, 你还未登录,请先登录!";
    String ERROR_USER_NOT_FOUND = "用户没找到!";
    String ERROR_USER_REGISTERED = "抱歉, 该账号已被注册";
    String ERROR_USER_CREATE_FAILD = "新建用户失败";
    String ERROR_PWD_CHANGE_FAILD = "修改密码失败";
    String ERROR_INSERT_SIGN = "添加签到记录失败";
    String ERROR_UNKOWN = "未知错误";
    String ERROR_DATABASE_OPT = "数据库操作错误";
    String ERROR_CHANGE_PWD = "修改密码失败";
    String ERROR_SEARCH_NULL = "搜索为空";
    String ERROR_SIGN_NOT_FOUND = "签到记录未找到";

    /**
     * **********************************************************
     * 身份权限标示
     * 后台与前端的约定
     * **********************************************************
     */
    String AUTH_USER = "user";
    String AUTH_ADMIN = "admin";

    /**
     * 字符拼接标识
     */
    String SPLIT = "#";
}
