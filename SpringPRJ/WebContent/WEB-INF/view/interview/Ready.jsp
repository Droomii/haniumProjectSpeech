<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../User/session.jsp" %>
<%@page import="poly.dto.QSetDTO"%>
<%
	QSetDTO qDTO = (QSetDTO) request.getAttribute("qDTO");
	String randQ = (String) request.getAttribute("randQ");
	String qsetNo = qDTO.getQsetNo();
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<meta charset="UTF-8">
<title>모의면접 진행</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>

</head>
<link rel="stylesheet" type="text/css" href="/resources/assets/progressbar/loading-bar.css" />
<script type="text/javascript" src="/resources/assets/progressbar/loading-bar.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.8.0/p5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.8.0/addons/p5.sound.js"></script>

<style>
	#mic{
		background-image:url("/resources/app-assets/images/elements/mic_disabled.png");
		background-size:15em 15em;
	}
	.ldBar-label{
		display:none;
		}
	#analyzingCircle {
	  border: 0.5em solid #f3f3f3; /* Light grey */
	  border-top: 0.5em solid #3498db; /* Blue */
	  border-radius: 50%;
	  width: 15em;
	  height: 15em;
	  animation: spin 2s linear infinite;
 	  visibility:hidden; 
	}
	
	@keyframes spin {
	  0% { transform: rotate(0deg); }
	  100% { transform: rotate(360deg); }
	}
	</style>
