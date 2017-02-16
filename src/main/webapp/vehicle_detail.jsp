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
    <title>车辆详情 | 卡布达</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/cityselect.css">
    <link rel="stylesheet" href="css/vehicle_detail.css">
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>
<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>
<div class="container">
    <ol class="breadcrumb">
        <li><a href="#">首页</a></li>
        <li><a href="buyCar.jsp">买车</a></li>
        <%--<li><a href="carManage.jsp">车辆信息</a></li>--%>
        <li class="active">车辆信息</li>
    </ol>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-6">
            <div class="det-sumleft slideshow">
                <div class="dt-sumpic" data-role="imgContainer">
                    <a href="javascript:void(0);" data-role="imgArrow" class="arrow-prew prev"></a>
                    <a href="javascript:void(0);" data-role="imgArrow" class="arrow-next next"></a>
                    <p class="amount">
                        <i class="fc-org" data-role="currentNumber">1</i>/
                        <span name="total">30</span>
                    </p>
                    <input type="hidden" data-role="navbtn" data-maskname="mask2" id="js-login">
                    <input type="hidden" data-role="navbtn" data-maskname="mask3" id="skipKind" value="1">
                    <ul class="det-picside">

                    </ul>
                </div>
            </div>
        </div>
        <div class="vehicle col-md-6">
            <div >
                <p class="title col-xs-12">
                    <span class="vehicle_name col-xs-8" name="title"></span>
                    <span class="vehicle_update col-xs-4" name="time"></span>
                </p>

                <p class="price">
                    <span class="pric_number" name="price"></span>
                    <span class="pric_number col-xs-3 col-xs-offset-1" style="float: right;" name="tonnage"></span>
                </p>

                <div class="device_inf">
                    <div class="d_inf">
                        <input type="hidden" id="equipmentCityId" value="45074">
                        <div class="ecolor" name="location"></div>
                        <div class="sec_div">停放</div>
                    </div>
                    <div class="d_inf">
                        <div class="ecolor" name="used_hours"></div>
                        <div class="sec_div">小时</div>
                    </div>
                    <div class="d_inf last_d_inf">
                        <div class="ecolor" name="vehicle_age"></div>
                        <div class="sec_div">年限</div>
                    </div>
                </div>

                <div class="row vehicle-info">
                    <div class="col-xs-6">
                        <span class="col-xs-5 col-xs-offset-1">设备类别:</span>
                        <span class="col-xs-6" name="model"></span>
                    </div>
                    <div class="col-xs-6 ">
                        <span class="col-xs-5 col-xs-offset-1">设备品牌:</span>
                        <span class="col-xs-6" name="brand"></span>
                    </div>
                    <div class="col-xs-6 ">
                        <span class="col-xs-5 col-xs-offset-1">联系人:</span>
                        <span class="col-xs-6" name="contact"></span>
                    </div>
                    <div class="col-xs-6 ">
                        <span class="col-xs-5 col-xs-offset-1">联系电话:</span>
                        <span class="col-xs-6" name="contact_phone"></span>
                    </div>
                    <div class="col-xs-12 ">
                        <span class="col-xs-10" style="margin-left: 20px">车主描述:</span>
                        <p class="col-xs-12" name="description" style="margin-left: 20px"></p>
                    </div>
                </div>
        </div>
        </div>
        <h4>
            <i class="deck"></i>
            车辆照片
        </h4>
        <div name="vehicle-imgs">
        </div>
</div>
    
</div>

