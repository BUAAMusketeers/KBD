<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>发布车辆 | 卡布达</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link href="css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/sell.css" />
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>
<!--顶部-->
<script src="base/head.html"></script>

<div class="container kv-main">
    <div class="row">
        <div class="col-md-12 reg-head">
            <h1>图片上传</h1>
        </div>
    </div>
    <form enctype="multipart/form-data">
        <div class="row" style="margin-top: 10px">
            <div class="form-group col-md-8 col-md-offset-2 clearfix">
                <input type="file" class="file" id="upload" multiple>
            </div>
        </div>
    </form>
</div>
<!--底部-->
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.min.js"></script>
<script src="js/fileinput.min.js" type="text/javascript"></script>
<script src="js/zh.js" type="text/javascript"></script>
<script src="js/utils.js"></script>
<script>
    initImg();

    function initImg(){
        $("#upload").fileinput({
            uploadUrl: '/file/upload', //上传
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
//        initialPreview: [
//            'http://192.168.1.159:80/SubPlat/file/1482308680689',
//            'http://192.168.1.159:80/SubPlat/file/1482308680689',
//        ],
            initialPreviewAsData: true, // allows you to set a raw markup
            initialPreviewFileType: 'image', // image is the default and can be overridden in config below
//        initialPreviewConfig: [
//            {caption: "Desert.jpg", size: 827000, url: "/file-upload-batch/2", key: "1,0",
//                extra: {id: 100}
//            },
//            {caption: "Desert.jpg", size: 827000, url: "/file-upload-batch/2", key: "2,1",
//            },
//        ],
            slugCallback: function(filename) {
                return filename.replace('(', '_').replace(']', '_');
            }
        }).off('filepreupload').on('filepreupload', function() {
            //console.log(data.url);
        }).on("fileuploaded", function(event, outData) {
            console.log(outData.response);
            addFirstImg();
        });
    }
    function addFirstImg(){
        var $divList = $(".file-footer-buttons");
        $divList.each(function (i){
            console.log($(".file-footer-buttons").eq(i).children());
            console.log("/n");
            if($(".file-footer-buttons").eq(i).children().length==2){
                var key = $(".file-footer-buttons").eq(i).children().eq(0).data("key");
                var array = key.split(",");
                var str;
                if(array[1]=="0"){
                    str ='<button type="button" class="kv-file-remove btn btn-xs btn-default setFirst" title="设为首图" data-url="/car/setFirst" data-key="'+array[0]+'">设为首图</button>';
                    $(".file-footer-buttons").eq(i).append(str);
                }else{
                    str ='<button type="button" class="kv-file-remove btn btn-xs btn-default setFirst" title="首图" data-url="/file-upload-batch/2" data-key="'+array[0]+'">首图</button>';
                    $(".file-footer-buttons").eq(i).append(str);
                }
            }
        });
    }
</script>
</body>
</html>