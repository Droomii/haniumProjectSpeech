<%@page import="poly.dto.ResultDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% ResultDTO rDTO1 = (ResultDTO) request.getAttribute("rDTO"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="tex/html; charset=UTF-8">
</head>
<body>
<script>
am4core.ready(function() {

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

// create chart
var chart = am4core.create("singleAccuracyChart", am4charts.GaugeChart);
chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect

chart.innerRadius = -25;

var axis = chart.xAxes.push(new am4charts.ValueAxis());
axis.min = 0;
axis.max = 100;
axis.strictMinMax = true;
axis.renderer.grid.template.stroke = new am4core.InterfaceColorSet().getFor("background");
axis.renderer.grid.template.strokeOpacity = 0.3;

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
	 hand.showValue( <%=rDTO1.getConfidence()%>*100, 1000, am4core.ease.cubicOut)
} 
selectorChart.changeAnText.html("<%=rDTO1.getSpeechMakerName()%> 님의 분석 정보입니다.")
}); // end am4core.ready()
</script>
<div id="singleAccuracyChart" style="width:100%;height: 300px"></div>
</body>
</html>