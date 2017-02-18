<%--
  Created by IntelliJ IDEA.
  User: skyxi
  Date: 2017/2/16
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>找驾驶员</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/cityselect.css">
    <link rel="stylesheet" href="css/buyCar.css"/>
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>



<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>

<!--body-->
<div  class="container">
    <!--导航-->
    <ol class="breadcrumb">
        <li><a href="#">首页</a></li>
        <li class="active">找驾驶员</li>
    </ol>
    <!--条件过滤-->
    <div class="fliterBox">
        <dl class="fliter-bd clearfix">
            <dt>驾龄：</dt>
            <dd class="clickBrandWidget">
                <div >

                    <a class="on driveYears" href="#" id="driveYearsId_0" onclick="driveYearsChange(0)">不限</a>
                    <a class=" driveYears" href="#" id="driveYearsId_1" onclick="driveYearsChange(1)">0-3年</a>
                    <a class=" driveYears" href="#" id="driveYearsId_2" onclick="driveYearsChange(2)">4-6年</a>
                    <a class=" driveYears" href="#" id="driveYearsId_3" onclick="driveYearsChange(3)">7-9年</a>
                    <a class=" driveYears" href="#" id="driveYearsId_4" onclick="driveYearsChange(4)">10年以上</a>
                </div>

            </dd>
        </dl>
        <dl class="fliter-bd clearfix">
            <dt>机型：</dt>
            <dd class="clickBrandWidget">
                <div id="hotTypeList">
                    <%--<a class="on" href="/bj/buy/" rel="nofollow">不限</a>
                    <a class="" href="/bj/buy/" rel="nofollow">宝马</a>
                    <a class="" href="/bj/buy/" rel="nofollow">奔驰</a>--%>
                </div>
                <div class="dropdown "  >
                    <a id="typeAll"  href="#"  data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        全部
                        <span class="caret"></span>
                    </a>

                    <div class="dropdown-menu selectBox" aria-labelledby="typeAll" id="typeAllBox">
                        <div class="itemListBox">
                            <%--<div class="itemBox">
                                <dl>
                                    <dt>A</dt>
                                    <dd>
                                        <a href="#">宝马</a>
                                        <a href="#">宝马</a>
                                        <a href="#">阿斯顿马丁</a>
                                        <a href="#">宝马</a>
                                        <a href="#">宝马</a>
                                        <a href="#">宝马</a>
                                        <a href="#">宝马</a>
                                    </dd>
                                </dl>
                            </div>--%>

                        </div>
                    </div>
                </div>

            </dd>
        </dl>
    </div>

    <!--排序方式-->
    <div class="seqBox clearfix">
        <p class="fr seqP">
            共找到<b id="carAmount"></b>辆
        </p>
        <div class="fl seqDiv">
            <div class="btn-group">
                <button type="button" id="seqId_1" onclick="sortChange(this)" class="btn btn-default seqBtn selected">默认排序</button>
                <button type="button" id="seqId_2" onclick="sortChange(this)" class="btn btn-default seqBtn">驾龄<span class="glyphicon glyphicon-arrow-up"></span></button>
                <button type="button" id="seqId_4" onclick="sortChange(this)" class="btn btn-default seqBtn">驾龄<span class="glyphicon glyphicon-arrow-down"></span></button>
            </div>
        </div>
    </div>
    <!--图片展示-->
    <div class="list">
        <div class="row carList" id="carListBox">
            <%--<div class="col-sm-6 col-md-3 listBox">
                <div class="thumbnail">
                    <img src="images/demo.jpg" alt="...">
                    <div class="infoDiv">
                        <p class="infoBox"><a>蒋名义</a></p>
                        <p class="infoGray">
                            <span>2015年上牌</span>
                            <em class="verticalLine">|</em>
                            <span>使用25小时</span>
                            <em class="verticalLine">|</em>
                            <span>45吨</span>
                        </p>
                        <p class="infoPrice">
                            价格：
                            <span>14.6万</span>
                        </p>
                    </div>
                </div>
            </div>--%>
        </div>
        <!--分页-->
        <div class="page" id="id_set_page">

        </div>
    </div>

