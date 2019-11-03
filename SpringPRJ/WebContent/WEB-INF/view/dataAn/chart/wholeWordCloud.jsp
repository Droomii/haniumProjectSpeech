<%@page import="poly.dto.DataAnDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<% List<String> rList = (List<String>) request.getAttribute("rList");
   String wholeConfidence = (String) request.getAttribute("wholeConfidence");
  
%>

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
<%-- 전체 사용자 워드클라우드 --%>
 am4core.ready(function() {
// Themes begin
	//am4core.useTheme(am4themes_animated);
	// Themes end

	var chart = am4core.create("wholeWordCloudView", am4plugins_wordCloud.WordCloud);
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
<%--전체 사용자 음성인식 정확도--%>	
am4core.ready(function() {
	
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	// create chart
	var chart = am4core.create("compareAccuracy", am4charts.GaugeChart);
	chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect

	chart.innerRadius = -25;

	var axis = chart.xAxes.push(new am4charts.ValueAxis());
	axis.min = 0;
	axis.max = 100;
	axis.strictMinMax = true;
	axis.renderer.grid.template.stroke = new am4core.InterfaceColorSet().getFor("background");
	axis.renderer.grid.template.strokeOpacity = 0.3;
	var rList = <%=rList%>;
	var resultConf=<%= Float.parseFloat(wholeConfidence)*100%>;
	console.log(resultConf);
	$('#wholeConfidence').html("전체 음성 정확도 "+resultConf+"/100")
	var colorSet = new am4core.ColorSet();
	var range0 = axis.axisRanges.create();
	range0.value = 0;
	range0.endValue = 50;
	range0.axisFill.fillOpacity = 1;
	range0.axisFill.fill = colorSet.getIndex(0);
	range0.axisFill.zIndex = - 1;

	var range1 = axis.axisRanges.create();
	range1.value = 50;
	range1.endValue = 80;
	range1.axisFill.fillOpacity = 1;
	range1.axisFill.fill = colorSet.getIndex(2);
	range1.axisFill.zIndex = -1;

	var range2 = axis.axisRanges.create();
	range2.value = 80;
	range2.endValue = 100;
	range2.axisFill.fillOpacity = 1;
	range2.axisFill.fill = colorSet.getIndex(4);
	range2.axisFill.zIndex = -1;

	var hand = chart.hands.push(new am4charts.ClockHand());
	chart.setTimeout(randomValue, 2000);
	function randomValue() {
		 hand.showValue( resultConf, 1000, am4core.ease.cubicOut)
 		} 

	}); // end am4core.ready()

</script>
<div>전체 사용자 분석 워드클라우드 (단어를 클릭하면 의미를 알수 있습니다.)</div>
<div id="wholeWordCloudView" style="width:100%;height: 300px"></div>



