# SignInSystem
学生签到系统 中等

## 内容
学生打卡签到, 管理员管理学生用户和签到情况

## 使用技术
### 前端
1. 网页样式使用UIKit的样式
2. 使用jQuery取值, 存放cookie, Ajax传值到后台
### 后台
1. 使用Servlet技术 拦截所有请求到Servlet 由Servlet统一调配 

## 实现功能
1. 用户登录/注册/忘记密码/记住密码/修改密码
2. 签到功能
3. 用户管理/签到记录管理 --查询/新增/删除/修改

## 优点
1. 使用ajax和Servlet沟通 实现初步前后端分离 前端不写java代码
2. 使用反射技术 由Servlet统一调用后台方法 实现初步解耦
3. 使用ajax技术 页面内容可以不刷新页面来更新

## 缺点
1. 权限认证方式简陋 普通用户和管理员容易混淆
2. 重复操作内容过多 每次更新页面都需要查询数据库 需要缓存
3. 页面传值方式过于耦合(前端问题) 使用cookie传值
4. 代码架构性不够强 对象与对象之间比较混乱/耦合
5. 页面跳转方式写死在代码上 过于耦合

## 下一步
1. 引入框架SSM
2. 引入权限控制框架Shiro
3. 使用Redis缓存

---------------------

# SignInSystem
学生签到系统 简易

## 内容
学生打卡签到, 管理员管理学生用户和签到情况

## 使用技术
### 前端
  1. 网页样式使用UIKit的样式
  2. 页面逻辑 自己写的js代码 (主要是输入框判空逻辑)
### 后台
  1. 操作主体使用JavaBean
  2. 数据库连接使用JDBC技术
  3. 前后端连接使用jsp技术
  
## 实现功能
  1. 用户登录/注册/忘记密码/记住密码/修改密码
  2. 签到功能
  3. 用户管理/签到记录管理 --查询/新增/删除/修改

## 优点
  1. 使用技术简易/基础
 
## 不足
  1. 逻辑比较混乱
  2. 技术简陋,过时
  3. 代码可复用性过差
  
## 下一步
  1. 重构代码 主要在增强代码复用性
  2. 将逻辑代码搬离jsp
  3. 构建完善的日志业务
  4. 尽量使用一些新的技术
