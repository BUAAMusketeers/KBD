var hotBrand=["","小松","卡特彼勒","日立","神钢","斗山","三一重工","沃尔沃","加藤"];
var hotType=["","挖掘机","装载机","推土机","汽车起重机","破碎锤","混凝土泵车"];
var letter=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
var context="localhost:8088"
//截取URL参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURIComponent(r[2]); return null;
 }


function convertTime(nS) {
    return new Date(parseInt(nS) ).format("yyyy-MM-dd hh:mm");
}

//扩展Date的format方法   
Date.prototype.format = function (format) {  
    var o = {  
        "M+": this.getMonth() + 1,  
        "d+": this.getDate(),  
        "h+": this.getHours(),  
        "m+": this.getMinutes(),  
        "s+": this.getSeconds(),  
        "q+": Math.floor((this.getMonth() + 3) / 3),  
        "S": this.getMilliseconds()  
    };  
    if (/(y+)/.test(format)) {  
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    }  
    for (var k in o) {  
        if (new RegExp("(" + k + ")").test(format)) {  
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
        }  
    }  
    return format;  
};

 /**   
    *转换long值为日期字符串   
    * @param l long值   
    * @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss   
    * @return 符合要求的日期字符串   
    */    
  
    function getFormatDateByLong(l, pattern) {  
        return getFormatDate(new Date(l), pattern);  
    }  
    /**   
    *转换日期对象为日期字符串   
    * @param l long值   
    * @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss   
    * @return 符合要求的日期字符串   
    */    
    function getFormatDate(date, pattern) {  
        if (date == undefined) {  
            date = new Date();  
        }  
        if (pattern == undefined) {  
            pattern = "yyyy-MM-dd hh:mm:ss";  
        }  
        return date.format(pattern);  
    }  
   
    
Date.prototype.diff = function(date){
	  return (this.getTime() - date.getTime())/(24 * 60 * 60 * 1000);
	};

//计算字符串长度
	String.prototype.strLen = function() {  
		  var len = 0;  
		  for (var i=0; i<this.length; i++) {  
		    if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {  
		       len += 2;  
		     } else {  
		       len ++;  
		     }  
		   }  
		  return len;  
		};
		
/**
* 顶部弹出框
* @param word 显示内容
* @param type success为绿色成功框
*             welcome为蓝色欢迎框
*             error为红色警告框
* @param time 显示时间，默认值为2000
*/
function topAlert(word,type,time) {
	var oldBox = document.getElementsByClassName('alert-box')[0],
	   box = document.createElement('div'),
	   icon = {
	       'success': '<i class="fa fa-check"></i>',
	       'welcome': '<i class="fa fa-leaf"></i>',
	       'error':   '<i class="fa fa-exclamation-triangle"></i>'
	   };
	if(oldBox){
	   oldBox.remove();
	}
	box.className = 'alert-box animated fadeInDownBig alert-' + type;
	box.innerHTML = icon[type] + word;
	document.body.appendChild(box);
	setTimeout(function(){
	   box.className = 'alert-box animated fadeOutUpBig alert-' + type;
	   box.addEventListener('animationend',function() {
	       box.remove();
	   });
	},time || 2000);
}

/**
 * 根据 locationCode 选择省份下拉框
 * 注：使用本方法的前提为省份、城市、区县下拉框的id前缀相同，且后缀分别为"_province"、"_city"、"_county"。
 * 例：省份、城市、区县下拉框的id分别为"location_province"、"location_city"、"location_county"
 * @param idPrefix 下拉框的id前缀，例：若省份下拉框的id为location_province, idPrefix为'location'
 * @param locationCode 地区代码
 */
function showMyProvince(idPrefix, locationCode) {
    var provinceCode = locationCode.substring(0, 2);
    $("#" + idPrefix + "_province").val(provinceCode + '0000');

    if (provinceCode == "11" || provinceCode == "12" || provinceCode == "31" || provinceCode == "50") {
        // 如果是直辖市，且城市代码为空，则自动选择该城市
        if (locationCode.substring(2, 4) == '00')
            locationCode = provinceCode + '01' + locationCode.substring(4, 6);
    }
    showMyCity(idPrefix, locationCode);
}

