<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
JSONArray jsonMaleArr = (JSONArray) request.getAttribute("jsonMaleArr");
int maxCount = (int) request.getAttribute("maxCount");
JSONArray jsonFemaleArr = (JSONArray) request.getAttribute("jsonFemaleArr");
int maxCount2 = (int) request.getAttribute("maxCount2");
%>
<!-- Styles -->
<style>
  #genderAgeChart1 {
    width: 100%;
    height: 300px;
  }
   #genderAgeChart2 {
    width: 100%;
    height: 300px;
  }
  </style>
  <script>
  am4core.ready(function() {
  am4core.useTheme(am4themes_animated);
  var chart = am4core.create("genderAgeChart1", am4charts.RadarChart); 
  var maxCount = <%=maxCount%>
  var data = [];
  data=<%=jsonMaleArr%>;
  var newData = [];
 for(var i=0; i<data.length; i++){
	 newData.push({
			"category": data[i].age*10+"대 이상",
			"value":data[i].count,
			"full":maxCount
	 });
 }
  chart.data = newData;
  
  // Make chart not full circle
  chart.startAngle = -90;
  chart.endAngle = 180;
  chart.innerRadius = am4core.percent(20);
  
  // Set number format
  chart.numberFormatter.numberFormat = "#'명'";
  
  // Create axes
  var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
  categoryAxis.dataFields.category = "category";
  categoryAxis.renderer.grid.template.location = 0;
  categoryAxis.renderer.grid.template.strokeOpacity = 0;
  categoryAxis.renderer.labels.template.horizontalCenter = "right";
  categoryAxis.renderer.labels.template.fontWeight = 500;
  categoryAxis.renderer.labels.template.adapter.add("fill", function(fill, target) {
    return (target.dataItem.index >= 0) ? chart.colors.getIndex(target.dataItem.index) : fill;
  });
  categoryAxis.renderer.minGridDistance = 10;
  
  var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
  valueAxis.renderer.grid.template.strokeOpacity = 0;
  valueAxis.min = 0;
  valueAxis.max = maxCount;
  valueAxis.strictMinMax = true;
  
  // Create series
  var series1 = chart.series.push(new am4charts.RadarColumnSeries());
  series1.dataFields.valueX = "full";
  series1.dataFields.categoryY = "category";
  series1.clustered = false;
  series1.columns.template.fill = new am4core.InterfaceColorSet().getFor("alternativeBackground");
  series1.columns.template.fillOpacity = 0.08;
  series1.columns.template.cornerRadiusTopLeft = 20;
  series1.columns.template.strokeWidth = 0;
  series1.columns.template.radarColumn.cornerRadius = 20;
  
  var series2 = chart.series.push(new am4charts.RadarColumnSeries());
  series2.dataFields.valueX = "value";
  series2.dataFields.categoryY = "category";
  series2.clustered = false;
  series2.columns.template.strokeWidth = 0;
  series2.columns.template.tooltipText = "{category}: [bold]{value}[/]";
  series2.columns.template.radarColumn.cornerRadius = 20;
  
  series2.columns.template.adapter.add("fill", function(fill, target) {
    return chart.colors.getIndex(target.dataItem.index);
  });
  
  // Add cursor
  chart.cursor = new am4charts.RadarCursor();
  
  }); // end am4core.ready()
  am4core.ready(function() {
	  am4core.useTheme(am4themes_animated);
	  var chart2 = am4core.create("genderAgeChart2", am4charts.RadarChart); 
	  var maxCount2 = <%=maxCount2%>
	  var data2 = [];
	  data2=<%=jsonFemaleArr%>;
	  var newData2 = [];
	 for(var i=0; i<data2.length; i++){
		 newData2.push({
				"category": data2[i].age*10+"대 이상",
				"value":data2[i].count,
				"full":maxCount2
		 });
	 }
	  chart2.data = newData2;
	  
	  // Make chart not full circle
	  chart2.startAngle = -90;
	  chart2.endAngle = 180;
	  chart2.innerRadius = am4core.percent(20);
	  
	  // Set number format
	  chart2.numberFormatter.numberFormat = "#'명'";
	  
	  // Create axes
	  var categoryAxis2 = chart2.yAxes.push(new am4charts.CategoryAxis());
	  categoryAxis2.dataFields.category = "category";
	  categoryAxis2.renderer.grid.template.location = 0;
	  categoryAxis2.renderer.grid.template.strokeOpacity = 0;
	  categoryAxis2.renderer.labels.template.horizontalCenter = "right";
	  categoryAxis2.renderer.labels.template.fontWeight = 500;
	  categoryAxis2.renderer.labels.template.adapter.add("fill", function(fill, target) {
	    return (target.dataItem.index >= 0) ? chart2.colors.getIndex(target.dataItem.index) : fill;
	  });
	  categoryAxis2.renderer.minGridDistance = 10;
	  
	  var valueAxis2 = chart2.xAxes.push(new am4charts.ValueAxis());
	  valueAxis2.renderer.grid.template.strokeOpacity = 0;
	  valueAxis2.min = 0;
	  valueAxis2.max = maxCount2;
	  valueAxis2.strictMinMax = true;
	  
	  // Create series
	  var series3 = chart2.series.push(new am4charts.RadarColumnSeries());
	  series3.dataFields.valueX = "full";
	  series3.dataFields.categoryY = "category";
	  series3.clustered = false;
	  series3.columns.template.fill = new am4core.InterfaceColorSet().getFor("alternativeBackground");
	  series3.columns.template.fillOpacity = 0.08;
	  series3.columns.template.cornerRadiusTopLeft = 20;
	  series3.columns.template.strokeWidth = 0;
	  series3.columns.template.radarColumn.cornerRadius = 20;
	  
	  var series4 = chart2.series.push(new am4charts.RadarColumnSeries());
	  series4.dataFields.valueX = "value";
	  series4.dataFields.categoryY = "category";
	  series4.clustered = false;
	  series4.columns.template.strokeWidth = 0;
	  series4.columns.template.tooltipText = "{category}: [bold]{value}[/]";
	  series4.columns.template.radarColumn.cornerRadius = 20;
	  
	  series4.columns.template.adapter.add("fill", function(fill, target) {
	    return chart2.colors.getIndex(target.dataItem.index);
	  });
	  
	  // Add cursor
	  chart2.cursor = new am4charts.RadarCursor();
	  
	  }); // end am4core.ready()
  </script>
  
  <!-- HTML -->
  <div style="display:flex">
	<div id="genderAgeChart1"></div>
  	<div id="genderAgeChart2"></div>
  </div>