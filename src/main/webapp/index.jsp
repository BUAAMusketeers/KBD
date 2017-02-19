<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>卡布达</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/cityselect.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/buyCar.css">
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>
<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-3 my-container">
            <h3><span class="glyphicon glyphicon-plane"></span>查询直通车</h3>
            <div class="fast-order-select row">
                <label>省份：</label>
                <select class="form-control" name="province" id="location_province" onchange="javascript:showMyCity('location', this.value)">
                    <option value="">请选择...</option>
                </select>
            </div>
            <div class="fast-order-select row">
                <label>城市：</label>
                <select class="form-control" name="city" id="location_city"><option value="">请选择...</option></select>
            </div>
            <div class="fast-order-select row">
                <label>机型：</label>
                <select class="form-control" name="model"><option value="">请选择...</option></select>
            </div>
            <div  class="fast-order-select row">
                <label>类别：</label>
                <select class="form-control" name="type">
                    <option value="0">买车</option>
                    <option value="1">租车</option>
                    <option value="2">找驾驶员</option>
                </select>
            </div>
            <button type="button" class="btn btn-success fast-order-btn" id="inquiry">快速查询</button>
        </div>

        <div class="col-md-6">
            <div id="carousel" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carousel" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel" data-slide-to="1"></li>
                    <li data-target="#carousel" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="item active"><img src="images/slide1.jpg"></div>
                    <div class="item"><img src="images/slide2.jpg"></div>
                    <div class="item"><img src="images/slide3.jpg"></div>
                </div>
                <a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>

        <div class="col-md-3 my-container" >
            <h3><span class="glyphicon glyphicon-bookmark"></span>系统概况</h3>
            <div class="info-con col-md-6">
                <h3 name="sum_num">333台</h3>
                <p>车辆总数</p>
            </div>
            <div class="info-con col-md-6">
                <h3 name="selling_num">333台</h3>
                <p>在售车辆</p>
            </div>
            <div class="info-con col-md-6">
                <h3 name="sold_num">333台</h3>
                <p>已售车辆</p>
            </div>
            <div class="info-con col-md-6">
                <h3 name="driver_num">333名</h3>
                <p>注册驾驶员</p>
            </div>
        </div>
    </div>
<div class="row">
    <h4>
        <i class="deck"></i>
        最新车辆
    </h4>
    <div class="list">
        <div class="row carList" id="carListBox">

        </div>
    </div>
    <h4>
        <i class="deck"></i>
        驾驶员推荐
    </h4>
    <div class="list">
    <div class="row carList" id="carListBox">
        <<div class="col-sm-6 col-md-3 listBox">
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
        </div>
</div>
    </div>

<!--底部-->
<jsp:include page="base/footer.jsp"></jsp:include>
<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script src="js/login.js"></script>
<script src="js/buyCar.js"></script>
<script>
    $(function(){
        var test=new Vcity.CitySelector({input:'citySelect'});
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
                            str="<option value="+result[i][j].id+">"+result[i][j].name+"</option>";
                            $("select[name='model']").append(str);
                        }
                    }
                }
            },
            error:function(error){
                alert("connection error!");
            }
        });
        initProvinceList();
        $.ajax({
            type: "POST",
            url:  "/car/getSellList",
            data: {city:"全国",brand:0,model:0,sort:0,limit:4, page:1},
            success:function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                if (data.status == 1000) {
                    $("#carListBox").empty();
                    if (data.result.total) {
                        var result = data.result.data;
                        var length = result.length;
                        for (var i = 0; i < length; i++) {
                            var str=''+
                                    '<div class="col-sm-6 col-md-3 listBox">' +
                                    '<div class="thumbnail">' +
                                    '<img src="'+result[i].pictureUrl+'" alt="picture">' +
                                    '<div class="infoDiv">' +
                                    '<p class="infoBox"><a href="vehicle_detail.jsp?vehicleId='+result[i].id+'">'+result[i].brand+result[i].model+'</a></p>' +
                                    '<p class="infoGray">' +
                                    '<span>'+result[i].vehicleAge+'年上牌</span>' +
                                    '<em class="verticalLine">|</em>' +
                                    '<span>使用'+result[i].usedHours+'小时</span>' +
                                    '<em class="verticalLine">|</em>' +
                                    '<span>'+result[i].tonnage+'吨</span>' +
                                    '</p>' +
                                    '<p class="infoPrice"> 价格：' +
                                    '<span>'+result[i].sellPrice+'万</span>' +
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
            error:function(error){
                alert("connection error!");
            }
        });
        $("#inquiry").click(function () {
            var city=$('select[name="city"] option:selected').text();
            var cityVal=$('select[name="city"] option:selected').val();
            var model = $('select[name="model"] option:selected').val();
            var type = $('select[name="type"] option:selected').val();
            if(type==0){
                if(cityVal=="")
                    window.location.href="buyCar.jsp?model="+model;
                else
                    window.location.href="buyCar.jsp?city="+city+"&model="+model;
            }else if(type==1){
                if(cityVal=="")
                    window.location.href="rentCar.jsp?model="+model;
                else
                    window.location.href="rentCar.jsp?city="+city+"&model="+model;
            }else{
                if(cityVal=="")
                    window.location.href="trailer.jsp?model="+model;
                else
                    window.location.href="trailer.jsp?city="+city+"&model="+model;
            }
        });
    });
</script>
</body>
</html>