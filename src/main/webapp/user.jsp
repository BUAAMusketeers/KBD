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
    <title>用户管理 | 卡布达</title>
    <link rel="stylesheet" href="css/bootstrapValidator.min.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/cityselect.css"/>
    <link rel="stylesheet" href="css/sell.css">
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
                            <p class="form-control-static" id="userName_user"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="mobile_user" class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="mobile_user"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sex_user" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="sex_user"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sex_user" class="col-sm-2 control-label">驾驶员注册</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="ifDriver_user"></p>
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
                            <p class="form-control-static" id="YearsOfDriving_user"></p>
                        </div>
                    </div>
                    <div class="form-group showForDriver">
                        <label for="location_user" class="col-sm-2 control-label">驾驶地址</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="location_user"></p>
                        </div>
                    </div>
                    <div class="form-group  showForDriver">
                        <label for="commission_user" class="col-sm-2 control-label">预期佣金</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="commission_user"></p>
                        </div>
                    </div>


                </form>
            </div>
        </div>
        <div role="tabpanel" class=" col-xs-10 tab-pane"  id="edit-information">
            <h4 class="userpage_title">修改个人信息</h4>
            <div>
                <div class="row">
                    <div class="col-md-5 reg-body" style="">
                        <div class="choose-head">
                            <div class="head col-xs-6">
                                <a href="javascript:"><img src="images/male.jpg" id="m-img" class="img-circle img-active"></a>
                                <span class="span-active" id="m-span">男性</span>
                            </div>
                            <div class="head col-xs-6">
                                <a href="javascript:"><img src="images/female.jpg" id="f-img" class="img-circle"></a>
                                <span id="f-span">女性</span>
                            </div>
                        </div>
                        <form id="register-form" class="form-horizontal">
                            <input type="hidden" id="sex" name="sex" value="1">
                            <input type="hidden"  name="model" value="">
                            <input type="hidden"  name="location" value="">
                            <div class="form-group">
                                <label class="col-xs-4 control-label">真实姓名:</label>
                                <div class="col-xs-8">
                                    <input type="text" id="name" class="form-control" name="name" autocomplete="off">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-4 control-label">手机号:</label>
                                <div class="col-xs-8">
                                    <input type="text" id="phoneNumber" class="form-control" name="phoneNumber" autocomplete="off">
                                </div>
                            </div>
                            <%--<div class="form-group">--%>
                                <%--<label class="col-xs-4 control-label">登录密码:</label>--%>
                                <%--<div class="col-xs-8">--%>
                                    <%--<input type="password" id="password" class="form-control" name="password" autocomplete="off">--%>
                                <%--</div>--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label class="col-xs-4 control-label">确认密码:</label>--%>
                                <%--<div class="col-xs-8">--%>
                                    <%--<input type="password" id="confirmPassword" class="form-control" name="confirmPassword" autocomplete="off">--%>
                                <%--</div>--%>
                            <%--</div>--%>
                            <div class="form-group">
                                <label class="col-xs-4 control-label">驾驶员注册:</label>
                                <div style="margin-top: 7px">
                                    <input class="col-xs-2" type="radio" value="1" name="isDriver"/>
                                    <label class="col-xs-1 reg_toleft">是</label>
                                    <input class="col-xs-2" type="radio" value="0" name="isDriver" checked="checked" />
                                    <label class="col-xs-1 reg_toleft">否</label>
                                </div>
                            </div>
                            <div class="driver_info" style="display:none">
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">驾驶机型:</label>
                                    <div class="col-xs-8"  id="functionList">
                                        <p class="form-control-static" autocomplete="off" name="mobelList">
                                            <label  id="function_selected_out"></label>
                                            <button type="button" class="btn btn-primary btn-sm"  data-toggle="modal"  data-target="#myModal" onclick="add_function_out()">添加机型</button>
                                        </p>
                                        <div class="modal fade " tabindex="-1" role="dialog"  id="myModal">
                                            <div class="modal-dialog">
                                                <div class="modal-content  model-content login-content">
                                                    <div class="modal-header login-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title login-title">选择机型</h4>
                                                    </div>
                                                    <div class="modal-body clearfix">
                                                        <p style="width:100%">
                                                            <small>最多可以选择三项: </small>
                                                            <label class="function_selected"></label>
                                                        </p>
                                                        <h3>
                                                            机型
                                                        </h3>
                                                        <div class="tab-content function_select" id="functionlist2">
                                                            <div role="tabpanel" class="tab-pane active" id="model">
                                                                <ul>
                                                                </ul>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="submit_function()">确认</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">驾驶年龄:</label>
                                    <div class="col-xs-8">
                                        <select class="form-control" name="drivingAge">
                                            <option value="">请选择</option>
                                            <option value="1">1年</option>
                                            <option value="2">2年</option>
                                            <option value="3">3年</option>
                                            <option value="4">4年</option>
                                            <option value="5">5年</option>
                                            <option value="6">6年</option>
                                            <option value="7">7年</option>
                                            <option value="8">8年</option>
                                            <option value="9">9年</option>
                                            <option value="10">大于等于10年</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">驾驶地址:</label>
                                    <div class="col-xs-4">
                                        <select class="form-control" name="province" id="location_province" onchange="javascript:showMyCity('location', this.value)" style="padding-right: 10%">
                                            <option value="">请选择省</option>
                                        </select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" name="city" id="location_city" style="padding-right: 10%">
                                            <option value="">请选择市</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">预期佣金:</label>
                                    <div class="col-xs-8">
                                        <input class="form-control to_right for-xs" type="text"   name="price" autocomplete="off" >
                                        <span class="unit"style="">
                                ｜<label class="cur">元/天</label>
                            </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group btn-area">
                                <button type="submit" style="" class="btn btn-primary btn-lg btn-block" id="register-btn">确认修改</button>
                            </div>
                        </form>
                    </div>
                </div>
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
<script src="js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script type="text/javascript" src="js/page.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script src="js/bootstrap-filestyle.js"></script>
<script src="js/login.js"></script>
<script type="text/javascript" src="js/buyCar.js"></script>

