<%@page import="poly.dto.NotiDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	NotiDTO nDTO = (NotiDTO)request.getAttribute("nDTO");
%>
<%@ include file="../User/session.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../header.jsp" %>
<style>
	.table-responsive{
		padding:5%;
	}
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
<%@ include file="../menu.jsp" %>

<div class="margin">
<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-body"><!-- Basic Tables start -->
        <!-- 공지사항 화면 안뜨던것의 문제 -->
<div class="row">
    <div class="col-xs-12">
        <div class="card">
            
              <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    
                    <div class="table-responsive">
                        <textarea class="editor" name="ir1" id="ir1"rows='10' style='width:100%; min-width:260px; height:30em; display:none;'></textarea>
						<input type="button" onclick="location.href='/noti/notiList.do'" value="저장" />
                    </div>
                </div>
                </div>
            </div>
            </div>
            </div>
          
          </div>
          </div>
          
          </div>
          </div>

<%@ include file="../footer.jsp" %>

</body>
<script>
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "ir1",
		sSkinURI: "<%=request.getContextPath() %>/smarteditor/SmartEditor2Skin.html ",
		fCreator: "createSEditor2"
	});
</script>
<script>
	window.onload = function(){
		var btn = document.getElementById("writebtn");
		btn.onclick = function(){
			submitContents(btn);
		}
	}
	function submitContents(elClickedObj){
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		
	try{
		elClickedObj.form.submit();
	} catch(e){
		
	}
	}
</script>
</html>