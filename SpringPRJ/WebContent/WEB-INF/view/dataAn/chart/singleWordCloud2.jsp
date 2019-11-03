<%@page import="poly.dto.DataAnDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<% List<String> rList = (List<String>) request.getAttribute("rList"); %>
<script>
 
var wiki = {
	wikiQA : function(e){
		$.ajax({
			url:"/dataAn/wikiQA.do",
			method:"post",
			dataType:"text",
			data:{
				"word":e
			},
			success:function(data){
				$('#wikiQA2').html(data)
			},
			error:function(error){
				console.log(error)
			}
		})
	}
}

 am4core.ready(function() {
// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	var chart = am4core.create("wordCloudView2", am4plugins_wordCloud.WordCloud);
	chart.fontFamily = "Courier New";
	var series = chart.series.push(new am4plugins_wordCloud.WordCloudSeries());
	series.randomness = 0.1;
	series.rotationThreshold = 0.5;
	var rList = <%=rList%>;

	series.data = rList
	
	series.dataFields.word = "tag";
	series.dataFields.value = "weight";
	series.minFontSize=am4core.percent(10);
	series.maxFontSize = am4core.percent(30);	
	series.heatRules.push({
		"target": series.labels.template,
		"property": "fill",
		"min": am4core.color("#0000CC"),
		"max": am4core.color("#CC00CC"),
		"dataField": "value" 
	});
	
 	series.labels.template.events.on("hit", function(e) {
		var a = e.target.currentText
		wiki.wikiQA(a)
	});
 	
	series.labels.template.tooltipText = "{word}: {value}";
	
	var hoverState = series.labels.template.states.create("hover");
	hoverState.properties.fill = am4core.color("#FF0000");
	
	}); // end am4core.ready() 

</script>
<div>단일 사용자 분석 워드클라우드 (단어를 클릭하면 의미를 알수 있습니다.)</div>
<div id="wordCloudView2" style="width:100%;height: 300px"></div>