<script >

    var tabId=getQueryString("id")?getQueryString("id"):1;
    //var tabInfo=document.getElementById("info_"+tabId);
    $("#info_"+tabId).trigger("click");
    var id=<%=user.getId() %>;
    $(document).ready(function () {
        getUserInfo(id);
        /*--头像切换--*/
        $('#m-img').click(function(){
            document.getElementById('m-img').className = 'img-circle img-active';
            document.getElementById('m-span').className = 'span-active';
            document.getElementById('f-img').className = 'img-circle';
            document.getElementById('f-span').className = '';
            document.getElementsByName('sex').value = "1";
        });
        $('#f-img').click(function(){
            document.getElementById('m-img').className = 'img-circle';
            document.getElementById('m-span').className = '';
            document.getElementById('f-img').className = 'img-circle img-active';
            document.getElementById('f-span').className = 'span-active';
            document.getElementsByName('sex').value = "0";
        });

        //initProvinceList();

        //是否显示驾驶员信息
        $("input[name=isDriver]").click(function(){
            if(this.value=="1"){
                $(".driver_info").fadeIn(500);
                $('#register-form').bootstrapValidator('resetForm',false);
            }
            else{
                $(".driver_info").fadeOut(500);
                $('#register-form').bootstrapValidator('resetForm',false);
            }
        });


        $('#register-form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: '请填写真实姓名'
                        },
                        stringLength: {
                            min: 1,
                            max: 20,
                            message: '真实姓名长度为1至20'
                        },
                    }
                },
                phoneNumber: {
                    validators: {
                        phone: {
                            country: 'CN',
                            message: '请输入正确的手机号'
                        },
                        notEmpty: {
                            message: '请输入手机号'
                        }
                    }
                },
                drivingAge:{
                    validators: {
                        callback:{
                            message: '请选择驾驶年龄',
                            callback: function(value, validator) {
                                var isDriver = $("input[name='isDriver']:checked").val();
                                if(isDriver=="0")
                                    return true;
                                if(value=="")
                                    return false;
                                return true;
                            }
                        }
                    }
                },
                province:{
                    validators: {
                        callback:{
                            message: '请选择省份',
                            callback: function(value, validator) {
                                var isDriver = $("input[name='isDriver']:checked").val();
                                if(isDriver=="0")
                                    return true;
                                if(value=="")
                                    return false;
                                return true;
                            }
                        }
                    }
                },
                price:{
                    validators: {
                        callback:{
                            message: '请填写正确形式的预期佣金',
                            callback: function(value, validator) {
                                var isDriver = $("input[name='isDriver']:checked").val();
                                if(isDriver=="0")
                                    return true;
                                var reg = new RegExp("^[0-9]*$");
                                if(!reg.test(value)||value=="")
                                    return false;
                                return true;
                            }
                        }
                    }
                },
                mobelList:{
                    validators: {
                        callback:{
                            message: '驾驶机型数量为1至3个',
                            callback: function(value, validator) {
                                var isDriver = $("input[name='isDriver']:checked").val();
                                if(isDriver=="0")
                                    return true;
                                var num_model = $("#function_selected_out").children().length;
                                if(num_model>0&num_model<4)
                                    return true;
                                return false;
                            }
                        }
                    }
                }
            }
        })
                .on('success.form.bv', function(e) {
                    // Prevent form submission
                    e.preventDefault();
                    // Get the form instance
                    var $form = $(e.target);
                    // Get the BootstrapValidator instance
                    var bv = $form.data('bootstrapValidator');
                    var modelList="";
                    $("#function_selected_out").children("span").each(function(){
                        modelList = modelList + $(this).attr("value") + ",";
                    });
                    $('input[name="model"]').val(modelList);
                    var location = $('select[name="city"] option:selected').val();
                    if( location != ""){
                        $('input[name="location"]').val(location);
                    }else{
                        location = $('select[name="province"] option:selected').val();
                        $('input[name="location"]').val(location);
                    }
                    console.log($('#register-form').serialize());
                    $.ajax({
                        type: "post",
                        url: "/user/update",
                        data:$('#register-form').serialize(),
                        success: function(data){
                            if (typeof data == "string") {
                                data = JSON.parse(data);
                            }
                            if(data.status==1000){
                                window.location.href="user.jsp";
                            }else if(data.status==1001){
                                alert("手机号已注册！");
                            }else{
                                alert("信息不完整！");
                            }
                        },
                        error:function(error){
                            alert("connection error!");
                        }
                    });

                });
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
                    $("#location_user").html(data.location);
                    $("#sex_user").html((data.sex==1)?"男":"女");
                    $("#ifDriver_user").html((data.isDriver==1)?"是":"否");
                    $("#user_img").attr("src",data.headPotrait);
                    if(data.isDriver){
                        $("#YearsOfDriving_user").html(data.drivingAge+"年");
                        $("#commission_user").html(data.price+"元/天");
                        if(data.modelNameList){
                            for(var j=0;j<data.modelNameList.length;j++){
                                var str = '<span class="label label-info function_label">' + data.modelNameList[j] + '</span>';
                                $("#carType_user").append(str);
                            }
                        }

                        $('input[name="isDriver"]:eq(0)').attr("checked","checked");
                        $('input[name="price"]').val(data.price);
                        $(".driver_info").show();
                        $("select[name='drivingAge'] option").each(function() {
                            if ($(this).val() == data.drivingAge) {
                                $(this).attr("selected", "selected");
                            }
                        });

                        $.ajax({
                            type: "post",
                            url: "/location/getProvinceList ",
                            success: function(data1){
                                if (typeof data1 == "string") {
                                    data1 = JSON.parse(data1);
                                }
                                if(data1.status==1000){
                                    var result = data1.result;
                                    for (var i = 0; i < result.total; i++) {
                                        var str="<option value='"+result.data[i].locationCode+"'>"+result.data[i].province+"</option>";
                                        $("#location_province").append(str);
                                    }
                                }
                                showMyProvince("location",data.locationCode);
                            },
                            error:function(error){
                                alert("connection error!");
                            }
                        });

                        $.ajax({
                            type: "post",
                            url: "/car/getModelList",
                            success: function(data1){
                                if (typeof data1 == "string") {
                                    data1 = JSON.parse(data1);
                                }
                                if(data1.status==1000){
                                    var result = data1.data;
                                    for (var i = 0; i < 26; i++) {
                                        var str='';
                                        for(var j=0;j<result[i].length;j++){
                                            str="<li><a onclick='addfunction(this)' value="+result[i][j].id+">"+result[i][j].name+"</a></li>";
                                            $("#model ul").append(str);
                                            for(var p=0;p<data.modelNameList.length;p++){
                                                if(data.modelNameList[p]==result[i][j].name){
                                                    str='<span class="label label-info function_label" value="'+result[i][j].id+'">'+data.modelNameList[p]+'<a onclick="removefunction(this)" >&times;</a></span>';
                                                    $("#function_selected_out").append(str);
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            error:function(error){
                                alert("connection error!");
                            }
                        });


                    }else{
                        $(".showForDriver").hide();
                    }

                    //修改用户信息页初始化
                    if(data.sex==1){
                        document.getElementById('m-img').className = 'img-circle img-active';
                        document.getElementById('m-span').className = 'span-active';
                        document.getElementById('f-img').className = 'img-circle';
                        document.getElementById('f-span').className = '';
                        document.getElementsByName('sex').value = "1";
                    }
                    else{
                        document.getElementById('m-img').className = 'img-circle';
                        document.getElementById('m-span').className = '';
                        document.getElementById('f-img').className = 'img-circle img-active';
                        document.getElementById('f-span').className = 'span-active';
                        document.getElementsByName('sex').value = "0";
                    }
                    $('input[name="name"]').val(data.name);
                    $('input[name="phoneNumber"]').val(data.phoneNumber);

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
            url:  "file/uploadAvatar",
            contentType: false,
            processData: false ,
            data: formdata,
            success:function(data) {
                if (data.status == 1000) {
                    //$("#user_img").attr("src",root+'/ePlanFileSys'+data.result.info.path);
                    topAlert("头像上传成功","success");
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

    function add_function_out(){
        $(".function_selected").html($("#function_selected_out").html());
    }
    function addfunction(self){
        var num_model= $(".function_selected").children().length;
        if(num_model>=3){
            alert("最多只能选3个职能");
            return;
        }
        var flag = true;
        $(".function_selected").children("span").each(function(){
            if($(this).attr("value")==$(self).attr("value"))
                flag=false;
        })
        if(flag==true){
            var str='<span class="label label-info function_label" value="'+$(self).attr("value")+'">'+$(self).html()+'<a onclick="removefunction(this)" >&times;</a></span>';
            $(".function_selected").append(str);
        }
    }
    function removefunction(self){
        $(self).parent('.function_label').remove();
        $('#register-form').bootstrapValidator('revalidateField', 'mobelList');//重新验证机型列表
    }
    function submit_function(){
        $("#function_selected_out").html($(".function_selected").html());
        $('#register-form').bootstrapValidator('revalidateField', 'mobelList');//重新验证机型列表
    }
</script>
</body>
</html>