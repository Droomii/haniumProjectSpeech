<%@include file="../User/session.jsp" %>
<%@page import="java.util.List"%>
<%@page import="poly.dto.NotiDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>
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
            
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    
                    <div class="table-responsive">
           <form action="/noti/notiRegProc.do" method="post">
				<input type="hidden" name="seq" />
				<div>
        <h3><input type="text" name="title" placeholder="제목"/></h3>
        <hr>
        <div>
            <p><textarea name="contents" style="width: 100%; height: 500px" placeholder="내용"></textarea></p>
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