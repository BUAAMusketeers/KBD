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
    <ul class="nav nav-pills nav-stacked col-xs-2">
        <li role="presentation" ><a id="info_1" href="#user-information" aria-controls="user-information" role="tab" data-toggle="tab">个人资料</a></li>
        <li role="presentation" ><a id="info_2" href="#edit-information" aria-controls="edit-information" role="tab" data-toggle="tab">修改个人信息</a></li>
        <li role="presentation" ><a id="info_3" href="#edit-picture" aria-controls="edit-picture" role="tab" data-toggle="tab">头像上传</a></li>
        <li role="presentation" ><a id="info_4" href="#edit-password" aria-controls="edit-password" role="tab" data-toggle="tab">修改密码</a></li>
        <li role="presentation" ><a id="info_5" href="carManage.jsp" >车辆管理</a></li>
    </ul>
    <div class="tab-content">
        <div role="tabpanel" class=" col-xs-10 tab-pane"  id="user-information">
            <h4 class="userpage_title">个人资料</h4>
            <div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="userName_user" class="col-sm-2 control-label">真实姓名</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="userName_user">李先生</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="mobile_user" class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="mobile_user">18611255411</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sex_user" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="sex_user">男</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sex_user" class="col-sm-2 control-label">驾驶员注册</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="ifDriver_user">是</p>
                        </div>
                    </div>
                    <div class="form-group showForDriver">
                        <label for="carType_user" class="col-sm-2 control-label">驾驶机型</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="carType_user">
                               <%-- <span class="label label-info function_label">挖掘机</span>
                                <span class="label label-info function_label">拖拉机</span>--%>
                            </p>
                        </div>
                    </div>
                    <div class="form-group showForDriver">
                        <label for="YearsOfDriving_user" class="col-sm-2 control-label">驾龄</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="YearsOfDriving_user">12年</p>
                        </div>
                    </div>
                    <div class="form-group showForDriver">
                        <label for="location_user" class="col-sm-2 control-label">驾驶地址</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="location_user">北京市海淀区</p>
                        </div>
                    </div>
                    <div class="form-group  showForDriver">
                        <label for="commission_user" class="col-sm-2 control-label">预期佣金</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="commission_user">45元/天</p>
                        </div>
                    </div>


                </form>
            </div>
        </div>
        <div role="tabpanel" class=" col-xs-10 tab-pane"  id="edit-information">
            <h4 class="userpage_title">修改个人信息</h4>
            <div>
                344
            </div>
        </div>
        <div role="tabpanel" class=" col-xs-10 tab-pane"  id="edit-password">
            <h4 class="userpage_title">修改密码</h4>
            <div>
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">旧密码</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="oldpassword" placeholder="请输入旧密码">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-5">
                            <input type="password" class="form-control" id="newpassword" placeholder="请输入新密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">重复新密码</label>
                        <div class="col-sm-5">
                            <input type="password" class="form-control" id="renewpassword" placeholder="请重复输入新密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" class="btn btn-primary" onclick="modifypassword()">保存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div role="tabpanel" class="col-xs-10 tab-pane" id="edit-picture">
            <h4 class="userpage_title">上传头像</h4>
            <div class=" headportrait">
                <img src="images/demo.jpg" class="img-responsive " id="user_img" alt="Responsive image">
            </div>
            <div>
                <input type="file" multiple="multiple" id="uploadpicture"  tabindex="-1" onchange="fileok(this)" style="position: absolute; clip: rect(0px 0px 0px 0px);"><label id="selectfile" for="uploadpicture" class="btn btn-primary "><span class="icon-span-filestyle glyphicon glyphicon-folder-open"></span> <span class="buttonText">选择文件</span><span class="glyphicon glyphicon-ok" style="display:none;"></span></label>
                <button class="btn btn-danger" id="submit_picture" onclick="uploadFile()" disabled>提交</button>
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
<script >

    var tabId=getQueryString("id")?getQueryString("id"):1;
    //var tabInfo=document.getElementById("info_"+tabId);
    $("#info_"+tabId).trigger("click");
    var id=<%=user.getId() %>;
    $(document).ready(function () {
        getUserInfo(id);

    });
    function getUserInfo(id){
        $.ajax({
            type: "POST",
            url:  "/user/getInfo",
            data: {id:id},
            success:function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (data.status == 1000) {
                    console.log(data);
                    var data = data.data;

                    $("#mobile_user").html(data.phoneNumber);
                    $("#userName_user").html(data.name);
                    $("#sex_user").html((data.sex==1)?"男":"女");
                    $("#ifDriver_user").html((data.isDriver==1)?"是":"否");
                    if(data.isDriver){
                        $("#YearsOfDriving_user").html(data.drivingAge);
                        $("#commission_user").html(data.drivingAge);
                        if(data.model){
                            for(var j=0;j<data.model.length;j++){
                                var str = '<span class="label label-info function_label">' + data.model[j] + '</span>';
                                $("#carType_user").append(str);
                            }
                        }
                    }else{
                        $(".showForDriver").hide();
                    }



                }

            },
        });
    }


    //上传头像
    function fileok(sender){


        if( !sender.value.match( /.jpg|.gif|.png|.bmp/i ) ){
            topAlert('图片格式无效！','error');
            return false;
        }
        $("#selectfile .glyphicon-ok").show();
        $("#submit_picture").attr("disabled",false);
        var objPreview = document.getElementById('user_img');


        if( sender.files && sender.files[0] ){

            objPreview.src = window.URL.createObjectURL(sender.files[0]);
        }



    }


    function uploadFile(){
        var file=$('#uploadpicture').prop('files');
        var formdata = new FormData();
        formdata.append("fileToUpload", file[0]);

        //console.log(file[0]);
        $.ajax({
            type: "POST",
            url:  "file/upload?type=1",
            contentType: false,
            processData: false ,
            data: formdata,
            success:function(data) {
                if (data.status == 1000) {
                    //$("#user_img").attr("src",root+'/ePlanFileSys'+data.result.info.path);
                    modifyPortrait(data.result.info.path);
                }
            },

        });
    }

    function modifyPortrait(path){

        $.ajax({
            type: "POST",
            url:  root+"/user/modifyPortrait",

            data: JSON.stringify({portrait:path}),
            success:function(data) {
                if (data.errorcode == 3000) {
                    topAlert("头像上传成功","success");
                }
            },

        });
    }

    function modifypassword(){
        if($("#newpassword").val()!=$("#renewpassword").val()){
            alert("两次密码输入不一致");
            return;
        }
        var pra={

            oldPassword:$("#oldpassword").val(),
            newPassword:$("#newpassword").val(),

        }
        $.ajax({
            type: "POST",
            url:  "/user/changePassword",
            data: pra,
            success:function(data) {
                if (data.errorcode == 3000) {
                    topAlert("密码修改成功",'success');
                    $("#oldpassword").empty(),
                        $("#newpassword").empty(),
                        $("#renewpassword").empty()
                }
                else if(data.errorcode==3001){
                    topAlert("密码修改失败",'error');
                }
                else if(data.errorcode==3007){
                    window.open(root + "/index", "_self");
                }
            },
            datatype: "json"
        });
    }
</script>
</body>
</html>