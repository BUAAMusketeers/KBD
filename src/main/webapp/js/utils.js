var hotBrand=["","小松","卡特彼勒","日立","神钢","斗山","三一重工","沃尔沃","加藤"];
var hotType=["","挖掘机","装载机","推土机","汽车起重机","破碎锤","混凝土泵车"];
var letter=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
var context="localhost:8080"
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