<!--底部-->
<jsp:include page="base/footer.jsp"></jsp:include>
<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script src="js/utils.js"></script>
<script src="js/login.js" ></script>
<script >
    $(function(){
        var now=0;
        var sum=0;
        $(".dt-sumpic").hover(function () {
            $(".arrow-prew").show();
            $(".arrow-next").show();
         },function () {
            console.log($(".arrow-next").is(":focus"));
            $(".arrow-prew").hide();
            $(".arrow-next").hide();
        });
        $(".arrow-next").click(function(){
            $(".det-picside li:eq("+now+")").hide();
            now=(now+1)%sum;
            $(".fc-org").text(now+1);
            $(".det-picside li:eq("+now+")").show();
            console.log(now);
        });
        $(".arrow-prew").click(function(){
            $(".det-picside li:eq("+now+")").hide();
            now=(now+sum-1)%sum;
            $(".fc-org").text(now+1);
            $(".det-picside li:eq("+now+")").show();
            console.log(now);
        });
        init();

        //初始化数据
        function init(){
            var id = getQueryString("vehicleId");
            //基本信息加载
            $.ajax({
                type: "post",
                url: "/car/getCarInfo",
                data:{"id":id},
                success: function(data){
                    if (typeof data == "string") {
                        data = JSON.parse(data);
                    }
                    if(data.status==1000) {
                        $("span[name='title']").text(data.data.brand+data.data.equipmentNumber+data.data.model);
                        $("span[name='time']").text(data.data.releaseDate+"更新");
                        if(data.data.sell==1&&data.data.rent==1){
                            $("span[name='price']").text("售: ¥"+data.data.sellPrice+"万  租: ¥"+data.data.rentPrice+"元/天");
                        }
                        else if(data.data.sell==1&&data.data.rent==0){
                            $("span[name='price']").text("售: ¥"+data.data.sellPrice+"万");
                        }
                        else if(data.data.sell==0&&data.data.rent==1){
                            $("span[name='price']").text("租: ¥"+data.data.rentPrice+"元/天");
                        }
                        $("span[name='tonnage']").text(data.data.tonnage+"吨");
                        $("div[name='used_hours']").text(data.data.usedHours+"小时");
                        $("div[name='vehicle_age']").text(data.data.vehicleAge+"年");
                        $("span[name='model']").text(data.data.model);
                        $("span[name='brand']").text(data.data.brand);
                        $("span[name='contact']").text(data.data.contact);
                        $("span[name='contact_phone']").text(data.data.contactPhone);
                        $("p[name='description']").text(data.data.description);
                        $.ajax({
                            type: "post",
                            url: "/location/getLocation",
                            data:{"locationCode":data.data.locationCode},
                            success: function(data1){
                                if (typeof data1 == "string") {
                                    data1 = JSON.parse(data1);
                                }
                                if(data1.status==1000) {
                                    $("div[name='location']").text(data1.data.province+" "+data1.data.city+" "+data1.data.county);
                                }

                            },
                            error:function(error){
                                alert("connection error!");
                            }
                        });
                    }

                },
                error:function(error){
                    alert("connection error!");
                }
            });
            //图片加载
            $.ajax({
                type: "post",
                url: "/car/getPictures",
                data:{"id":id},
                success: function(data){
                    if (typeof data == "string") {
                        data = JSON.parse(data);
                    }
                    if(data.status==1000) {
                        var result = data.result;
                        sum=result.total;
                        $("span[name='total']").text(sum);
                        for(var i=0; i<result.total;i++){
                            if(result.data[i].isFirst==1){
                                var str='<li data-role="img" style="display: block;">'+
                                '<img src="'+result.data[i].url+'" alt="'+result.data[i].caption+'"></li>';
                                $('.det-picside').append(str);
                                str = '<div class="col-md-6">'+
                                        '<img width="100%" height="370px"  class="js-lazy-load" src="'+result.data[i].url+'" >'+
                                        '</div>';
                                $("div[name='vehicle-imgs']").append(str);
                            }
                        }
                        for(var i=0; i<result.total;i++){
                            if(result.data[i].isFirst==0){
                                var str='<li data-role="img" style="display: none;">'+
                                        '<img src="'+result.data[i].url+'" alt="'+result.data[i].caption+'"></li>';
                                $('.det-picside').append(str);
                                str = '<div class="col-md-6" style="margin-top:10px">'+
                                        '<img width="100%" height="370px"  class="js-lazy-load" src="'+result.data[i].url+'" >'+
                                        '</div>';
                                $("div[name='vehicle-imgs']").append(str);
                            }
                        }

                    }

                },
                error:function(error){
                    alert("connection error!");
                }
            });
        }

    });
</script>
</body>
</html>