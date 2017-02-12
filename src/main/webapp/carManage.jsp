<%--
  Created by IntelliJ IDEA.
  User: skyxi
  Date: 2017/1/18
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: skyxi
  Date: 2017/1/16
  Time: 0:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.kabuda.entity.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%
    User user = (User)request.getSession().getAttribute("user");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>test</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/cityselect.css"/>
    <link rel="stylesheet" href="css/user.css">
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>



<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>

<!--body-->
<div class="container">
    <!--导航-->
    <ol class="breadcrumb">
        <li><a href="#">首页</a></li>
        <li class="active">个人信息</li>
    </ol>
    <ul class="nav nav-pills nav-stacked col-md-2 col-xs-12">
        <li role="presentation" ><a id="info_1" href="user.jsp?id=1" >个人资料</a></li>
        <li role="presentation" ><a id="info_2" href="user.jsp?id=2" >修改个人信息</a></li>
        <li role="presentation" ><a id="info_3" href="user.jsp?id=3" >头像上传</a></li>
        <li role="presentation" ><a id="info_4" href="user.jsp?id=4" >修改密码</a></li>
        <li role="presentation" ><a id="info_5" href="#manageCar" aria-controls="user-information" role="tab" data-toggle="tab">车辆管理</a></li>
    </ul>
    <div class="tab-content">

        <div role="tabpanel" class=" col-md-10 col-xs-12 tab-pane"  id="manageCar">
            <h4 class="userpage_title">车辆管理<small><a class="fr"  href="sell.jsp"><span class="glyphicon glyphicon-plus"></span>添加车辆</a></small></h4>
            <div class="">
                <div class="table-responsive ">
                    <table id="carList" class="table table-condensed table-hover " >
                        <tr>
                            <th class="col-xs-1">#</th>
                            <th class="col-xs-2">类型</th>
                            <th class="col-xs-3">品牌</th>
                            <th class="col-xs-3">状态</th>
                            <th class="col-xs-1">编辑</th>
                            <th class="col-xs-1">删除</th>
                        </tr>
                        <%--<tr>
                            <td>1</td>
                            <td>挖掘机</td>
                            <td>奔驰</td>
                            <td>挖掘机</td>
                            <td><a>编辑</a></td>
                            <td><span class="glyphicon glyphicon-remove delete_x"></span></td>
                        </tr>--%>
                    </table>
                </div>
            </div>
        </div>


    </div>

</div>


<!--底部-->
<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script type="text/javascript" src="js/page.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script src="js/bootstrap-filestyle.js"></script>
<script src="js/login.js"></script>
<script>
    $("#info_5").trigger("click");
    var id=<%=user.getId() %>;
    getOwnCarList(id);
    function getOwnCarList(id){
        $.ajax({
            type: "POST",
            url:  "/user/getCarList",
            data: {id:id},
            success:function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (data.status == 1000) {
                    var total=data.result.total;
                    if(total){
                        var data=data.result.data;
                        for(var i=0;i<total;i++){
                            if(data[i].sell){
                                if(data[i].sellState){
                                    var str1='<span class="label label-success">已出售</span>';
                                }else{
                                    var str1='<span class="label label-primary">待出售</span>';
                                }
                            }else{
                                var str1='<span class="label label-default">未出售</span>';
                            }
                            if(data[i].rent){
                                if(data[i].rentState){
                                    var str2='<span class="label label-success">已出租</span>';
                                }else{
                                    var str2='<span class="label label-primary">待出租</span>';
                                }
                            }else{
                                var str2='<span class="label label-default">未出租</span>';
                            }

                           var str='<tr>'+
                               '<td>'+(i+1)+'</td>'+
                               '<td>'+data[i].model+'</td>'+
                               '<td>'+data[i].brand+'</td>'+
                               '<td>'+str1+str2+'</td>'+
                               '<td><a href="vehicle_detail.jsp?vehicleId?='+data[i].id+'">编辑</a></td>'+
                               '<td><a onclick="deleteCar('+data[i].id+')"><span class="glyphicon glyphicon-remove delete_x"></span></a></td>'+
                               '</tr>';
                            $("#carList").append(str);
                        }
                    }



                }

            },
        });
    }

    function deleteCar(id) {
        $.ajax({
            type: "POST",
            url:  "/user/deleteCar",
            data: {id:id},
            success:function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (data.status == 1000) {



                }

            },
        });
    }
</script>
</body>
</html>
