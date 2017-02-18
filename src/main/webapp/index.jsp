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
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>
<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-3 my-container" id="quick">
            <h3><span class="glyphicon glyphicon-plane"></span>快速预约</h3>
            <div id="qprovince" class="fast-order-select row">
                <label>省份：</label>
                <select class="form-control">
                    <option value="">请选择...</option>
                </select>
            </div>
            <div id="qcity" class="fast-order-select row">
                <label>城市：</label>
                <select class="form-control"><option value="">请选择...</option></select>
            </div>
            <div id="qhospital" class="fast-order-select row">
                <label>医院：</label>
                <select class="form-control"><option value="">请选择...</option></select>
            </div>
            <div id="qdepartment" class="fast-order-select row">
                <label>科室：</label>
                <select class="form-control" id="department_id"><option value="">请选择...</option></select>
            </div>
            <button type="button" class="btn btn-success fast-order-btn" >预约挂号</button>
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

        <div class="col-md-3 my-container" id="quick">
            <h3><span class="glyphicon glyphicon-plane"></span>快速找车</h3>
            <div id="province" class="fast-order-select row">
                <label>省份：</label>
                <select class="form-control">
                    <option value="">请选择...</option>
                </select>
            </div>
            <div id="city" class="fast-order-select row">
                <label>城市：</label>
                <select class="form-control"><option value="">请选择...</option></select>
            </div>
            <div id="qhospital" class="fast-order-select row">
                <label>医院：</label>
                <select class="form-control"><option value="">请选择...</option></select>
            </div>
            <div id="qdepartment" class="fast-order-select row">
                <label>科室：</label>
                <select class="form-control" id="department_id"><option value="">请选择...</option></select>
            </div>
            <button type="button" class="btn btn-success fast-order-btn" >预约挂号</button>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="info-con col-md-3">
            <span class="glyphicon glyphicon-plane"></span>
            <h4>333台</h4>
            <p>车辆总数</p>
        </div>
        <div class="info-con col-md-3">
            <span class="glyphicon glyphicon-plane"></span>
            <h4>333台</h4>
            <p>在售车辆</p>
        </div>
        <div class="info-con col-md-3">
            <span class="glyphicon glyphicon-plane"></span>
            <h4>333台</h4>
            <p>已售车辆</p>
        </div>
        <div class="info-con col-md-3">
            <span class="glyphicon glyphicon-plane"></span>
            <h4>333名</h4>
            <p>注册驾驶员</p>
        </div>
    </div>
</div>

<!--底部-->
<jsp:include page="base/footer.jsp"></jsp:include>
<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript" src="js/buyCar.js"></script>
<script src="js/login.js"></script>
<script >
    var test=new Vcity.CitySelector({input:'citySelect'});
</script>
</body>
</html>