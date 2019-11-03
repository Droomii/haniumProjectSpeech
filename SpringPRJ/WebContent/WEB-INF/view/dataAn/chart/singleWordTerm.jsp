<%@page import="poly.dto.ResultDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% ResultDTO rDTO = (ResultDTO) request.getAttribute("rDTO"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% String[] endTimeLast =  rDTO.getEndTime().replace("[","").replace("]","").split(",");
	String endTime = endTimeLast[endTimeLast.length-1].replaceAll("\"", "");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
<script>

var answerWords = <%=rDTO.getWord()%>;
var answerTerms = <%=rDTO.getTerm()%>;

am4core.ready(function() {
	var userName = "<%=rDTO.getSpeechMakerName()%>";
	var transcript = "<%=rDTO.getTranscript().replaceAll(" ","")%>";
	var endTime = <%=rDTO.getEndTime()%>;
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	// Create chart instance
	var chart = am4core.create("speechFastChart", am4charts.XYChart);
	// Add data
	chart.data = [
	  {
	    "name": userName,
	    "title": "면접의 빠르기",
	    "averageFastTime":transcript.length/endTime[endTime.length-1] 
	  }
	];

	// Create axes
	var yAxis = chart.yAxes.push(new am4charts.CategoryAxis());
	yAxis.dataFields.category = "title";
	yAxis.renderer.grid.template.location = 0;
	yAxis.renderer.labels.template.fontSize = 10;
	yAxis.renderer.minGridDistance = 10;

	var xAxis = chart.xAxes.push(new am4charts.ValueAxis());

	// Create series
	var series = chart.series.push(new am4charts.ColumnSeries());
	series.dataFields.valueX = "averageFastTime";
	series.dataFields.categoryY = "title";
	series.columns.template.tooltipText = "{categoryY}: [bold]{valueX}[/]";
	series.columns.template.strokeWidth = 0;
	series.columns.template.adapter.add("fill", function(fill, target) {
	  if (target.dataItem) {
	    switch(target.dataItem.dataContext.name) {
	      case userName:
	        return chart.colors.getIndex(0);
	        break;
	    }
	  }
	  return fill;
	});

	// Add ranges
	function addRange(label, start, end, color) {
	  var range = yAxis.axisRanges.create();
	  range.category = start;
	  range.endCategory = end;
	  range.label.text = label;
	  range.label.disabled = false;
	  range.label.fill = color;
	  range.label.location = 0;
	  range.label.dx = -100;
	  range.label.dy = 12;
	  range.label.fontWeight = "bold";
	  range.label.fontSize = 12;
	  range.label.horizontalCenter = "left"
	  range.label.inside = true;
	  
	  range.grid.stroke = am4core.color("#396478");
	  range.grid.strokeOpacity = 1;
	  range.tick.length = 200;
	  range.tick.disabled = false;
	  range.tick.strokeOpacity = 0.6;
	  range.tick.stroke = am4core.color("#396478");
	  range.tick.location = 0;
	  
	  range.locations.category = 1;
	}

	addRange("<%=rDTO.getSpeechMakerName()%>", "음성 인식 정확도", "음성 인식 정확도", chart.colors.getIndex(0));
	chart.cursor = new am4charts.XYCursor();

	}); // end am4core.ready()
</script>
	<div style="width:100%;">면접의 빠르기(총 음절 : <%=rDTO.getTranscript().replaceAll(" ","").length()%> / 시간 : <%=endTime %>초)</div>
	<div id="speechFastChart" style="width:100%;height: 300px"></div>
	
</body>
</html>