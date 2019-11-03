<%@include file="../User/session.jsp" %>
<%@page import="java.util.List"%>
<%@page import="poly.dto.NotiDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<NotiDTO> nList = (List<NotiDTO>)request.getAttribute("nList");
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>


    <title>두루마리 - 공지사항</title>
	<%@ include file="../header.jsp" %>

  </head>
  <body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">


    <%@include file="../menu.jsp" %>

    <!-- / main menu-->

    <div class="app-content content container-fluid">
      <div class="content-wrapper">
          
        <div class="content-body"><!-- Basic Tables start -->
        <!-- 공지사항 화면 안뜨던것의 문제 -->
<div class="row">
    <div class="col-xs-12">
        <div class="card">
                        
              <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    
                    <div class="table-responsive">

                        <div class="jumbotron text-center">
							<h1><strong>공지사항 게시판</strong></h1>
							<p>공지사항을 올리는 게시판입니다.</p>
						</div>
							<div class="container">
								<div class="row">
								<!-- 질문 세트 카드 시작 -->
										<%for(NotiDTO nDTO : nList){ %>
										<div class="card">
											<div class="card-body">
												<div class="card-block">
													<h4 class="card-title info"><a href="/noti/notiDetail.do?seq=<%=nDTO.getSeq() %>"><%=nDTO.getTitle() %></a></h4>
													<p class="card-text"><a href="/noti/notiDetail.do?seq=<%=nDTO.getSeq() %>"><%=nDTO.getContent() %></a></p>
												</div>
											</div>
											<div class="card-footer border-top-blue-grey border-top-lighten-5 text-muted">
												<span class="float-xs-left"><i class="icon-eye6"></i><%=nDTO.getRegDate() %></span>
											</div>
										</div>
										<%} %>
									
								</div>
							</div>
						<div>
							<input type="button" onclick="location.href='/noti/notiRegOriginal.do'" value="글 작성" class="btn btn-primary" id="submitBtn"/>
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