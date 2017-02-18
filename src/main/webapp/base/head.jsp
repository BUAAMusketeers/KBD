<%@ page import="com.kabuda.entity.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%
User user = (User)request.getSession().getAttribute("user");
%>
<div class="head-body">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-xs-12 head-title">
                <h1 class="col-md-6 col-xs-6"><a href="index.html">kabuda</a></h1>
                <div class="col-md-5 col-xs-6 citySelect">
                    <input type="text" class="form-control" id="citySelect" placeholder="北京市">
                </div>
            </div>
            <div class="col-md-5 col-xs-12 head-search">
                <div class="input-group">
                    <input type="text" id="cityInput" class="form-control" placeholder="搜索您想要的车" >
                    <span class="input-group-btn"><button class="btn" id="searchCarBtn" type="button">搜索</button></span>
                </div>
            </div>
            <div class="col-md-3">
                <div class="head-phone">
                    <span class="glyphicon glyphicon-earphone"></span>132-1345-1335
                </div>
            </div>
        </div>
    </div>
    <!--顶部下方导航条-->
    <div class="head-nav">
        <div class="navbar-header">
            <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation"aria-expanded="false">
            <div class="container">
                <ul class="nav navbar-nav navbar-left">
                    <li><a href="index.jsp"> 首页</a></li>
                    <li><a href="buyCar.jsp">买车</a></li>
                    <li><a href="rentCar.jsp">租车</a></li>
                    <li><a href="seekDriver.jsp">找驾驶员</a></li>
                    <li><a href="trailer.jsp">租拖车</a></li>

                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <% if(user==null){ %>
                    <li id="login_li"><a href="#" data-target="#loginModal" data-toggle="modal" id="nav-login"><span class="glyphicon glyphicon-user"></span> 登录</a></li>
                    <li><a href="register.jsp" id="nav-register"><span class="glyphicon glyphicon-cloud"></span> 注册</a></li>
                    <% }else{ %>
                    <li><a href="user.jsp" id="nav-pc" ><span class="glyphicon glyphicon-user"></span> <%=user.getName()%></a></li>
                    <li><a href="/user/logout" id="nav-logout" ><span class="glyphicon glyphicon-off"></span> 退出</a></li>
                    <%}%>
                </ul>
            </div>
        </nav>
    </div>
</div>

<!-- 登陆框 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content login-content">
            <div class="modal-header login-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title login-title" id="login-title">登录</h4>
                <p id="login-warning"></p>
            </div>
            <div class="modal-body login-body">
                <div class="information">
                    <form role="form" id="login-form">
                        <ul>
                            <li>
                                <label for="username"></label>
                                <div class="input-group">
                                    <div class="input-group-addon"><span class="glyphicon glyphicon-earphone"></span></div>
                                    <input type="text" id="username" name='mixPassport' class="form-control" placeholder="手机号" >
                                </div>
                            </li>
                            <li>
                                <label for="password"></label>
                                <div class="input-group">
                                    <div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
                                    <input type="password" id="password" name='password' class="form-control" placeholder="密码">
                                </div>
                            </li>
                            <li class="btn-area">
                                <button type="button" class="btn btn-primary btn-lg btn-block" id="login-btn">登录</button>
                                <p>第一次登录？<a href="register.jsp">立即注册</a></p>
                            </li>
                        </ul>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

