/**
 * Created by JMY on 2017/1/14.
 */

$(function () {
    setTimeout(function(){
        $('#upload_btn').uploadify({
            'swf': baseUrl + '/res/lib/upload/uploadify/uploadify.swf',
            'uploader': imgBaseUrl+'/publish/upload2',//访问的服务器路径
            'fileObjName': 'upfile',
            'removeCompleted': true,
            'queueID': 'up_img_div',
            'queueSizeLimit': 100,
            'uploadLimit': 100,
            'buttonText': '本地图片上传',
            'buttonClass': 'up_btn',
            'fileTypeExts': '*.jpg;*.png;',
            'fileSizeLimit': '500MB',
            'formData': {'watermark': 0},
            'overrideEvents': ['onUploadError', 'onSelectError', 'onDialogClose'],
            'onUploadStart': function (file) {

                if ($('#watermark').is(":checked")) {
                    $('#upload_btn').uploadify('settings', 'formData', {'watermark': 1});
                } else {
                    $('#upload_btn').uploadify('settings', 'formData', {'watermark': 0});
                }
                $("#loading").show();
            },

            'onUploadSuccess': function (file, data, response) {
                if($("#imgUl").find("li").length>=22){
                    $("#imgUl").find("li").closest(".buyItem").find(".result").html('<i class="icon-forbid"></i>上传图片已达到20张，无法继续上传');
                    $("#loading").hide();
                    return false;
                }else{
                    var json = eval("(" + data + ")");
                    if (json.ret == 0) {
                        var path=json.result.path2;
                        var flag= '';
                        if(!$("#imgUl").find("li").find(".img").length){
                            flag =  '<li class="picList">'+
                                '<div class="img">'+
                                '<img src="'+path+'" deg="0" />'+
                                "<input type='hidden' id='imageIdIpt' value='" + json.result.path + "' name='image1' />" +
                                '</div>'+
                                '<div class="set first">'+
                                '<span class="on fl">首图</span>'+
                                /*'<span class="rotate fr">旋转</span>'+*/
                                '</div>'+
                                '<i class="btn-close"></i>'+
                                '</li>';
                        }else{
                            flag =  '<li class="picList">'+
                                '<div class="img">'+
                                '<img src="'+path+'" deg="0" />'+
                                "<input type='hidden' id='imageIdIpt'' value='" + json.result.path + "' name='image1' />" +
                                '</div>'+
                                '<div class="set">'+
                                '<span class="on fl">首图</span>'+
                                /*'<span class="rotate fr">旋转</span>'+*/
                                '</div>'+
                                '<i class="btn-close"></i>'+
                                '</li>';
                        }
                        $('#imgUl').append( flag );
                        $("#loading").hide();
                        $(".uploadedNum").html("您已上传"+($("#imgUl").find("li").length-2)+"个文件，还能上传"+(22-$("#imgUl").find("li").length)+"个文件。")
                        $("#imgUl").find("li").closest(".buyItem").find(".result").html('请上传jpg、png格式照片，最少5张最多20张');
                    }
                }
            },
            'onSelectError': function (file, errorCode, errorMsg) {
                if (errorCode == -110) {
                    jAlert('上传的图片超过5M，请压缩后上传',"失败");
                }
                else if (errorCode == -130) {
                    jAlert('请上传jpg、png格式的图片',"失败");
                }
                else if (errorCode = -100) {
                    jAlert('您最多只能上传20张图片',"失败");
                }else{
                    $('#error').show();
                }
            },

            'onComplete': function (event, queueID, fileObj, response, data) {

            },

            'onQueueComplete': function () {
                $('.photo_index2').each(function (i) {

                    $(this).html(i + 1);
                });
            },

            'onAllComplete': function (event, data) {
                jAlert(data.filesUploaded + ' files uploaded successfully!');
            }

        });
    },10);

});