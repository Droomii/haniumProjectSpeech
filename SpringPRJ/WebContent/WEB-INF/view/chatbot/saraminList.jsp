<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%HashMap<String,Object> hMap = (HashMap<String,Object>)request.getAttribute("hMap"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사람인 리스트</title>
</head>
<body>
 <%@include file="/WEB-INF/view/footer.jsp" %>
   <script>
   
   console.log('<%=hMap%>');
   </script>
</body>
</html>