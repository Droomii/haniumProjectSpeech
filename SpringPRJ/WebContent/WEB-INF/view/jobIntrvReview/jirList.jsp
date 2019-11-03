<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../User/session.jsp" %>
<%@page import="java.util.List"%>
<%@page import="poly.dto.JobIntrvReviewDTO"%>
<%
	List<JobIntrvReviewDTO> jirList = (List<JobIntrvReviewDTO>)request.getAttribute("jirList"); 	
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
          
        <div class="content-body">
        <div class="row">
    <div class="col-xs-12">
        <div class="card">
                        
              <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    
                    <div class="table-responsive">

                        <div class="jumbotron text-center">
							<h1><strong>면접후기 게시판</strong></h1>
							</div>
							<div class="container">
								<div class="row">
								<!-- 면접후기목록 시작 -->
										<%for(JobIntrvReviewDTO jirDTO : jirList){ %>
										<div class="card">
											<div class="card-body">
												<div class="card-block">
													<h4 class="card-title info"><a href="/jobIntrvReview/jirDetail.do?reviewNo=<%=jirDTO.getReviewNo() %>"><%=jirDTO.getReviewTitle() %></a></h4>
													<p class="card-text"><a href="/jobIntrvReview/jirDetail.do?reviewNo=<%=jirDTO.getReviewNo() %>"><%=jirDTO.getReviewContent() %></a></p>
												</div>
											</div>
											<div class="card-footer border-top-blue-grey border-top-lighten-5 text-muted">
												<span class="float-xs-left"><i class="icon-eye6"></i><%=jirDTO.getReviewRegDate() %></span>
											</div>
										</div>
										<%} %>
									
								</div>
							</div>
							<div>
								<input type="button" onclick="location.href='/jobIntrvReview/jirReg.do'" value="글 작성" class="btn btn-primary" id="submitBtn"/>
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
        
        <%@include file="../footer.jsp" %>
        
</body>
</html>