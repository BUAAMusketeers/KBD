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
    <title>车辆图片 | 卡布达</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link href="css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/sell.css" />
    <link href="images/favicon.ico" rel="shortcut icon" />
    <script src="js/utils.js"></script>
</head>

<body>
<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>

<div class="container">
    <ol class="breadcrumb">
        <li><a href="#">首页</a></li>
        <li><a href="user.jsp">个人信息</a></li>
        <li><a href="carManage.jsp">车辆管理</a></li>
        <script>
            var id = getQueryString("vehicleId");
            document.write("<li class='bread_li'><a href='vehicle_manage.jsp?vehicleId="+id+"'>车辆编辑</a></li>")
        </script>
        <%--<li><a href="vehicle_manage.jsp">车辆编辑</a></li>--%>
        <li class="active">车辆图片</li>
    </ol>
    <div class="reg-head" style="margin-top: -50px">
        <h1>车辆图片</h1>
    </div>
</div>

<div class="container kv-main">
    <form enctype="multipart/form-data">
        <div class="row" style="margin-top: 10px">
            <div class="form-group col-md-8 col-md-offset-2 clearfix">
                <input type="file" class="file" id="upload" name="upload[]"multiple>
            </div>
        </div>
    </form>
</div>
<!--底部-->
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/fileinput.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/zh.js" type="text/javascript"></script>
<script>
    $("#upload").fileinput('clear');
    $("#upload").fileinput('destroy');
    initImg();
    function initImg(){
        var preList = new Array();
        var preConfigList = new Array();
        $.ajax({
            type: "post",
            url: "/car/getPictures",
            async: false,//设置为同步传输
            data:{id:id},
            success: function(data){
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if(data.status==1000){
                    var result = data.result;
                    for (var i = 0; i < result.total; i++) {
                        preList[i]=result.data[i].url;
                        var tjson = {
                            caption: result.data[i].caption, // 展示的文件名
                            width: '120px',
                            size:result.data[i].size,
                            url: '/file/delete', // 删除url
                            key: result.data[i].id+","+result.data[i].isFirst, // 删除是Ajax向后台传递的参数
                            extra: {id: result.data[i].id}
                        };
                        preConfigList[i] = tjson;
                    }
                }
            },
            error:function(error){
                alert("connection error!");
            }
        });

        $("#upload").fileinput({
        uploadUrl: '/file/uploadCar', //上传
        deleteUrl: "/site/file-delete",//删除
        initialPreviewAsData: true,//允许初始化数据
        allowedFileExtensions : ['jpg', 'png','gif'],//允许的图片格式
        overwriteInitial: false,//false 初始化的数据不会被覆盖
        language : 'zh',//语言为中文
        showCancel:false,
        initialCaption: "请上传车辆照片",
        maxFileSize: 1000,
        maxFilesNum: 10,
        showZoom: false,
        showCaption:true,//是否显示背景字幕,efault：true
        showPreview: true,
        initialPreview: preList,
        initialPreviewAsData: true, // allows you to set a raw markup
        initialPreviewFileType: 'image', // image is the default and can be overridden in config below
        initialPreviewConfig: preConfigList,
        uploadExtraData:{
            id:id,
            isFirst:0
        },
        slugCallback: function(filename) {

            return filename.replace('(', '_').replace(']', '_');
        }
        }).off('filepreupload').on('filepreupload', function() {
        }).on("fileuploaded", function(event, outData) {
            console.log(outData.response);
            addFirstImg();
            if(outData.error!=null){
                alert(outData.error);
            }
        });
        addFirstImg();
    }
    function addFirstImg() {
        var $divList = $(".file-footer-buttons");
        $divList.each(function (i) {
            console.log($(".file-footer-buttons").eq(i).children());
            console.log("/n");
            if ($(".file-footer-buttons").eq(i).children().length == 2) {
                var key = $(".file-footer-buttons").eq(i).children().eq(0).data("key");
                var array = key.split(",");
                var str;
                if (array[1] == "0") {
                    str = '<button type="button" class="kv-file-remove btn btn-xs btn-default setFirst" title="设为首图" data-url="/file/setFirst" data-key="' + array[0] + '">设为首图</button>';
                    $(".file-footer-buttons").eq(i).append(str);
                } else {
                    str = '<button type="button" class="kv-file-remove btn btn-xs btn-default setFirst" title="首图" data-url="" data-key="' + array[0] + '">首图</button>';
                    $(".file-footer-buttons").eq(i).append(str);
                }
            }
        });
        $(".setFirst").click(function () {
            var key = $(this).data("key");
            var url = $(this).data("url");
            $.ajax({
                type: "post",
                url: url,
                data:{vehicleId:id,
                        pictureId:key},
                success: function(data){
                    if (typeof data == "string") {
                        data = JSON.parse(data);
                    }
                    if(data.status==1000){
                       addFirstImg();
                    }
                },
                error:function(error){
                    alert("connection error!");
                }
            });
        });
    }
</script>
</body>
</html>