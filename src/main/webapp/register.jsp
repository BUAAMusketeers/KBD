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
    <title>注册 | 卡布达</title>
    <link rel="stylesheet" href="css/bootstrapValidator.min.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/sell.css" />
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>
<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12 reg-head">
            <h1>注册</h1>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-4 reg-body" style="">
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
                <div class="form-group">
                    <label class="col-xs-4 control-label">登录密码:</label>
                    <div class="col-xs-8">
                        <input type="password" id="password" class="form-control" name="password" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 control-label">确认密码:</label>
                    <div class="col-xs-8">
                        <input type="password" id="confirmPassword" class="form-control" name="confirmPassword" autocomplete="off">
                    </div>
                </div>
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
                <div class="form-group agree">
                    <div class="checkbox">
                        <input type="checkbox" id="checkAgreement"  name="checkAgreement" checked="true">我同意
                        <a href="agreement.html" target="_blank">《卡布达网注册协议》</a>
                    </div>
                </div>
                <div class="form-group btn-area">
                    <button type="submit" style="" class="btn btn-primary btn-lg btn-block" id="register-btn">注册</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--底部-->
<jsp:include page="base/footer.jsp"></jsp:include>
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.min.js"></script>
<script src="js/utils.js"></script>
<script src="js/bootstrap-filestyle.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/login.js"></script>
<script>
    $(function(){
        $.ajax({
            type: "post",
            url: "/car/getModelList",
            success: function(data){
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if(data.status==1000){
                    var result = data.data;
                    for (var i = 0; i < 26; i++) {
                        var str='';
                        for(var j=0;j<result[i].length;j++){
                            str="<li><a onclick='addfunction(this)' value="+result[i][j].id+">"+result[i][j].name+"</a></li>";
                            $("#model ul").append(str);
                        }
                    }
                }
            },
            error:function(error){
                alert("connection error!");
            }
        });
        initProvinceList();


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
                password: {
                    validators: {
                        notEmpty: {
                            message: '请输入登录密码'
                        },
                        stringLength: {
                            min: 6,
                            max: 20,
                            message: '请输入6-20位密码'
                        }
                    }
                },
                confirmPassword: {
                    validators: {
                        notEmpty: {
                            message: '请再次确认登陆密码'
                        },
                        identical: {
                            field: 'password',
                            message: '两次输入的密码不同!请重试'
                        }
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
                        url: "/user/register",
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
    //上传头像
    function fileok(sender){
        if( !sender.value.match( /.jpg|.gif|.png|.bmp/i ) ){
            topAlert('图片格式无效！','error');
            return false;
        }
        var objPreview = document.getElementById('user_img');
        if( sender.files && sender.files[0] ){
            console.log(sender.files.length);
            objPreview.src = window.URL.createObjectURL(sender.files[0]);
        }
    }
    function uploadFile(){
        var file=$('#uploadpicture').prop('files');
        var formdata = new FormData();
        formdata.append("fileToUpload", file[0]);

        console.log(file[0]);
        $.ajax({
            type: "POST",
            url:  root+"/fileHandler/uploadFile?flag=2",
            contentType: false,
            processData: false ,
            data: formdata,
            success:function(data) {
                if (data.errorcode == 3000) {
                    //$("#user_img").attr("src",root+'/ePlanFileSys'+data.result.info.path);
                    modifyPortrait(data.result.info.path);
                }
            },
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