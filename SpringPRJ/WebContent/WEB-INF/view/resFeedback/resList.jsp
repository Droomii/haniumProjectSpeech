<%@page import="poly.dto.ResFeedbackDTO" %>
<%@page import="java.util.List" %>
<%@ include file="../User/session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	List<ResFeedbackDTO> rList = (List<ResFeedbackDTO>)request.getAttribute("rList");
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>
  
<title>두루마리 - 이용자피드백 게시판</title>
 <%@include file="../header.jsp" %>

</head>
  <body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">

	<%@include file="../menu.jsp" %>
       
    <div class="app-content content container-fluid">
      <div class="content-wrapper">
        
                <div class="content-body"><!-- Basic Tables start -->
<div class="row">
    <div class="col-xs-12">
        <div class="card">
        	<div class="card-body collapase in">
        		<div class="card-block card-dashboard">

					<div class="table-responsive">

           <div class="jumbotron text-center"><h1><strong>모의면접결과 피드백하기</strong></h1></div>
           
           <div class="container">
				<div class="row">
            <!-- 이용자가 공유한 녹음결과물 리스트 출력 시작 -->    
 			
				<%for(ResFeedbackDTO rDTO : rList) {%>
			<div class="card">
				<div class="card-body">
					<div class="card-block">
				<h4 class="card-title info"><a href="/resFeedback/resDetailFeedback.do?feedbackno=<%=rDTO.getFeedback_no() %>"><%=rDTO.getF_title() %></a></h4>
					</div>
					</div>
				<div class="card-footer border-top-blue-gray border-top-lighten-5 text-muted">
					<span class="float-xs-left"><i class="icon-eye6"></i><%=rDTO.getRegdate() %></span>
				</div>
				</div>
			<%} %>
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
					</div>

<!-- ////////////////////////////////////////////////////////////////////////////-->

<%@include file="../footer.jsp" %>

</body>
</html>