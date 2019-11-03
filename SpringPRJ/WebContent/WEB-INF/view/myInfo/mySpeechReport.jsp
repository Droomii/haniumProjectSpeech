<%@page import="poly.dto.ResultDTO"%>
<%@page import="java.util.List"%>
<%@include file="/WEB-INF/view/User/session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<ResultDTO> mySpeechList = (List<ResultDTO>) request.getAttribute("mySpeechList");%>
<% List<ResultDTO> speechMakers =(List<ResultDTO>) request.getAttribute("speechMakers");  %>
<% List<String> spcAnswerCounts =(List<String>) request.getAttribute("spcAnswerCounts");  %>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">


  <head>

    <title>두루마리</title>

	<%@include file="/WEB-INF/view/header.jsp" %>
 	<link rel="stylesheet" href="/resources/datatable/css/dataTables.bootstrap4.min.css">
  </head>
  <body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">

	<%@include file="/WEB-INF/view/menu.jsp" %>

    <!-- ////////////////////////////////////////////////////////////////////////////-->
	<div class="app-content content container-fluid">
		<div class="content-wrapper">
			<div class="content-body">
			<h2><%=session.getAttribute("id") %>님의  면접기록</h2>
				<table id="mySpeechRepoTable" style="width:100%" class="table table-bordred table-striped">
					<thead>
						<tr>
							<th>번호</th>
							<th>면접 질문</th>
							<th>면접관</th>
							<th>답변수</th>
						</tr>
					</thead>
					<tbody>
					<% for(int i = 0 ; i<mySpeechList.size();i++){ %>
					<tr>
							<td><%=i+1 %></td>
							<td><a href="/dataAn/viewChart.do?answerNo=<%=mySpeechList.get(i).getAnswerNo()%>&qsetNo=<%=mySpeechList.get(i).getQsetNo() %>" ><%=speechMakers.get(i).getQuestion() %></a></td>
							<td><%=speechMakers.get(i).getSpeechMakerName()%></td>
							<td><%=spcAnswerCounts.get(i) %></td>
						</tr>
					<%} %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/view/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="/resources/datatable/js/popper.min.js"></script>
    <script src="/resources/datatable/js/bootstrap.min.js"></script>
    <script src="/resources/datatable/js/jquery.dataTables.min.js"></script>
    <script src="/resources/datatable/js/dataTables.bootstrap4.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#mySpeechRepoTable').DataTable();
    } );
    </script>
  </body>
</html>