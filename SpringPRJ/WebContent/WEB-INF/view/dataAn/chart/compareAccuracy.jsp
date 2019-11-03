<%@page import="poly.dto.DataAnDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<% List<String> rList = (List<String>) request.getAttribute("rList");%>

<script>
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
	var resultConf=rList[0].resultConf*100;
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
		 hand.showValue( rList[0].resultConf*100, 1000, am4core.ease.cubicOut)
 		} 

	}); // end am4core.ready()

</script>
<div id="compareAccuracyChart" style="width:100%;height: 300px"></div>



