/**
 * Created by jmy on 2017/1/19.
 */
//初始化机型列表下拉框
function initModelList() {
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
                            str='<option value="'+result[i][j].id+'">'+result[i][j].name+'</option>';
                            $("select[name='model']").append(str);
                    }
                }
                return true;
            }
        },
        error:function(error){
            alert("connection error!");
        }
    });
}
function initBrandList(){
    $.ajax({
        type: "post",
        url: "/car/getBrandList",
        success: function(data){
            if (typeof data == "string") {
                data = JSON.parse(data);
            }
            if(data.status==1000){
                var result = data.data;
                for (var i = 0; i < 26; i++) {
                    var str='';
                    for(var j=0;j<result[i].length;j++){
                        str='<option value="'+result[i][j].id+'">'+result[i][j].name+'</option>';
                        $("select[name='brand']").append(str);
                    }
                }
            }
            return true;
        },
        error:function(error){
            alert("connection error!");
        }
    });
}
