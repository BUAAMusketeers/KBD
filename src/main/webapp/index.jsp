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
    <link href="images/favicon.ico" rel="shortcut icon" />
</head>

<body>



<!--顶部-->
<jsp:include page="base/head.jsp"></jsp:include>

<!--底部-->
<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/cityselect.js"></script>
<script src="js/utils.js"></script>
<script src="js/login.js"></script>
<script >
    var test=new Vcity.CitySelector({input:'citySelect'});
</script>
</body>
</html>