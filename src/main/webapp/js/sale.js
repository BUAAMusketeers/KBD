/**
 * Created by Administrator on 2017/1/14.
 */
$(function(){
    first.init();
    rotate.init();
    close.init();
});

var rotate = {
    init : function(){
        //图片旋转
        $(document).on("click",".buyItem .machineList li .rotate",function(){
            var img = $(this).closest("li").find(".img img");
            var deg = img.attr("deg") * 1 + 90;
            img.attr("deg",deg).rotate(deg);
        })
    }
}
var first = {
    init : function(){
        //设为首图
        $(document).on("click",".buyItem .machineList li .on",function(){
            var parentUl = $(this).closest("ul");
            parentUl.find(".on").show();
            $(this).hide().closest("li").prependTo(parentUl);
        });
    }
}
var close = {
    //删除已上传的图片
    init : function(){
        /*  $(document).on("click",".buyItem .machineList li .btn-close",function(){
         $(this).closest("li").remove();
         })*/

        $(document).on("click",".buyItem .machineList .picList .btn-close",function(){
            $(this).closest("li").remove();
            $(".uploadedNum").html("您已上传"+($("#imgUl").find("li").length-2)+"个文件，还能上传"+(22-$("#imgUl").find("li").length)+"个文件。")
        })
    }
}














