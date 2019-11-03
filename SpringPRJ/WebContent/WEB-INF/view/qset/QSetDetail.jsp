<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../User/session.jsp"%>
<%@page import="poly.dto.QSetDTO"%>
<%
	QSetDTO qDTO = (QSetDTO) request.getAttribute("qDTO");
	String interestName = (String)request.getAttribute("interestName");
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>질문 상세 보기</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp"%>
</head>
<body data-open="click" data-menu="vertical-menu" data-col="2-columns"
	class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp"%>
	<div class="app-content content container-fluid">
		<div class="content-wrapper">
			<div class="content-header row">
				<div class="content-header-left col-md-6 col-xs-12">
					<h2 class="content-header-title">질문 세트 선택</h2>
				</div>
			</div>
			<div class="content-body">
				<!-- Basic example section start -->
				<section>
					<div class="row" id="qSet">
						<div class="col-lg-12 col-md-12 col-sm-12">
							<div class="card">
								<div class="card-body">
									<div class="card-block">
										<h3 class="card-title info indigo"><%=qDTO.getQsetTitle()%></h3>
										<p class="card-text"><%=qDTO.getQsetDesc()%></p>
										<p class="card-text">작성자: <%=qDTO.getRegId()%></p>
										<p class="card-text">질문분야: <%=interestName.equals("") ? "미분류" : interestName%></p>
										
									</div>
								</div>
								<div
									class="card-footer border-top-blue-grey border-top-lighten-5 text-muted">
									<span class="float-xs-left"><i class="icon-eye6"></i><%=qDTO.getViewcount()%></span>
									<span class="col-xs-2"><i class="icon-heart"></i><%=qDTO.getLikes()%></span>
									<a href="/interview/Ready.do?no=<%=qDTO.getQsetNo() %>" class="btn btn-danger float-xs-right">모의면접 진행</a>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>



	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp"%>
</body>
</html>