/**
 * 根据选择的省份初始化城市下拉框，并根据 locationCode 选择城市下拉框
 * @param idPrefix 下拉框的id前缀，例：若城市下拉框的id为location_city, idPrefix为'location'
 * @param locationCode 地区代码
 */
function showMyCity(idPrefix, locationCode) {
    var $citySelect = $("#" + idPrefix + "_city");
    if (locationCode != '' && locationCode != '0') {
        var $seletedProvince=$("#location_province option:selected").text();
        $.ajax({
            type : "post",
            url : "/location/getCityList",
            data : {
                "province" : $seletedProvince
            },
            success : function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                $citySelect.find("option").not(":first").remove();
                var result = data.result;
                if (result == null) {
                    $citySelect.append($("<option>").text($("#" + idPrefix + "_province option:selected").text()).val(locationCode));
                    $citySelect.val(locationCode);
                    showMyCounty(idPrefix, locationCode);
                    return;
                } else
                    for (var i = 0; i < result.total; i++) {
                        $citySelect.append($("<option>").text(result.data[i].city).val(result.data[i].locationCode));// 向清空的列表中增加新值
                    }
                // 若locationCode精确到城市或区县级别，自动选择城市下拉框，并初始化区县下拉框
                var provinceCode = locationCode.substring(0, 2);
                if (locationCode.substring(2, 4) != '00') {
                    // 如果是直辖市，城市下拉框选择直辖市（代码为provinceCode+'01'的城市）
                    // 此处因为直辖市的区县代码分为'XX01YY'和'XX02YY'两种，但是城市下拉框中只有'XX0100'的选项
                    if (provinceCode == "11" || provinceCode == "12" || provinceCode == "31" || provinceCode == "50") {
                        $citySelect.val(locationCode.substring(0, 2) + '0100');
                    } else {
                        $citySelect.val(locationCode.substring(0, 4) + '00');
                    }
                    showMyCounty(idPrefix, locationCode);
                } else {
                    // 如果选择的省份是市辖区，自动选择城市下拉框，并填充区县下拉框
                    if (provinceCode == "11" || provinceCode == "12" || provinceCode == "31" || provinceCode == "50") {
                        $citySelect.val(locationCode.substring(0, 2) + '0100')
                        showMyCounty(idPrefix, locationCode.substring(0, 2) + '01' + locationCode.substring(4, 6));
                    } else
                        $("#" + idPrefix + "_county").find("option").not(":first").remove();
                }
            }

        });
    } else {
        $citySelect.find("option").not(":first").remove();
        $("#" + idPrefix + "_county").find("option").not(":first").remove();
    }
}

/**
 * 根据选择的省份和城市初始化区县下拉框，并根据 locationCode 选择城市下拉框
 * @param idPrefix 下拉框的id前缀，例：若区县下拉框的id为location_county, idPrefix为'location'
 * @param locationCode 地区代码
 */
function showMyCounty(idPrefix, locationCode) {
    var $countySelect = $("#" + idPrefix + "_county");
    if (locationCode != '' && locationCode != '0') {
        var $seletedCity=$("#location_city option:selected").text();
        $.ajax({
            type : "post",
            url : "/location/getCountyList",
            data : {
                "city" : $seletedCity
            },
            success : function(data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                $countySelect.find("option").not(":first").remove();
                var result = data.result;
                if (result == null){
                    $countySelect.append($("<option>").text($("#" + idPrefix + "_city option:selected").text()).val(locationCode));
                }
                else{
                    for (var i = 0; i < data.length; i++) {
                        $countySelect.append($("<option>").text(result.data[i].county).val(result.data[i].locationCode));// 向清空的列表中增加新值
                    }
                    $countySelect.val(locationCode);
                }
            }

        });
    } else {
        $countySelect.find("option").not(":first").remove();
    }
}

function initProvinceList(){
    //初始化省份列表
    $.ajax({
        type: "post",
        url: "/location/getProvinceList ",
        success: function(data){
            if (typeof data == "string") {
                data = JSON.parse(data);
            }
            if(data.status==1000){
                var result = data.result;
                for (var i = 0; i < result.total; i++) {
                    var str="<option value='"+result.data[i].locationCode+"'>"+result.data[i].province+"</option>";
                    $("#location_province").append(str);
                }
            }
            return true;
        },
        error:function(error){
            alert("connection error!");
        }
    });
}