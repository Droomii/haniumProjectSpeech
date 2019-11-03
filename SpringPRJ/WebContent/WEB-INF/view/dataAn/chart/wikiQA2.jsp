<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% List<String> wList = (List<String>) request.getAttribute("wList"); %>

<style>
.div_head_word {
    border-bottom: 1px solid #e2e2e2;
    background-color: #6a7ea2;
    font-size: 12px;
    color: white;
    text-align: center;
    display:inline-block;
    width:30%;
}
.div_head_maen {
    border-bottom: 1px solid #e2e2e2;
    background-color: #6a7ea2;
    font-size: 12px;
    color: white;
    text-align: center;
    display:inline-block;
    width:70%;
}

.div_text_word {
    font-size: 12px;
    text-align: center;
    margin-left: 5%;
    margin-right: 5%;
    margin-top: 1%;
    margin-bottom: 1%;
    display:inline-block;
    width:20%;
    vertical-align: middle;
}
.div_text_mean {
    font-size: 12px;
    text-align: center;
    margin-left: 5%;
    margin-right: 5%;
    margin-top: 1%;
    margin-bottom: 1%;
    display:inline-block;
    width:60%;
    vertical-align: middle;
}
</style>
<script>
/* onload 이벤트보다 먼저 발생한다. 
즉, 문서의 모든 자원이 다운로드되었을때 발생하는 onload와 달리 
DOM 트리만 완성되면 바로 발생하므로 빠른 실행속도가 필요할때 적합하다. */
$(document).ready(function(){ 
	
	//실행될 코드 
	var wList = <%=wList%>;
	var title = wList[0].return_object.WiKiInfo.IRInfo[0].wiki_title//.WikiInfo[0].IRInfo[0].wiki_title;
	var sent = wList[0].return_object.WiKiInfo.IRInfo[0].sent//.AnswerInfo[0].answer;
	
	var wikiResult = 
	"<div style='border: 1px solid #e2e2e2; width:100%;'>"
		+ "<div>"
		+ "<div class='div_head_word'>"
			+ "단어"
		+ "</div>"
		+ "<div class='div_head_maen'>"
			+ "의미"
		+ "</div>"
		+ "</div>"
		+ "<div>"
		+ "<div class='div_text_word'>"
			+ title
		+ "</div>"
		+ "<div class='div_text_mean'>"
			+ sent
		+ "</div>"
		+ "</div>"
	+ "</div>";

	$('#wikiRes').fadeIn(2000, function() {
							$(this).html(wikiResult)
						});

});
</script>
<div id="wikiRes"></div>

	