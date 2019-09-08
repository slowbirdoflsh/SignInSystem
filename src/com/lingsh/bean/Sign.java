package com.lingsh.bean;

import java.util.Objects;

/**
 * 签到情况表
 * id 签到编号 自增
 * userId 签到用户id
 * signDate 签到时间
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-6 上午10:58
 */

public class Sign {

    private Integer id;
    private Integer userId;
    private String signDate;

    public Sign() {
    }

    public Sign(Integer userId, String signDate) {
        this.userId = userId;
        this.signDate = signDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getSignDate() {
        return signDate;
    }

    public void setSignDate(String signDate) {
        this.signDate = signDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Sign sign = (Sign) o;
        return id.equals(sign.id) &&
                userId.equals(sign.userId) &&
                signDate.equals(sign.signDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, userId, signDate);
    }

    @Override
    public String toString() {
        return "Sign{" +
                "id=" + id +
                ", userId=" + userId +
                ", signDate='" + signDate + '\'' +
                '}';
    }
}
