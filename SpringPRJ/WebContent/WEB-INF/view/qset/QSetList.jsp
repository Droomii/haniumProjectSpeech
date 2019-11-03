<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->

<%@ include file="../User/session.jsp" %>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>질문 세트 선택</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
          <div class="content-header-left col-md-6 col-xs-12">
            <h2 class="content-header-title">질문 세트 선택</h2>
          </div>
        </div>
        <div class="content-body"><!-- Basic example section start -->
<section>
	<div class="row" id="qSetList">
		<%@include file="QSetCard.jsp" %>
		<%if(qList.isEmpty()){ %>
			<div class="text-xs-center" id="noMore">
			- 질문이 없습니다 -
			<script>
			noMore = true;
			</script>
			</div>
		<%}%>
	</div>
</section>
<!-- Text alignment section end -->

        </div>
      </div>
    </div>

	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
	<script>
	var noMore = false;
	var pageNum = 0;
	$(window).scroll(function() {
	    if(($(window).scrollTop() == $(document).height() - $(window).height()) && !noMore) {
			// ajax call get data from server and append to the div
	        pageNum = pageNum + 10;;
	        var query = {page : pageNum};
	        $.ajax({
				url:"${pageContext.request.contextPath}/qset/QSetLoadMore.do",
				type:"post",
				data:query,
				success:function(data){
					console.log(data);
					$("#qSetList").append(data);
				},
				error: function(XMLHttpRequest, textStatus, errorThrown){
					alert('status:' + XMLHttpRequest.status + ', status text: ' +
						XMLHttpRequest.statusText);
				}
			});
	    }
	});
	</script>
</body>
</html>