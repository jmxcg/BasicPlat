<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.gmteam.framework.IConstants"%>
<%
  String path = request.getContextPath();
  String username = (String)session.getAttribute(IConstants.USER_NAME);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/sysInclude.jsp" flush="true"/>
<script src="<%=path%>/test/DIS_jsonData/subApp_data.json" type="text/javascript"></script>
<title><%=IConstants.PLATFORM_NAME%></title>
</head>
<style type="text/css">
#top {
  height:105px;
  overflow:hidden;
  background:url('<%=path%>/resources/images/sys/skin0/banner/top_b.jpg') repeat-x fixed #E6EEF8;
}
#top_top {
  height:77px;
  width:996px;
  background:url('<%=path%>/resources/images/sys/skin0/banner/top.jpg') no-repeat fixed;
}
#top_under {
  position:absolute;
  top:76px;
  height:26px;
  width:100%;
  background:url('<%=path%>/resources/images/sys/skin0/banner/under1_b.jpg') repeat;
}
#mainBar {
  top:76px;
  height:26px;
  width:996px;
  background:url('<%=path%>/resources/images/sys/skin0/banner/under1.jpg') repeat;
}
#foot {
  height:30px;
  background:#E6EEF8;
  background-image:url('<%=path%>/resources/images/sys/skin0/banner/menu1.jpg');
  background-repeat:repeat-x;
  background-position:bottom;
  background-origin:content-box;
}
#user span { display:inline-block; width:150px; margin-left:20px; margin-right:40px; line-height:26px; color:#fff; }
#user a.mainMenu { margin-left:10px; }
#switcherBtn { width:15px; height:15px; display:block; cursor:pointer; }
#logout {position:relative; float:right; margin-top:-22px; margin-right:10px;}
#logout img {float:left; margin:5px;}
#logout li a {margin-left:3px; vertical-align:bottom; display:inline-block;}
body {margin:0 auto; width:1000px;}
</style>
<body>
<!-- 遮罩层 -->
<div id="mask" style="display:none">
  <table id="maskContent" style="position:relative;"><tr><td style="vertical-align:middle;align:center"><center>
    <img align="middle" src="<%=path%>/test1/images/waiting_circle.gif"/><br/><br/>
    <span style="font-weight:bold" id="maskTitle">请稍候，正在读取用户权限...</span>
  </center></td></tr></table>
</div>
<center>
<div class="easyui-layout" style="width:1000px;height:500px" data-options="border:false">
  <div id="top" data-options="region:'north',border:false" style="width:1000px">
    <div id="top_top"></div>
    <div id="top_under">
      <div id="mainBar"><div id="user"> <span>欢迎您，<%=username%>!</span> </div></div>
      <div id="logout"><img src="<%=path%>/resources/images/sys/skin0/icon/logout.gif"/><a href="#" onclick="dologout()">注销</a></div>
    </div>
  </div>
  <div id="foot" data-options="region:'south',border:false" style="width:1000px"></div>
  <div data-options="region:'center'" style="width:1000px">
  </div>
</div>
</center></body>
<script>
var setTimeoutHandle = null;
var westWidth=300, minWidth=640, minHeight=480;
var westExpand=true, isFullScreen=false, _westExpand=true;//_westExpand是点击全屏时westExpand的状态
var userAuthData=null;
var curTab=null, curModule=null, curMframe=null;
var hasRefreshCacheAuth = false;
var moduleArray=[];//模块列表
var currentUrl = null, currentId = null;
$(function() {
	//调用遮罩
	resizeMask();
	_resizeTimeout();
	$(window).resize(_resizeTimeout);
	$("#mask").show();
  //获取树
  var url="<%=path%>/toLogin.do";
  $.ajax({type:"post", async:true, url:url, data:null, dataType:"json",
    success: function(json) {
      if (json.type==1) {
        var authData=json.data;
        if (!authData) {
          $.messager.alert("提示", "您没有操作本系统的任何权限，请联系管理员！<br/>现返回登录页面。", "info", function(){
            window.location.href="<%=path%>/common/login.jsp?noAuth";
          });
          return;
        }
        userAuthData = authData;
        init(authData);
      } else {
        $.messager.alert("错误", "获取用户权限失败："+json.data+"！<br/>返回登录页面。", "error", function(){
          window.location.href="<%=path%>/common/login.jsp?noAuth";
        });
      }
    },
    error: function(errorData) {
      $.messager.alert("错误", "获取用户权限异常："+(errorData?errorData.responseText:"")+"！<br/>返回登录页面。", "error", function(){
        window.location.href="<%=path%>/common/login.jsp?noAuth";
      });
    }
  });
  /*$(subApps.susApps).each(function() {
    $("#user").html($("#user").html()
      +"<a href='javascript:void(0);' onclick='turnSubApp(\""+this.id+"\",\""+this.url+"\")' class='mainMenu' id='"+this.id+"'>"+this.title+"</a></div>");
    if (this.selected) {currentUrl=this.url;currentId=this.id;}
  });*/
  $("div[data-options='region:\'center\'']").css("background", "#E6EEF8")
    .css("border-top", "1px solid #E6EEF8")
    .css("border-right", "0px solid #E6EEF8")
    .css("border-bottom", "0px solid #E6EEF8")
    .css("border-left", "5px solid #E6EEF8");
  $("div[data-options='region:\'center\'']").css("overflow", "hidden");
  turnSubApp(currentId, currentUrl);
  $(window).resize(onResize);
});
//调整遮罩层大小
function resizeMask() {
  $("#mask").css({
    "top": "0px",
    "left": "0px",
    "width": $(window).width(),
    "height": $(window).height()
  });
  $("#maskContent").css({
    "top": ($(window).height()-$("#maskContent").height())/2,
    "left": ($(window).width()-$("#maskContent").width())/2
  });
}
function _resizeTimeout() {
	  setTimeout("onResizeWin()",200);
	  setTimeout("onResizeWin()",400);
}
function turnSubApp(id, url) {
  currentUrl = url; currentId = id;
  var ifs = $("div[data-options='region:\'center\'']").find("iframe");
  var hasFind = false;
  $(ifs).each(function() {
    if ($(this).attr("id")==currentId) {
      $(this).css("display", "inline");
      hasFind = true;
    } else {
      $(this).css("display", "none");
    }
  });
  if (!hasFind) {
    var newIframe = window.document.createElement("iframe");
    $(newIframe).css("display", "inline")
      .attr("frameborder", "0").attr("scrolling", "no").attr("id", ""+id).attr("src", "<%=path%>"+url);
    $("div[data-options='region:\'center\'']").append($(newIframe));
  }
  onResize();
}
function onResize() {
  var _height = $(window).height()-$("#top").height()-$("#foot").height();
  $(".easyui-layout").css("height",$(window).height()+"px");
  $("div[data-options='region:\'center\'']").css("height", _height);
  $("#foot").parent().css("top", _height+$("#top").height());
  $("iframe").each(function(){
    if ($(this).attr("id")==currentId) {
      $(this).css({
        height: _height-2,
        width: "998px"
      });
    }
  });
}
</script>
</html>