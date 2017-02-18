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
    <title>卡布达 | 车辆图片</title>
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
            <input type="hidden" id="flag" value="0">
        </div>
    </form>
</div>
<!--底部-->
<jsp:include page="base/footer.jsp"></jsp:include>
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/fileinput.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/zh.js" type="text/javascript"></script>
<script src="js/login.js" ></script>
<script src="js/buyCar.js"></script>
<script>
    var test=new Vcity.CitySelector({input:'citySelect'});
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
        //uploadsync:false,
        initialPreviewAsData: true,//允许初始化数据
        allowedFileExtensions : ['jpg', 'png','gif'],//允许的图片格式
        overwriteInitial: false,//false 初始化的数据不会被覆盖
        language : 'zh',//语言为中文
        showCancel:false,
        initialCaption: "请上传车辆照片",
        maxFileSize: 1000,
        maxFilesNum: 20,
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
            addFirstImg();
        }).on("fileuploaded", function(event, outData) {
            addFirstImg();
            if(outData.error!=null){
                alert(outData.error);
            }
            var flag=$("#flag").val();
            if(flag==1){
                history.go(0);
            }
        });
        addFirstImg();
    }
    function addFirstImg(a) {
        var $divList = $(".file-footer-buttons");
        $divList.each(function (i) {
            console.log($(".file-footer-buttons").eq(i).children());
            console.log("/n");
                if ($(".file-footer-buttons").eq(i).children().length == 2) {
                    console.log("tre");
                    var key = $(".file-footer-buttons").eq(i).children().eq(0).data("key");
                    var array = key.split(",");
                    var str;
                    if (array[1] == "0") {
                        str = '<button type="button" class=" btn btn-xs btn-default setFirst" title="设为首图" data-url="/file/setFirst" data-key="' + array[0] + '">设为首图</button>';
                        $(".file-footer-buttons").eq(i).append(str);
                    } else {
                        str = '<button type="button" class=" btn btn-xs btn-default setFirst" title="首图" data-url="/file/setFirst" data-key="' + array[0] + '">首图</button>';
                        $(".file-footer-buttons").eq(i).append(str);
                    }
                }
            if(a!=null){
                var $btn = $(".file-footer-buttons").eq(i).children().eq(2);
                if($btn.attr("title")=="首图"){
                    $btn.text("设为首图");
                    $btn.attr("title","设为首图");
                }
            }
        });
        $(a).text("首图");
        $(a).attr("title","首图");

        $(".setFirst").click(function () {
            var key = $(this).data("key");
            var url = $(this).data("url");
            //$(this).text("首图");
            var b = this;
            //console.log(this);
            //$(this).attr("title","首图");
            $.ajax({
                type: "post",
                url: url,
                async: true,
                data:{vehicleId:id,
                        pictureId:key},
                success: function(data){
                    if (typeof data == "string") {
                        data = JSON.parse(data);
                    }
                    if(data.status==1000){
                       addFirstImg(b);
                        //console.log(this); ajax 里面自带this 对象
                    }
                },
                error:function(error){
                    alert("connection error!");
                }
            });
        });
    }
    $(".fileinput-remove").click(function () {
        addFirstImg();
    });
    $(".fileinput-upload").click(function () {
        $("#flag").val("1");
    });

</script>
</body>
</html>