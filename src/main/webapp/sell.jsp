<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>发布车辆 | 卡布达</title>
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/sell.css" />
    <link rel="stylesheet" href="css/bootstrapValidator.min.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>
<!--顶部-->
<script src="base/head.html"></script>
<div class="container">
    <div class="row">
        <div class="col-md-12 reg-head">
            <h1>发布车辆</h1>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-6 sell-body col-md-offset-3">
            <form id="register-form" class="form-horizontal">
                <input type="hidden"  name="location" value="">
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">选择分类:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control for-xs" name="modelId"><option value="">请选择</option></select>
                    </div>
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">选择品牌:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control" name="brandId"><option value="">请选择</option></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">出厂年限:</label>
                    <div class="col-md-4 col-xs-7">
                        <select class="form-control for-xs" name="vehicleAge"><option value="">请选择</option></select>
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
                        <select class="form-control" name="province"><option value="">请选择省</option></select>
                    </div>
                    <div class="col-md-3 col-md-offset-0 col-xs-7 col-xs-offset-4 for-xs">
                        <select class="form-control" name="city"><option value="">请选择市</option></select>
                    </div>
                    <div class="col-md-3 col-md-offset-0 col-xs-7 col-xs-offset-4">
                        <select class="form-control" name="county"><option value="">请选择区</option></select>
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
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label control-label">是否出售:</label>
                    <div style="margin-top: 7px">
                        <input class="col-xs-1" type="radio" value="1" name="isSell"/>
                        <label class="col-xs-1 toleft">是</label>
                        <input class="col-xs-1" type="radio" value="0" name="isSell" checked="checked" />
                        <label class="col-xs-1 toleft">否</label>
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
                <div class="form-group">
                    <label class="col-md-2 col-md-offset-0 col-xs-3 col-xs-offset-1 control-label">是否出租:</label>
                    <div style="margin-top: 7px">
                        <input class="col-xs-1" type="radio" value="1" name="isRent"/>
                        <label class="col-xs-1 toleft">是</label>
                        <input class="col-xs-1" type="radio" value="0" name="isRent" checked="checked" />
                        <label class="col-xs-1 toleft">否</label>
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
                <div class="form-group btn-area">
                    <button type="submit" class="btn btn-primary btn-lg btn-block" id="push-btn">发布</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--底部-->
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.min.js"></script>
<script src="js/utils.js"></script>
<script src="js/bootstrap-filestyle.js"></script>
<script src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script src="js/sell.js" ></script>
<script>
    $(function(){
        initModelList();
        initBrandList();
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
                modelId: {
                    validators: {
                        notEmpty: {
                            message: '请选择分类'
                        }
                    }
                },
                brandId: {
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
                        url: "/car/publishCar",
                        data:$('#register-form').serialize(),
                        success: function(data){
                            if (typeof data == "string") {
                                data = JSON.parse(data);
                            }
                            if(data.status==1000){
                                alert("发布成功!");
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
    function a() {
        alert("test");
    }
    //上传头像
    function fileok(sender){
        if( !sender.value.match( /.jpg|.gif|.png|.bmp/i ) ){
            topAlert('图片格式无效！','error');
            return false;
        }
        if( sender.files && sender.files[0] ){
            console.log(sender.files.length);
            var src = window.URL.createObjectURL(sender.files[0]);
            var str = '<li class="picList">'+
                    '<div class="img">'+
                    '<img src="'+src+'" deg="0">'+
                    '</div>'+
                    '<div class="set"><span class="on fl">首图</span></div>'+
                    '<i class="btn-close"></i>'+
                    '</li>';
            $("#img-group").append(str);
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
</script>
</body>
</html>