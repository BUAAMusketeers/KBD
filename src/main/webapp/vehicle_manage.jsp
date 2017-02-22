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
    <title>车辆编辑 | 卡布达</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrapValidator.min.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/sell.css" />
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>
<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>
<div class="container">
    <ol class="breadcrumb">
        <li><a href="index.jsp">首页</a></li>
        <li><a href="user.jsp">个人信息</a></li>
        <li><a href="carManage.jsp">车辆管理</a></li>
        <li class="active">车辆编辑</li>
    </ol>
    <div class="reg-head" style="margin-top: -50px">
        <h1>更新车辆</h1>
    </div>

    <div class="row">
        <div class="col-md-6 sell-body col-md-offset-3">
            <form id="register-form" class="form-horizontal">
                <input type="hidden"  name="location" value="">
                <input type="hidden"  name="id" value="">
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">选择分类:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control for-xs" name="model"><option value="">请选择</option></select>
                    </div>
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">选择品牌:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control" name="brand"><option value="">请选择</option></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">出厂年限:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control for-xs" name="vehicleAge">
                            <option value="">请选择</option>
                        </select>
                    </div>
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">设备型号:</label>
                    <div class="col-md-4 col-xs-7">
                        <input type="text" id="equipmentNumber" class="form-control" name="equipmentNumber" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">使用小时:</label>
                    <div class="col-md-4 col-xs-7">
                        <input class="form-control to_right for-xs" type="text"   name="usedHours" autocomplete="off" >
                        <span class="unit">
                                ｜<label class="cur">小时</label>
                        </span>
                    </div>
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">吨位:</label>
                    <div class="col-md-4 col-xs-7">
                        <input type="text" id="tonnage" class="form-control to_right" name="tonnage" autocomplete="off">
                        <span class="unit">
                                ｜<label class="cur">吨</label>
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">联系人:</label>
                    <div class="col-md-4 col-xs-7">
                        <input type="text" id="contact" class="form-control for-xs" name="contact" autocomplete="off">
                    </div>
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">联系电话:</label>
                    <div class="col-md-4 col-xs-7">
                        <input type="text" id="contactPhone" class="form-control" name="contactPhone" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label control-label">停放地点:</label>
                    <div class="col-md-3 col-md-offset-0 col-xs-7 for-xs">
                        <select class="form-control" name="province" id="location_province" onchange="javascript:showMyCity('location', this.value)"><option value="">请选择省</option></select>
                    </div>
                    <div class="col-md-3 col-md-offset-0 col-xs-7 col-xs-offset-4 for-xs">
                        <select class="form-control" name="city" id="location_city" onchange="javascript:showMyCounty('location', this.value)"><option value="">请选择市</option></select>
                    </div>
                    <div class="col-md-3 col-md-offset-0 col-xs-7 col-xs-offset-4">
                        <select class="form-control" name="county" id="location_county"><option value="">请选择区</option></select>
                    </div>
                </div>
                <!--<div class="form-group img-group">-->
                <!--<ul id="img-group">-->
                <!--<li class="picList">-->
                <!--<div class="img">-->
                <!--<img src="http://img.tiebaobei.com/img/170115/213655d858b53dbbd87dc9b9d0502e26_2.jpg" deg="0">-->
                <!--<input type="hidden" id="imageIdIpt" value="170115/213655d858b53dbbd87dc9b9d0502e26.jpg" name="image1">-->
                <!--</div>-->
                <!--<div class="set first"><span class="on fl">首图</span></div>-->
                <!--<i class="btn-close"></i>-->
                <!--</li>-->
                <!--</ul>-->
                <!--</div>-->
                <!--<div class="form-group">-->
                <!--<label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">车辆照片:</label>-->
                <!--<div class="col-md-4 col-xs-7">-->
                <!--<input type="file" multiple="true"  id="uploadpicture"  tabindex="-1" onchange="fileok(this)" style="position: absolute; clip: rect(0px 0px 0px 0px);">-->
                <!--<label id="selectfile" for="uploadpicture" class="btn btn-primary ">-->
                <!--<span class="icon-span-filestyle glyphicon glyphicon-folder-open"></span>-->
                <!--<span class="buttonText">选择文件</span><span class="glyphicon glyphicon-ok" style="display:none;"></span>-->
                <!--</label>-->
                <!--</div>-->
                <!--<div id="upload_btn" class="uploadify" style="height: 30px; width: 80px;">-->
                <!--</div>-->

                <!--</div>-->
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">使用经历:</label>
                    <div class="col-md-10 col-xs-7">
                        <textarea class="form-control" name="description"></textarea>
                    </div>
                </div>
                <div class="form-group isSell">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label control-label">是否出售:</label>
                    <div style="margin-top: 7px">
                        <input class="col-xs-1" type="radio" value="1" name="isSell"/>
                        <label class="col-xs-1 toleft">是</label>
                        <input class="col-xs-1" type="radio" value="0" name="isSell" checked="checked" />
                        <label class="col-xs-1 toleft">否</label>
                    </div>
                </div>
                <div class="form-group sellState" style="display: block">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">出售状态:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control for-xs" name="sellState">
                            <option value="0">待售</option>
                            <option value="1">已售</option>
                            <option value="2">下架</option>
                        </select>
                    </div>
                </div>
                <div class="sell_info form-group" style="display: none;">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">出售价格:</label>
                    <div class="col-md-4 col-xs-7">
                        <input class="form-control to_right" type="text"  name="sellPrice" autocomplete="off" >
                        <span class="unit">
                                ｜<label class="cur">万元</label>
                        </span>
                    </div>
                </div>
                <div class="form-group isRent">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">是否出租:</label>
                    <div style="margin-top: 7px">
                        <input class="col-xs-1" type="radio" value="1" name="isRent"/>
                        <label class="col-xs-1 toleft">是</label>
                        <input class="col-xs-1" type="radio" value="0" name="isRent" checked="checked" />
                        <label class="col-xs-1 toleft">否</label>
                    </div>
                </div>
                <div class="form-group rentState">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">出租状态:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control for-xs" name="rentState">
                            <option value="0">待租</option>
                            <option value="1">已租</option>
                            <option value="2">下架</option>
                        </select>
                    </div>
                </div>
                <div class="rent_info form-group" style="display: none;">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">出租价格:</label>
                    <div class="col-md-4 col-xs-7">
                        <input class="form-control to_right" type="text" name="rentPrice" autocomplete="off" >
                        <span class="unit">
                                ｜<label class="cur">元/天</label>
                        </span>
                    </div>
                </div>
                <div class="form-group btn-area row">
                    <button type="submit" class="btn btn-primary btn-sm  col-md-4 col-md-offset-1" id="update-btn">确认修改</button>
                    <input type="button" class="btn btn-primary btn-sm  col-md-4 col-md-offset-1" id="img-btn" onclick="showImg()" value="车辆图片">
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
<script type="text/javascript" src="js/jquery.form.js"></script>
<script src="js/sell.js" ></script>
<script src="js/login.js" ></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script src="js/buyCar.js"></script>
<script>
    $(function(){
        initCity();
        for(var i=1997; i<=2017;i++){
            var str = "<option value='"+i+"'>"+i+"</option>";
            $("select[name='vehicleAge']").append(str);
        }
        initProvinceList();
        initVehicel();
        $("input[name=isSell]").click(function(){
            if(this.value=="1"){
                $(".sell_info").fadeIn(500);
            }
            else{
                $(".sell_info").fadeOut(500);
            }
            $('#register-form').bootstrapValidator('resetForm',false);
        });
        $("input[name=isRent]").click(function(){
            if(this.value=="1"){
                $(".rent_info").fadeIn(500);
            }
            else{
                $(".rent_info").fadeOut(500);
            }
            $('#register-form').bootstrapValidator('resetForm',false);
        });




        $('#register-form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                model: {
                    validators: {
                        notEmpty: {
                            message: '请选择分类'
                        }
                    }
                },
                brand: {
                    validators: {
                        notEmpty: {
                            message: '请选择品牌'
                        }
                    }
                },
                vehicleAge: {
                    validators: {
                        notEmpty: {
                            message: '请选择出厂年限'
                        }
                    }
                },
                equipmentNumber: {
                    validators: {
                        notEmpty: {
                            message: '请输入设备型号'
                        },
                        stringLength: {
                            min: 4,
                            max: 20,
                            message: '请输入4-20位设备型号'
                        }
                    }
                },
                usedHours: {
                    validators: {
                        notEmpty: {
                            message: '请输入使用小时'
                        },
                        regexp: {
                            regexp: /^[0-9_\.]+$/,
                            message: '请输入正确的使用小时数'
                        }
                    }
                },
                tonnage: {
                    validators: {
                        notEmpty: {
                            message: '请输入吨数'
                        },
                        regexp: {
                            regexp: /^[0-9_\.]+$/,
                            message: '请输入正确的吨数'
                        }
                    }
                },
                contact: {
                    validators: {
                        notEmpty: {
                            message: '请输入联系人'
                        },
                    }
                },
                contactPhone: {
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
                county: {
                    validators: {
                        notEmpty: {
                            message: '请选择区'
                        },
                    }
                },
                description: {
                    validators: {
                        notEmpty: {
                            message: '请输入使用经历'
                        },
                    }
                },
                sellPrice:{
                    validators: {
                        callback:{
                            message: '请填写正确形式的出售价格',
                            callback: function(value, validator) {
                                var isDriver = $("input[name='isSell']:checked").val();
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
                rentPrice:{
                    validators: {
                        callback:{
                            message: '请填写正确形式的出租价格',
                            callback: function(value, validator) {
                                var isDriver = $("input[name='isRent']:checked").val();
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
            }
        })
                .on('success.form.bv', function(e) {
                    // Prevent form submission
                    e.preventDefault();

                    // Get the form instance
                    var $form = $(e.target);

                    // Get the BootstrapValidator instance
                    var bv = $form.data('bootstrapValidator');
                    var location = $('select[name="county"] option:selected').val();
                    $('input[name="location"]').val(location);

                    $.ajax({
                        type: "post",
                        url: "/car/updateCar",
                        data:$('#register-form').serialize(),
                        success: function(data){
                            if (typeof data == "string") {
                                data = JSON.parse(data);
                            }
                            if(data.status==1000){
                                alert("发布成功!");
                                history.go(0);//刷洗当前页面
                            }else{
                                alert("信息不完整！");
                            }
                        },
                        error:function(error){
                            alert("connection error!");
                        }
                    });
                });
        function initVehicel(){
            var id = getQueryString("vehicleId");
            $("input[name='id']").val(id);
            $.ajax({
                type: "post",
                url: "/car/getCarInfo",
                data:{"id":id},
                success: function(data){
                    if (typeof data == "string") {
                        data = JSON.parse(data);
                    }
                    if(data.status==1000){
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
                                            str='<option value="'+result[i][j].id+'">'+result[i][j].name+'</option>';
                                            $("select[name='model']").append(str);
                                        }
                                    }
                                    $("select[name='model'] option").each(function() {
                                        if ($(this).text() == data.data.model) {
                                            $(this).attr("selected", "selected");
                                        }
                                    });
                                }
                            },
                            error:function(error){
                                alert("connection error!");
                            }
                        });
                        $.ajax({
                            type: "post",
                            url: "/car/getBrandList",
                            success: function(data1){
                                if (typeof data1 == "string") {
                                    data1 = JSON.parse(data1);
                                }
                                if(data1.status==1000){
                                    var result = data1.data;
                                    for (var i = 0; i < 26; i++) {
                                        var str='';
                                        for(var j=0;j<result[i].length;j++){
                                            str='<option value="'+result[i][j].id+'">'+result[i][j].name+'</option>';
                                            $("select[name='brand']").append(str);
                                        }
                                    }
                                    $("select[name='brand'] option").each(function() {
                                        if ($(this).text() == data.data.brand) {
                                            $(this).attr("selected", "selected");
                                        }
                                    });
                                }
                            },
                            error:function(error){
                                alert("connection error!");
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
                                showMyProvince("location",data.data.locationCode);
                            },
                            error:function(error){
                                alert("connection error!");
                            }
                        });


                        $("select[name='vehicleAge'] option").each(function() {
                            if ($(this).text() == data.data.vehicleAge) {
                                $(this).attr("selected", "selected");
                            }
                        });
                        $("input[name='equipmentNumber']").val(data.data.equipmentNumber);
                        $("input[name='usedHours']").val(data.data.usedHours);
                        $("input[name='tonnage']").val(data.data.tonnage);
                        $("input[name='equipmentNumber']").val(data.data.equipmentNumber);
                        $("input[name='contact']").val(data.data.contact);
                        $("input[name='contactPhone']").val(data.data.contactPhone);

                        $("textarea[name='description']").val(data.data.description);
                        if(data.data.sell==0){
                            $(".sellState").css("display","none");
                            $(".sell_info").hide();
                            $(".isSell").show();
                        }else{
                            $(".sellSate").show();
                            $(".sell_info").show();
                            $(".isSell").hide();
                            $("input[name='sellPrice']").val(data.data.sellPrice);
                            $("select[name='sellState'] option").each(function() {
                                if ($(this).val() == data.data.sellState) {
                                    $(this).attr("selected", "selected");
                                }
                            });
                            $("input[name='isSell']:eq(0)").attr("checked","checked");
                        }
                        if(data.data.rent==0){
                            $(".rentState").hide();
                            $(".rent_info").hide();
                            $(".isRent").show();
                        }else{
                            $(".rentSate").show();
                            $(".rent_info").show();
                            $(".isRent").hide();
                            $("input[name='rentPrice']").val(data.data.rentPrice);
                            $("select[name='rentState'] option").each(function() {
                                if ($(this).val() == data.data.rentState) {
                                    $(this).attr("selected", "selected");
                                }
                            });
                            $("input[name='isRent']:eq(0)").attr("checked","checked");
                        }

                    }else{
                        alert(data.message);
                    }
                },
                error:function(error){
                    alert("connection error!");
                }
            });
        }
    });
    function showImg() {
        var id = getQueryString("vehicleId");
        window.location.href="img_push.jsp?vehicleId="+id;
    }
</script>
</body>
</html>