<%@ page import="com.kabuda.entity.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%
    User user = (User)request.getSession().getAttribute("user");
%>
<div class="foot">
    <p>版权所有：卡布达机械网</p>
    <p>Copyright © 2016-2017 </p>
</div>