</div>
<!--底部-->
<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript" src="js/page.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<script >

    $("#searchCarBtn").click(function () {
        var keywords=$("#cityInput").val();
        var city=$("#citySelect").val();
        window.location.href="seekDriver.jsp?city="+city+"&keywords="+keywords;
    });

    var driveYears=0;
    var carType=0;
    var root="";
    var sort=0;
    var global = {
        "limit": 16,
        "selectedPage": 1
    };
    $(document).ready(function(){
        var test=new Vcity.CitySelector({input:'citySelect'});
        var city=getQueryString("city")?getQueryString("city"):"成都市";
        var keywords=getQueryString("keyword")?getQueryString("keyword"):"";
        $("#cityInput").val(keywords);
        $("#citySelect").val(city);
        getDrivers();
        loadType();
        getTypeList();
        /*$(".showBox").hover(function(){
         var boxName=this.id+"Box";
         var div=document.getElementById(boxName);
         div.style.display="block";
         },function(){
         var boxName=this.id+"Box";
         var div=document.getElementById(boxName);
         div.style.display="none";

         })
         $(".selectBox").mouseleave(function () {
         this.style.display="none";
         })*/
    });


    var pagecallback = function(p) {
        global["selectedPage"] = Number(p);
        getDrivers();
    }


    function getDrivers(){
        var keyword=$("#cityInput").val();
        var city=$("#citySelect").val();
        //console.log(keyword);
        $.ajax({
            type: "POST",
            url:  "/user/getDrivers",
            data: {city:city,drivingAge:driveYears,model:carType,sort:sort, keyword:keyword,limit:global["limit"], page:global["selectedPage"]},
            success:function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (data.status == 1000) {
                    $("#carListBox").empty();
                    $("#carAmount").html(data.result.total);
                    if (data.result.total) {

                        var total_page = Math.ceil(data.result.total / global["limit"]);
                        var opt = {
                            selectedPage: global["selectedPage"],
                            total: total_page,
                            pageLength: global["limit"],
                            callback: pagecallback
                        };
                        $("#id_set_page").Pagination(opt);

                        var result = data.result.data;
                        var length = result.length;
                        for (var i = 0; i < length; i++) {

                            if(result.drivingAge<10){
                                var drivingAge=result[i].drivingAge+"年";
                            }else {
                                var drivingAge="10年以上"
                            }
                            var model='<span>驾驶机型：'+result[i].model[0]+'</span>';
                            for(var j=1;j<model.length;j++){
                                model+='<em class="verticalLine">|</em>'+'<span>'+result[i].model[j]+'</span>' ;
                            }
                            var str=''+
                                '<div class="col-sm-6 col-md-3 listBox">' +
                                '<div class="thumbnail">' +
                                '<div class="imgDiv">' +
                                '<a href="vehicle_detail.jsp?vehicleId='+result[i].id+'"><img src="'+result[i].headPotrait+'" alt="picture"></a>' +
                                '</div>' +
                                '<p class="infoBox"><a href="#">'+result[i].name+'</a><span class="driveYearSpan">'+drivingAge+'驾龄</span></p>' +
                                '<p class="infoGray">' +
                                model+
                                '</p>' +
                                '<p class="infoGray"> 联系方式：' +
                                '<span>'+result[i].phoneNumber+'</span>' +
                                '</p>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                            $("#carListBox").append(str);
                        }


                    }
                    else {
                        $("#id_set_page").hide();
                    }
                }
            },
            datatype:"json"
        });
    }

    /*获取类型列表*/
    function getTypeList(){
        $.ajax({
            type: "POST",
            url:  root+"/car/getModelList",
            success:function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (data.status == 1000) {

                    var result = data.data;
                    for (var i = 0; i < 26; i++) {
                        var letterPre=letter[i];
                        var str='';
                        for(var j=0;j<result[i].length;j++){
                            str+='<a id="typeClick_'+result[i][j].id+'" onclick="typeClick('+result[i][j].id+')">'+result[i][j].name+'</a>';
                        }
                        if(result[i].length) {
                            var str0 = '<div class="itemBox"><dl><dt>' + letterPre + '</dt><dd>' + str + '</dd></dl></div>';
                            $("#typeAllBox .itemListBox").append(str0);
                        }
                    }




                }
            },
        });
    }
    /*热门品牌*/

    function driveYearsChange(id) {

        $(".driveYears").removeClass("on");
        $("#driveYearsId_"+id).addClass("on");
        driveYears=id;
        getDrivers();

    }

    /*热门类型*/
    function loadType(){
        var length=hotType.length;
        var str='<a class="on hotTypeA" href="#" id="typeId_0" onclick="typeChange(0)">'+hotType[0]+'</a>';
        $("#hotTypeList").append(str);
        for(var i=1;i<length;i++){
            var str='<a class="hotTypeA" href="#" id="typeId_'+i+'" onclick="typeChange('+i+')">'+hotType[i]+'</a>';
            $("#hotTypeList").append(str);
        }
    }
    function typeChange(id) {

        $(".hotTypeA").removeClass("on");
        $("#typeId_"+id).addClass("on");
        carType=id;
        getDrivers();

    }
    function typeClick(id) {
        var name=$("#typeClick_"+id).html();
        if(id>=hotType.length){
            var str='<a class="on hotTypeA" href="#" id="typeId_'+id+'" >'+name+'</a>';
            $("#hotTypeList").append(str);

        }
        typeChange(id);
    }
    /*排序变化*/
    function sortChange(self) {
        sort=Number(self.id.slice(-1));
        $(".seqBtn").removeClass("selected");
        $(self).addClass("selected");
        getDrivers();

    }


</script>
</body>
</html>