<body data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-body">
<!-- Text alignment section start -->
<section id="text-alignment">

	<div class="row">
		<div class="col-lg-12 col-md-12">
			<div class="card text-xs-center">
				<div class="card-body">
					<div class="card-block" id="contentBlock">
					
						<h4 class="card-title primary">모의 면접 진행</h4>
						<div id="questionBlock">
							<p class="card-text">모의면접 시작 버튼을 누르면 질문이 출력됩니다.</p>
							<p class="card-text">질문 출력 10초 후 자동으로 녹음이 시작됩니다.</p>
						</div>
							<br>
							<div id="mic" style="width:15em;height:15em;margin:auto">
									<div id="progressCircle" style="width:15em;height:15em;color:white;" data-stroke="red" data-preset="circle" class="label-center" data-value="100" data-precision="0.01"></div>
									<div id="analyzingCircle"></div>
							</div>
							<p id="answer-text" class="card-text"></p>
							
							
						<h1 id="timer"></h1>
						<div><button id="startInterview" class="btn btn-danger">모의면접 시작</button></div>
						<p>
						<script>
						
						</script>
						</p>
						
						<button style="display:none" id="stopInterview" class="btn btn-danger">녹음 종료</button>
						<button style="display:none" id="submitInterview" class="btn btn-danger">제출</button>
						<form name="resultForm"action="/dataAn/viewChart.do" hidden="hidden">
						<input name="answerNo" value="">
						<input name="qsetNo" value=<%=qsetNo %>>
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Text alignment section end -->
        </div>
      </div>
    </div>
	
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
<script>
	// 음성 데이터 담는 글로벌 변수
	var globalAudioData;
	
	var randQ = '';
	$("#startInterview").on("click", function(){
		console.log("qsetNo : " + <%=qsetNo%>)
	    $.ajax({
	          type: 'POST',
	          url: '${pageContext.request.contextPath}/interview/GetRandQ.do',
	          data: {qsetNo : <%=qsetNo%>},
	          success:function(data){
					randQ = data
	        	  $("#questionBlock").html("<h5>질문:<br><br>" + randQ + "</h5>");
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown){
					alert('status:' + XMLHttpRequest.status + ', status text: ' +
							XMLHttpRequest.statusText);
				}
			
				
			});
		
		$("#startInterview").attr("hidden", "hidden");
		$("#timer").removeAttr("hidden");
		//Countdown Timer
		var countDown = new Date().getTime()+3000;

		// Update the count down every 1 second
		var x = setInterval(function() {
			
			  // Get today's date and time
			    var now = new Date().getTime();
			  
				
			  // Find the distance between now and the count down date
			  var distance = countDown - now;
			
			  // Time calculations for days, hours, minutes and seconds
			  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
				
			  var timer =  document.getElementById("timer");
			  // Display the result in the element with id="demo"
			 timer.innerHTML = "녹음 시작까지 "+seconds+"초";
			
			  // If the count down is finished, write some text 
			  if (seconds <=0) {
			    clearInterval(x);
			    
			    $("#stopInterview").css("display", "inline");
			    $("#mic").css("background-image", 'url("/resources/app-assets/images/elements/mic.png")');
			    timer.style.color = "red";
			    timer.innerHTML = "59"
			    
			    var bar1 = new ldBar("#progressCircle");
				var bar2 = document.getElementById('progressCircle').ldBar;
				
				
				var constraints = {
					    audio: true,
					    video: false
					}
				navigator.mediaDevices.getUserMedia(constraints)
				  .then(stream => {
				    const mediaRecorder = new MediaRecorder(stream);
				    
				    mediaRecorder.start();

				    const audioChunks = [];
				    mediaRecorder.addEventListener("dataavailable", event => {
				      audioChunks.push(event.data);
				    });

				    mediaRecorder.addEventListener("stop", () => {
				      const audioBlob = new Blob(audioChunks);
				      console.log(audioBlob);
				      const audioUrl = URL.createObjectURL(audioBlob);
				      
				      var reader = new FileReader();
				      var base64data;
				      reader.readAsDataURL(audioBlob); 
				      reader.onloadend = function() {
				          base64data = reader.result;                
				          console.log(base64data);
					      var fd = new FormData();
					      fd.append('data', base64data);
					      fd.append('mimeType', mediaRecorder.mimeType);
					      fd.append('qsetNo', <%=qsetNo%>);
					      fd.append('randQ', randQ);
					      globalAudioData = fd;
					      
/*					      $.ajax({
					          type: 'POST',
					          url: '${pageContext.request.contextPath}/result/analyzeAudio.do',
					          data: fd,
					          processData: false,
					          contentType: false,
					          success: function(data){
					        	  $("#analyzingCircle").css("display", "none");
					        	  timer.innerHTML = "";
					        	  document.getElementById("answer-text").innerHTML = data;
					          }
					          
					      }).done(function(data) {
					             console.log(data); 
					             
					      }); */
				       }
				      
 				      
				      
				      
				    });
					
				    
				    
				    const stopButton = document.getElementById('stopInterview');
				    
				    
				    stopButton.addEventListener('click', function(){
				    	stopInterview=true;
				    	$("#stopInterview").attr("hidden", "hidden");
				    	$("#submitInterview").css("display", "inline");
				    })
				    var stopInterview = false;
				    var countDown2 = new Date().getTime()+60000;
					var x2 = setInterval(function() {
						
						  // Get today's date and time
						  var now2 = new Date().getTime();
						
						  // Find the distance between now and the count down date
						  var distance2 = countDown2 - now2;
						
						  // Time calculations for days, hours, minutes and seconds
						  var progress = (distance2 % (1000 * 60)) / 1000;
						  var seconds2 = Math.floor(progress);
							
						  var timer2 =  document.getElementById("timer");
						  // Display the result in the element with id="demo"
						 timer2.innerHTML = seconds2;
						  
						 bar1.set(progress*100/60);
						  // If the count down is finished, write some text 
						  if (seconds2 <=0 || stopInterview == true) {
						    clearInterval(x2);
						    mediaRecorder.stop();
						    console.table(mediaRecorder);
						    $("#progressCircle").css("display", "none");
						    timer.style.color = "black";
						    timer.innerHTML = "제출 버튼을 누르시면 분석을 시작합니다";
						    bar1.set(0);
						    $("#mic").css("background-image", 'url("/resources/app-assets/images/elements/mic_disabled.png")');
						  }
					  });
				    
				     
				  });
			    
			  }
		  });
	});

	$("#submitInterview").click(function(){
		$("#submitInterview").hide();
		$("#analyzingCircle").css("visibility", "visible");
		var timer =  document.getElementById("timer");
		timer.innerHTML = "분석중입니다...";
		$.ajax({
	          type: 'POST',
	          url: '${pageContext.request.contextPath}/result/analyzeAudio.do',
	          data: globalAudioData,
	          processData: false,
	          contentType: false,
	          success: function(data){
	        	  var answerNo = data;
	        	  if(data=="0"){
	        		  timer.innerHTML = "오류 발생";
	        		  return;
	        	  }else{
	        		  $.ajax({
	    	              url:'/etri/insertTextKonlp.do',
	    	              method:'post',
	    	              data:{
	    	                 "openApiURL":"http://aiopen.etri.re.kr:8000/WiseNLU",
	    	                 "analysisCode":"ner",
	    	                 "answerNo":data
	    	              },
	    	              success:function(data){
	    	            	  document.resultForm.answerNo.value=answerNo;
	    		        	  document.resultForm.submit();
	    	              }
	    	           });  
	        		  
		        	  
	        	  }
	        	  
	          }
	          
	      }).done(function(data) {
	             console.log(data); 
	             
	      });
	});
</script>

</body>
</html>
