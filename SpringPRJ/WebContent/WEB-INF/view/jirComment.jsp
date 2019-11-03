<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
	<div style="width: auto; text-align:center; ">
	  
		<textarea rows="5" cols="80" id="commenttext" class="form-control"
		placeholder="댓글을 남겨주세요!"></textarea>
		<br>
		<button type="button" id="commentreg" class="btn btn-primary">댓글쓰기</button>
	
	</div>
	<div id="jirCommentlist"></div>
	
</body>	
<script>
	const selector = {
			commentText:$('#commenttext'),
			commentReg:$('#commentreg'),		
			commentList:$('#jirCommentlist'),
			},
			
		confirming = {
				reg: function(){
					alert('후기를 남겼습니다!');
				},
				
				edit: function(){
					alert('후기를 수정했습니다.');
				},
				del: function(){
					alert('후기를 삭제합니다.');
				}
			}
	
	console.log("current review : " + <%=reviewNo %>);
	//댓글불러오기
	function jirCommentListPage() {
		$.ajax({
			type: "get",
			url:
		"${path}/jobIntrvReview/jirCommentListPage.do",
			data: {
				"reviewNo" : <%=reviewNo %>
			},
			error: function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			},
			success: function(data){
				console.log(data);
				selector.commentList.html(data);
			}
		});
	};
	
	jirCommentListPage();
	
	
	$(function(){
		selector.commentReg.click(function(){
			jirCommentReg();
		});
		
	});
	
	
	//댓글작성
	function jirCommentReg() {
		var commenttext=selector.commentText.val(); //댓글내용
		var reviewNo= <%=reviewNo %>; //게시물번호
		var commentInfo = {
				"rCommenttext": commenttext,
				"reviewNo": reviewNo,
				"rRegno": <%=userNo%>
				};
		
		//객체 속성명을 DTO랑 맞췄어야지 어휴
		
		 console.log(commenttext);
		 console.log(reviewNo);
		 console.log(commentInfo);
		
		$.ajax({
			type: "post",
			url: "${path}/jobIntrvReview/jirCommentInsert.do",
			data: commentInfo,
			error: function(){
				alert("통신실패");
			},
			success: function(data){ //콜백함수
				selector.commentText.val(function()
						{return ''}); //댓글란에 작성한 내용 지우기.
				confirming.reg();
				jirCommentListPage();
			}
		
		});
	}
	
	function jirCommentEdit(rCommentNo){
		console.log(rCommentNo);
		var edit_cont = '';
		
		edit_cont += '<div>';
		edit_cont += '<div>';
		edit_cont += '<textarea id="commentTextEdit" rows="5" cols="80">';
		edit_cont += $('#commentContent'+rCommentNo).html(); //작성된 댓글 내용을 불러와... 바닐라js의 .innerHTML과 비슷
		edit_cont += '</textarea>';
		edit_cont += '<div style="text-align: right;">';
		edit_cont += '<button type="button" style="cursor:pointer;" onclick="jirCommentListPage();">취소</button>';
		edit_cont += '<span> </span>'
		edit_cont += '<button type="button" style="cursor:pointer;" onclick="jirCommentEditProc('+rCommentNo+');">수정</button>';
		edit_cont += '</div>';
		edit_cont += '</div>';
		edit_cont += '</div>';
		
		$('#'+rCommentNo).html(function(){return edit_cont});
	}
	
	function jirCommentEditProc(rCommentNo) {
		if($('#commentTextEdit').val() =='') {
			alert('댓글 수정 실패');
			return false;
		}
		
		console.log(rCommentNo);
		
		$.ajax({
			type: "post",
			url: "/jobIntrvReview/jirCommentEdit.do",
			data: {
				"rCommentNo" : rCommentNo,
				"rCommenttext": $('#commentTextEdit').val(),
				"rRegNo": <%=userNo%>
			},
			error: function(){
				alert('통신실패');
			},
			success: function(data){
				console.log(data);
				jirCommentListPage();
				confirming.edit();
			}
		})
		
	}
	
	function jirCommentDel(rCommentNo) {
		
		var result = confirm('댓글을 삭제하시겠습니까?');
			if(result) {
			//댓글 삭제 처리
				$.ajax({
					type: "post",
					url: "${path}/jobIntrvReview/jirCommentDelete.do",
					data: {
						"rcommentNo" : rCommentNo
					},
					error: function(){
						alert("통신 실패");
					},
					success: function(data){
						console.log(data);
						jirCommentListPage();
						confirming.del();
				}
					
			})
		}
	}

</script>

</html>