<%--
  Created by IntelliJ IDEA.
  User: skyxi
  Date: 2017/1/15
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>test</title>
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
        <li class="active">买车</li>
    </ol>
    <!--条件过滤-->
    <div class="fliterBox">
        <dl class="fliter-bd clearfix">
            <dt>品牌：</dt>
            <dd class="clickBrandWidget">
                <div id="hotBrandList">


                    <%--
                    <a class="" href="#" rel="nofollow">宝马</a>
                    <a class="" href="#" rel="nofollow">奔驰</a>--%>
                </div>

                <a>
                    <div class="dropdown">
                        <a id="brandAll" class="showBox">
                            全部
                            <span class="caret"></span>
                        </a>

                        <div class="selectBox " id="brandAllBox">
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
                </a>
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
                <a>
                    <div class="dropdown">
                        <a id="typeAll" class="showBox">
                            全部
                            <span class="caret"></span>
                        </a>

                        <div class="selectBox " id="typeAllBox">
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
                </a>
            </dd>
        </dl>
    </div>

    <!--排序方式-->
    <div class="seqBox clearfix">
        <p class="fr seqP">
            共找到<b>456</b>辆
        </p>
        <div class="fl seqDiv">
            <div class="btn-group">
                <button type="button" id="seqId_1" onclick="sortChange(this)" class="btn btn-default seqBtn selected">默认排序</button>
                <button type="button" id="seqId_2" onclick="sortChange(this)" class="btn btn-default seqBtn">价格<span class="glyphicon glyphicon-arrow-up"></span></button>
                <button type="button" id="seqId_4" onclick="sortChange(this)" class="btn btn-default seqBtn">价格<span class="glyphicon glyphicon-arrow-down"></span></button>
                <button type="button" id="seqId_5" onclick="sortChange(this)" class="btn btn-default seqBtn">车龄<span class="glyphicon glyphicon-arrow-up"></button>
                <button type="button" id="seqId_6" onclick="sortChange(this)" class="btn btn-default seqBtn">使用小时<span class="glyphicon glyphicon-arrow-up"></button>
            </div>
        </div>
    </div>
    <!--图片展示-->
    <div class="list">
        <div class="row carList" id="carListBox">
            <div class="col-sm-6 col-md-3 listBox">
                <div class="thumbnail">
                    <img src="images/demo.jpg" alt="...">
                    <div class="infoDiv">
                        <p class="infoBox"><a>T现代车两全开T现代车两全开那个in爱姑娘IGN那个in爱姑娘IGN</a></p>
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
            </div>
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


    var brand=0;
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
        getCarList();
        loadBrand();
        loadType();
        getBrandList();
        getTypeList();
        $(".showBox").hover(function(){
            var boxName=this.id+"Box";
            var div=document.getElementById(boxName);
            div.style.display="block";
        },function(){
            var boxName=this.id+"Box";
            var div=document.getElementById(boxName);
            if(div.contains(window.event.srcElement)){
                div.style.display="none";

            }
        })
        $(".selectBox").mouseleave(function () {
            this.style.display="none";
        })
    });


    var pagecallback = function(p) {
        global["selectedPage"] = Number(p);
        getCarList();
    }


    function getCarList(){
        var keyword=$("#cityInput").val();
        var city=$("#citySelect").val();
        //console.log(keyword);
        $.ajax({
            type: "POST",
            url:  "/car/getSellList",
            data: {city:city,brand:brand,model:carType,sort:sort, keyword:keyword,limit:global["limit"], page:global["selectedPage"]},
            success:function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (data.status == 1000) {
                    $("#carListBox").empty();
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
                            var str=''+
                            '<div class="col-sm-6 col-md-3 listBox">' +
                            '<div class="thumbnail">' +
                            '<img src="images/demo.jpg" alt="...">' +
                            '<div class="infoDiv">' +
                            '<p class="infoBox"><a>T现代车两全开T现代车两全开那个in爱姑娘IGN那个in爱姑娘IGN</a></p>' +
                            '<p class="infoGray">' +
                            '<span>2015年上牌</span>' +
                            '<em class="verticalLine">|</em>' +
                            '<span>使用25小时</span>' +
                            '<em class="verticalLine">|</em>' +
                            '<span>45吨</span>' +
                            '</p>' +
                            '<p class="infoPrice"> 价格：' +
                            '<span>24.4万</span>' +
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
    /*获取品牌列表*/
    function getBrandList(){
        $.ajax({
            type: "POST",
            url:  root+"/car/getBrandList",
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
                                str+='<a id="brandClick_'+result[i][j].id+'" onclick="brandClick('+result[i][j].id+')">'+result[i][j].name+'</a>';

                            }
                            if(result[i].length){
                                var str0='<div class="itemBox"><dl><dt>'+letterPre+'</dt><dd>'+str+'</dd></dl></div>';
                                $("#brandAllBox .itemListBox").append(str0)
                            }
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
    function loadBrand(){
        var length=hotBrand.length;
        var str='<a class="on hotBrandA" href="#" id="brandId_0" onclick="brandChange(0)">'+hotBrand[0]+'</a>';
        $("#hotBrandList").append(str);
        for(var i=1;i<length;i++){
            var str='<a class="hotBrandA" href="#" id="brandId_'+i+'" onclick="brandChange('+i+')">'+hotBrand[i]+'</a>';
            $("#hotBrandList").append(str);
        }
    }
    function brandChange(id) {

        $(".hotBrandA").removeClass("on");
        $("#brandId_"+id).addClass("on");
        brand=id;
        getCarList();

    }
    function brandClick(id) {
        var name=$("#brandClick_"+id).html();
        if(id>=hotBrand.length){
            var str='<a class="on hotBrandA" href="#" id="brandId_'+id+'" >'+name+'</a>';
            $("#hotBrandList").append(str);

        }
        brandChange(id);
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
        getCarList();

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
        getCarList();

    }


</script>
</body>
</html>
