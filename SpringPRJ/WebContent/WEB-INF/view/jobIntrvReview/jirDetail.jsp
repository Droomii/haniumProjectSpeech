<%@ include file="../User/session.jsp" %>
<%@page import="poly.dto.JobIntrvReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	JobIntrvReviewDTO jirDTO = (JobIntrvReviewDTO)request.getAttribute("jirDTO");
	String reviewNo = jirDTO.getReviewNo();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>두루마리 - 면접후기 게시판</title>
<%@ include file="../header.jsp" %>
</head>
<body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">

	<%@ include file="../menu.jsp" %>
	
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
          <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h2 class="content-header-title">공지사항 게시판</h2>
          </div>

        </div>
        <div class="content-body">
        <div class="row">
    <div class="col-xs-12">
        <div class="card">
        
        <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    
                    <div class="table-responsive">
                    <form action="/jobIntrvReview/jirModify.do" method="post">
				<input type="hidden" name="reviewNo" value="<%=reviewNo %>" />
				<div>
        <h3><%=jirDTO.getReviewTitle() %></h3>
        <hr>
        <div>
            <p><%=jirDTO.getReviewContent() %></p>
        </div>
        <div>
        	<input type="submit" value="수정" class="btn btn-primary" id="submitBtn"/>
			<input type="button"  onclick="location.href='/jobIntrvReview/jirDelete.do?reviewNo=<%=jirDTO.getReviewNo() %>'" value="삭제" class="btn btn-primary" id="submitBtn"/>
			<input type="button" onclick="location.href='/jobIntrvReview/jirList.do'" value="돌아가기" class="btn btn-primary" id="submitBtn"/>
        </div>
    </div>
</form>

</div>
</div>
</div>
<div style="padding: 0 5%;">	<!-- <hr />-->
<%@include file="../jirComment.jsp" %>
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