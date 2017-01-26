package com.kabuda.util;


public enum ResponseCode {

    R_1000(1000, "success"),


    R_1001(1001, "参数为空"),

    R_1002(1002, "用户不存在"),

    R_1003(1003, "密码错误"),

    R_1004(1004, "用户已存在"),

    R_1005(1005, "手机号码已存在"),

    R_1006(1006, "原密码不正确"),

    R_1007(1007, "车辆已存在"),

    R_1008(1008, "城市不存在"),

    R_1009(1009, "不是文件上传请求"),


    R_1010(1010, "用户未登录"),

    R_1100(1100, "其它错误");


    private int status;
    private String message;

    ResponseCode(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
