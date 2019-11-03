<%@ include file="../User/session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>두루마리 - 채용공고 게시판</title>
 <%@include file="../header.jsp" %>
</head>
 <body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">

	<%@include file="../menu.jsp" %>
	
	 <div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
          <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h2 class="content-header-title">채용공고 게시판</h2>
          </div>
        </div>
        
        </div>
        </div>
	
	<!-- 요청 URI에 API 발급키 붙이고 .... 데이터 받아와서 화면에 띄워야행 -->
	
	<%@include file="../footer.jsp" %>
</body>
</html>