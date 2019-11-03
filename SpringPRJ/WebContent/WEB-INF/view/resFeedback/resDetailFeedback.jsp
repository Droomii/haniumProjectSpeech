<%@ include file="../User/session.jsp" %>
<%@page import="poly.dto.ResFeedbackDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ResFeedbackDTO rDTO = (ResFeedbackDTO)request.getAttribute("rDTO");
	String feedback_no = rDTO.getFeedback_no();
%>

<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>
	<%@include file="../header.jsp" %>
	<title>두루마리 - 이용자피드백 게시판</title>
</head>
  <body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">

   <%@include file="../menu.jsp" %>
    
    <div class="app-content content container-fluid">
      <div class="content-wrapper">
	<div class="content-body" >
	<div class="row">
    <div class="col-xs-12">
        <div class="card">
      <div class="card-body collapse in" style="text-align:center;">
       <div class="card-block card-dashboard">
		<input type="hidden" name="feedback_no" value="<%=feedback_no %>">
		<div style="margin-top: 2%;">
			<div>
				<h3><%=rDTO.getF_title() %></h3>
			</div>
		</div>
		<hr>
		<div style="margin-top: 2%; margin-bottom: 4%">
			<%=rDTO.getContent() %>
		</div>
	
		<!-- 해당 모의면접 질문리스트들, 그리고 클릭시 재생할 녹음파일들-->
		<!-- 평가 남기기 -->
	</div>
	</div>
<div style="padding: 0 5%;">	<!-- <hr />-->
<%@ include file="../feedbackComment.jsp" %>
</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
 <!-- ////////////////////////////////////////////////////////////////////////////-->

    <%@include file="../footer.jsp" %>
    
</body>
</html>