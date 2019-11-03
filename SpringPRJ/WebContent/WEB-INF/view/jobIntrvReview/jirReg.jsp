<%@include file="../User/session.jsp" %>
<%@page import="poly.dto.JobIntrvReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>두루마리 - 면접후기 등록</title>
<%@include file="../header.jsp" %>
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
                    
                    <form action="/jobIntrvReview/jirRegProc.do" method="POST">
                    	<input type="hidden" name="reviewNo" />
                    	<div>
                    	<h3><input type="text" name="reviewTitle" placeholder="제목"/></h3>
                    	<hr>
                    	<div>
                    		<p><textarea name="reviewContent" style="width: 100%; height: 500px" placeholder="면접 후기를 남겨주세요!"></textarea>
                    	</div>
                    	<div>
                    		<input type="submit" value="등록" class="btn btn-primary" id="submitBtn"/>
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