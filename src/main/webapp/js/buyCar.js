/**
 * Created by skyxi on 2017/2/17.
 */
$("#searchCarBtn").click(function () {
    var keywords=$("#cityInput").val();
    var city=$("#citySelect").val();
    window.location.href="buyCar.jsp?city="+city+"&keywords="+keywords;
});