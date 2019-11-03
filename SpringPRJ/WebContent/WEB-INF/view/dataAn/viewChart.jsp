<%@page import="poly.dto.DataAnDTO"%>
<%@page import="poly.dto.ResultDTO"%>
<%@page import="java.util.List"%>
<%@include file="/WEB-INF/view/User/session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% DataAnDTO dDTO = (DataAnDTO)request.getAttribute("dDTO"); %>
<% String qsetNo = (String)request.getAttribute("qsetNo"); %>
<% String answerNo = (String)request.getAttribute("answerNo"); %>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>

    <title>두루마리-데이터분석</title>

	<%@include file="/WEB-INF/view/header.jsp" %>
	<style>
	.tabActive{
	background:#67b7dc;
	width:100%;
	padding-top:20px;
	padding-bottom:20px;
	text-align: center;
	color:white;
	}
	.tabInActive{
	background:white;
	width:100%;
	padding-top:20px;
	padding-bottom:20px;
	text-align: center
	}
	</style>
  </head>
  <body data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">

	<%@include file="/WEB-INF/view/menu.jsp" %>

    <!-- ////////////////////////////////////////////////////////////////////////////-->
	<div class="app-content content container-fluid">
	<div class="content-wrapper">
		<div class="content-body">	
		<div class="row">
			<div class="col-xs-12">
				<div style="display: flex; justify-content: space-between;">
					<div id="ta1" class="tabActive ta">단일 분석</div>
					<div id="ta2" class="tabInActive ta">다중 분석</div>
					<div id="ta3" class="tabInActive ta">3</div>
				</div>
			</div>
		</div>
			<div id="changeAnText"></div>
			<div id="singleAnalysisView">
					<div class="row">
					<div class="col-sm-12 col-lg-6">
					<div class="card" style="height:32em">
						<div class="card-header">
							<h4 class="card-title info indigo">발음 정확도</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="singleAccuracy"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div class="col-sm-12 col-lg-6">
					<div class="card" style="height:32em">
						<div class="card-header">
							<h4 class="card-title info indigo">사용한 단어</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="chartView"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
					</div>
					<div id="wikiQA"></div>
					<div class="card">
						<div class="card-header">
							<h4 class="card-title info indigo">말습관 분석</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="stutterListView"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header">
							<h4 class="card-title info indigo">말의 빠르기</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="singleWordTerm"></div>
								</div>
							</div>
						</div>
					</div>
			</div>
			
			<div id="compAnalysisView">
					<div class="row">
					<div class="col-sm-12 col-lg-6">
					<div class="card" style="height:32em">
						<div class="card-header">
							<h4 class="card-title info indigo">내가 사용한 단어</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="singleChartView2"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div class="col-sm-12 col-lg-6">
					<div class="card" style="height:32em">
						<div class="card-header">
							<h4 class="card-title info indigo">전체 사용자 단어 모음</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="compareChartView"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
					</div>
					<div class="row">
						<div id="wikiQA2"></div>
					</div>
					<div class="row">
					<div class="col-sm-12 col-lg-6">
					<div class="card" style="height:32em">
						<div class="card-header">
							<h4 class="card-title info indigo">내 발음 정확도</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="singleAccuracy2"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div class="col-sm-12 col-lg-6">
					<div class="card" style="height:32em">
						<div class="card-header">
							<h4 class="card-title info indigo">전체 사용자 평균 발음 정확도</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="compareAccuracy" style="width:100%;height:300px;"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
					</div>
					<div class='row'>
					<div class="card" style="height:32em">
						<div class="card-header">
							<h4 class="card-title info indigo">성별 / 연령별 답변율</h4>
						</div>
						<div class="card-header" style="display: flex;justify-content: space-between;">
							<h5 class="card-title info indigo">남성</h5>
							<h5 class="card-title info indigo">여성</h5>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text">
									<div id="genderAgeChart"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
			</div>
		</div>
		</div>
	</div>
	<!-- 전체 사용자 confidence -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/plugins/wordCloud.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<script>
	$('#wikiQA-compare-cont').hide();
	$('#wikiQA-single-cont').hide();
	$("#compAnalysisView").hide();
	$(".ta").click(function(){
		$(".tabActive").attr('class','tabInActive ta');
		$(this).attr('class','tabActive ta');
		if($(this).attr('id')=="ta1"){
			wordCloud.wordCloudData();
			chartView.singleAccuracy();
			chartView.singleWordTerm();
			$('#compAnalysisView').hide();
			$('#three').hide();
			$('#singleAnalysisView').show();
			$('#wikiQA').html("");
			$('#genderAgeChart').hide();
		}else if($(this).attr('id')=="ta2"){
			var singleConfidence =sessionStorage.getItem('singleConfidence');
			var cont="";
			cont+="<div style='width:100%;text-align:center'>단일 음성 정확도 "+singleConfidence+"/100 </div>";
			cont+="<div id='wholeConfidence' style='width:100%;text-align:center'></div>";
			wordCloud.wordCloudData2();
			console.log("change to ta2")
			chartView.singleAccuracy2();
			wordCloud.wordCloudDataAll();
			console.log("after wordclouddataaall")
			chartView.genderAgeChart();
			
			$('#acText').html(cont);
			$('#singleAnalysisView').hide();
			$('#three').hide();
			$('#compAnalysisView').show();
			$('#wikiQA').html("");
			$('#genderAgeChart').show();
		}else if($(this).attr('id')=="ta3"){
			$('#singleAnalysisView').hide();
			$('#compAnalysisView').hide();
			$('#three').show();
			$('#genderAgeChart').hide();
		}
	})
	</script>
	<script>
	
	$(function(){
		//초기에 보여줄 단일분석
		wordCloud.wordCloudData();
		chartView.singleAccuracy();
		chartView.singleWordTerm();
		stutterList();
		
	})
	
	function stutterList(){
		$.ajax({
			url:'/dataAn/stutterAnalysis.do',
			method:"post",
			data:{
				"answerNo":'<%=answerNo%>',
			 	"userNo":'<%=userNo%>'
			},
			success:function(data){
				$("#stutterListView").append(data);
			}
		})
	}
	const selectorChart={
		chartView:$('#chartView'),
		singleAccuracy:$('#singleAccuracy'),
		changeAnText:$('#changeAnText'),
		singleWordTerm:$('#singleWordTerm'),
		singleChartView2:$('#singleChartView2'),
		singleAccuracy2:$('#singleAccuracy2'),
		compareChartView:$('#compareChartView'),
		genderAgeChart:$('#genderAgeChart')
	}
	var globalWcd;
	const chartView={
			singleWordCloud:function(wordCloudData){
				var wcd = wordCloudData;
				globalWcd = wcd;
				console.log("wcd : "+wcd)
				/* console.log(wcd) */
				var wc = JSON.stringify(wcd)
				console.log("wd : "+wc)
				$.ajax({
					url:'/dataAn/singleWordCloud.do',
					method:"post",
					dataType:"text",
					/* contentType:"application/json; charset=UTF-8;", */
					data: {
						"answerNo": '<%=answerNo%>',
						} ,
					success:function(data){
						selectorChart.chartView.html(data);
					},
					error:function(error){
						
					}
				})
			},
			singleAccuracy:function(){
				$.ajax({
					url:'/dataAn/singleAccuracy.do',
					method:'get',
					data:{
						"answerNo":'<%=answerNo%>',
					 	"userNo":'<%=userNo%>'
					},
					success:function(data){
						selectorChart.singleAccuracy.html(data);
					}
				})
			},
			singleWordTerm:function(data){
				$.ajax({
					url:'/dataAn/singleWordTerm.do',
					method:'get',
					data:{
						"answerNo":'<%=answerNo%>',
						"userNo":'<%=userNo%>'
					},
					success:function(data){
						selectorChart.singleWordTerm.html(data);
					}
				})
			},
			wholeWordCloud:function(wordCloudDataAll){
				console.log("wholeWordCloud start")
				console.log("wordclouddataall : " + wordCloudDataAll)
				var wwc = JSON.stringify(wordCloudDataAll);
				$.ajax({
					url:"/dataAn/wholeWordCloud.do",
					method:"get",
					data:{"qsetNo":'<%=qsetNo%>'},
					success:function(data){
						console.log("wholeWordCloud success")
						console.log(data)
						selectorChart.compareChartView.html(data);
					},
					error:function(error){
						
					}
				})
			},
			singleWordCloud2:function(wordCloudData){
				var wcd = wordCloudData;
				/* console.log(wcd) */
				var wc = JSON.stringify(wcd)
				$.ajax({
					url:'/dataAn/singleWordCloud2.do',
					method:"post",
					dataType:"text",
					/* contentType:"application/json; charset=UTF-8;", */
					data: {
						"answerNo": '<%=answerNo%>',
						} ,
					success:function(data){
						selectorChart.singleChartView2.html(data);
					},
					error:function(error){
						
					}
				})
			},
			singleAccuracy2:function(){
				$.ajax({
					url:'/dataAn/singleAccuracy2.do',
					method:'get',
					data:{
						"answerNo":'<%=answerNo%>',
					 	"userNo":'<%=userNo%>'
					},
					success:function(data){
						selectorChart.singleAccuracy2.html(data);
					}
				})
			},
			genderAgeChart:function(){
				$.ajax({
					url:'/dataAn/genderAgeChart.do',
					method:'get',
					data:{
						"qsetNo":'<%=qsetNo%>'
					},
					success:function(data){
						selectorChart.genderAgeChart.html(data);
					}
	
				})
			}
	}
	const wordCloud = {
	      wordCloudData:function(){
	         var wordCloudData;
	           $.ajax({
	              url:'/result/getMorpheme.do',
	              method:'post',
	              data:{
	                 "answerNo":"<%=answerNo%>"
	              },
	              success:function(data){
	            	  console.log("wordCloudData success")
	            	   console.log(data)
	                 wordCloudData=data;
	                 chartView.singleWordCloud(wordCloudData)
	                
	              }
	           });
	      },
	      wordCloudData2:function(){
	         var wordCloudData;
	           $.ajax({
	              url:'/result/getMorpheme.do',
	              method:'post',
	              data:{
	                 "answerNo":"<%=answerNo%>"
	              },
	              success:function(data){
	            	  console.log("wordclouddata2 success")
	            	   console.log(data)
	                 wordCloudData=data;
	                 chartView.singleWordCloud2(wordCloudData)
	                
	              }
	           });
	      },
		wordCloudDataAll:function(){
			console.log("wordcloudAll start")
			var wordCloudDataAll;
			$.ajax({
				url:'/result/getAllMorphemes.do',
				method:'post',
				dataType: 'text',
				data:{
					"qsetNo":"<%=qsetNo%>"
				},
				success:function(data){
					console.log("wordcloudall success 김한결")
					wordCloudDataAll=data;
					chartView.wholeWordCloud(wordCloudDataAll)
				},
				error:function(error){					
					console.log("wordcloudall Error!!")
					console.log(error)
				}
			});
		}
	}
	
     </script>
  </body>
</html>