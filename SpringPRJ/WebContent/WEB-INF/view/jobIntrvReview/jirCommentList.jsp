<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil" %>
<%@page import="poly.dto.JirCommentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<JirCommentDTO> jcDTOs = (List<JirCommentDTO>)(request.getAttribute("jcDTO"));
	String userNo = CmmUtil.nvl((String)session.getAttribute("userNo"));

//테스트용으로 해둠. 나중에 지워야함.
	if(userNo.isEmpty()){
	userNo = "1";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<p style="text-align:center; margin: 2% 0;">current user : <%=userNo %></p>
	<% 	for(JirCommentDTO jcDTO : jcDTOs) {%>
			<div id=<%=jcDTO.getrCommentNo() %> class="card card-body card-block" style="min-width: 40%; max-width: 80%;
						margin:1% auto;
						">
				<span style="padding:0 1px; display:none;"><%=jcDTO.getrCommentNo() %></span>
				<span style="padding:0 1px;"><%=jcDTO.getrRegno() %></span>
				<span style="padding:0 1px;"><%=jcDTO.getrRegdate() %></span>
				<div id="commentContent<%=jcDTO.getrCommentNo() %>" style="min-height: 64px; padding: 6px 14px;"><%=jcDTO.getrCommenttext() %></div>
				<%if(jcDTO.getrRegno().equals(userNo)){ %>
					<button type="button" id="commentedit" class="btn btn-primary" onclick="jirCommentEdit('<%=jcDTO.getrCommentNo()%>')">수정</button>
					<button type="button" id="commentdel" class="btn btn-primary" onclick="jirCommentDel('<%=jcDTO.getrCommentNo()%>')">삭제</button>
				<%}%>
			</div>
		<%} %>
</body>
</html>