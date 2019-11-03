<%@include file="../User/session.jsp" %>
<%@page import="poly.dto.JobIntrvReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	JobIntrvReviewDTO jirDTO = (JobIntrvReviewDTO)request.getAttribute("jirDTO");
%>
    
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
  <%@include file="../header.jsp" %>
<title>두루마리 - 면접후기 수정</title>
</head>
<body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">

    <%@include file="../menu.jsp" %>

<div class="app-content content container-fluid">
      <div class="content-wrapper">
        
        <div class="content-body">
        <div class="row">
    <div class="col-xs-12">
        <div class="card">
            
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    
                    <div class="table-responsive">
                    
                    <form action="/jobIntrvReview/jirModifyProc.do" method="POST">
                    	<input type="hidden" name="reviewNo" value="<%=jirDTO.getReviewNo() %>"/>
                    	<div>
                    	<h3><input type="text" name="reviewTitle" value="<%=jirDTO.getReviewTitle() %>"/></h3>
                    	<hr>
                    	<div>
                    		<p><textarea name="reviewContent" style="width: 100%; height: 500px"><%=jirDTO.getReviewContent() %></textarea></p>
                    	</div>
                    	<div>
                    		<input type="submit" value="수정" class="btn btn-primary" id="submitBtn"/>
                    	</div>
                    	</div>
                    </form>            
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