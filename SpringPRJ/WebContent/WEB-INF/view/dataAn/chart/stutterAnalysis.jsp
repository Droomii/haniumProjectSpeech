<%@page import="org.json.simple.JSONArray"%>
<%@page import="poly.dto.ResultDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ResultDTO rDTO = (ResultDTO)request.getAttribute("rDTO");
	JSONArray stutterArray = (JSONArray)request.getAttribute("stutterArray"); 
	double stutterRate = (double)request.getAttribute("stutterRate");
	HashMap<String, String> hlMap = (HashMap<String, String>)request.getAttribute("hlMap");
	String[] habits = {"lackOfExpr", "vague", "badHabit", "unconfident", "informal"};
	String[] habits_class = {"lack-of-expr", "vague", "bad-habit", "unconfident", "informal"};
	String[] habits_desc = {"어휘력 부족", "모호한 표현", "무의식적 말습관", "자신감 부족", "비격식체(~요) 사용"};
	String[] habits_expl = {
			"'엄청', '완전' 등과 같은 표현은 본인의 어휘력이 부족하다는 인상을 면접관에게 심어줄 수 있습니다.",
			"'여러가지', '다양한' 등의 표현은 면접관들이 정확히 알 길이 없는 모호한 표현입니다. 경험을 이야기 할 때는 중요한 경험 한 두가지에 집중해서 이야기하되, 추가적인 경험은 짧게 나열하면서 면접관들의 관심을 끌어 추가 질문을 유도하는 것이 좋습니다.",
			"'이제', '뭐지', '솔직히' 등의 단어는 본인도 모르게 반복적으로 쓰는 단어입니다. 과도한 사용은 면접관의 귀에 거슬릴 수 있으므로 지양해야 합니다.",
			"'~것 같습니다'와 같은 표현은 면접관들에게 자신감이 부족하다는 인상을 남길 수 있습니다. 이러한 표현을 자주 쓰는지 확인하여 고칠 필요가 있습니다.",
			"일상생활에서 격식체('~다')를 잘 쓰지 않기 때문에 면접장에서 '~요'를 무의식적으로 쓰는 면접자들이 많습니다. 인상이나 태도를 많이 보는 면접관들에게는 자칫 가벼워 보일 수 있는 말투이므로, 본인이 '~요'체를 많이 쓰지는 않는지 미리 확인하고 고칠 필요가 있습니다."
	};
%>
<style>
/*
     region.wavesurfer-region:before {
		content: attr(data-region-label);
		position: absolute;
		bottom: 0;
     }
*/
     region.wavesurfer-region[data-region-label] {
	    border: 1px solid rgb(255, 105, 105);
	    box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.05) inset, 0px 0px 8px rgba(255, 140, 140, 0.6);
     } 
     

</style>
<script src="/resources/wavesurfer/wavesurfer.js"></script>
<script src="/resources/wavesurfer/timeline.js"></script>
<script src="/resources/wavesurfer/regions.js"></script>
   
<div>
<%=hlMap.get("result") %>
</div>
<hr>
<div id="waveform"></div>
<div id="wave-timeline"></div>
<div id="wavePlot"></div>
 <div class="controls" style="text-align: center;padding-top:10px">
            <button class="btn btn-primary" onclick="wavesurfer.skipBackward()">
              <i class="fa fa-step-backward"></i>
              	되감기
            </button>
            <button class="btn btn-primary" onclick="wavesurfer.playPause()">
              <i class="fa fa-play"></i>
              	재생/<i class="fa fa-pause"></i>일시정지
            </button>
            <button class="btn btn-primary" onclick="wavesurfer.skipForward()">
              <i class="fa fa-step-forward"></i>
              	빨리감기
            </button>
</div>
<div style="margin-bottom:1rem;margin-top:1rem">부적절 표현 비율 : <%=stutterRate*100 %>%</div>
<%for(int i=0; i<habits.length; i++) {
	if(!hlMap.get(habits[i]).equals("")){%>
		<div id=<%=habits[i] %>>
		<hr style="margin-top:0">
		<h5 class="text-bold-600"><%=habits_desc[i] %></h5>
		<p class="card-text" style="padding-bottom:1rem"><%=habits_expl[i] %></p>
		</div>
		<script>
		$("#"+"<%=habits[i]%>").mouseenter(function(){
			var elements = $('.'+'<%=habits_class[i]%>')
			elements.removeClass('bg-lighten-4');
		    elements.addClass('white text-bold-700');
		    $("#"+"<%=habits[i]%>").css("background-color", "rgb(227, 243, 255)")
		});
		
		$("#"+"<%=habits[i]%>").mouseleave(function(){
			var elements = $('.'+'<%=habits_class[i]%>')
			elements.addClass('bg-lighten-4');
		    elements.removeClass('white text-bold-700');
		    $("#"+"<%=habits[i]%>").css("background-color", "white")
		});
		</script>
	<%
	}
}

%>
<script>
var startTime=<%=rDTO.getStartTime()%>;
var endTime=<%=rDTO.getEndTime()%>;
var word=<%=rDTO.getWord()%>;
var stutterArray = <%=stutterArray%>
var regions=[];
var cont="";

for(var i=0 ; i<stutterArray.length;i++){
	cont={start:stutterArray[i].startTime,end:stutterArray[i].endTime,loop:false,color:'rgba(245, 66, 66, 0.5)',drag:false,resize:false,attributes:{index:i, label:stutterArray[i].word}}
	regions.push(cont);
}  
var wavesurfer = WaveSurfer.create({
	normalize:true,
    container: document.querySelector('#waveform'),
    waveColor: '#A8DBA8',
    progressColor: '#3B8686',
    backend: 'MediaElement',
    barWidth: 3,
    barHeight: 1, // the height of the wave
    barGap: null ,
    plugins: [
        WaveSurfer.regions.create({
            regions: regions
        }),
        WaveSurfer.timeline.create({
        container: "#wave-timeline",
        primaryFontColor: 'red',
        formatTimeCallback: formatTimeCallback,
        timeInterval: timeInterval,
        primaryLabelInterval: primaryLabelInterval,
        secondaryLabelInterval: secondaryLabelInterval,
	    primaryColor: 'blue',
	    secondaryColor: 'red',
	    primaryFontColor: 'blue',
	    secondaryFontColor: 'red'
        })
    ]   
});
function formatTimeCallback(seconds, pxPerSec) {
    seconds = Number(seconds);
    var minutes = Math.floor(seconds / 60);
    seconds = seconds % 60;

    // fill up seconds with zeroes
    var secondsStr = Math.round(seconds).toString();
    if (pxPerSec >= 25 * 10) {
        secondsStr = seconds.toFixed(2);
    } else if (pxPerSec >= 25 * 1) {
        secondsStr = seconds.toFixed(1);
    }

    if (minutes > 0) {
        if (seconds < 10) {
            secondsStr = '0' + secondsStr;
        }
        return `${minutes}:${secondsStr}`;
    }
    return secondsStr;
}

function timeInterval(pxPerSec) {
    var retval = 1;
    if (pxPerSec >= 25 * 100) {
        retval = 0.01;
    } else if (pxPerSec >= 25 * 40) {
        retval = 0.025;
    } else if (pxPerSec >= 25 * 10) {
        retval = 0.1;
    } else if (pxPerSec >= 25 * 4) {
        retval = 0.25;
    } else if (pxPerSec >= 25) {
        retval = 1;
    } else if (pxPerSec * 5 >= 25) {
        retval = 5;
    } else if (pxPerSec * 15 >= 25) {
        retval = 15;
    } else {
        retval = Math.ceil(0.5 / pxPerSec) * 60;
    }
    return retval;
}

function primaryLabelInterval(pxPerSec) {
    var retval = 1;
    if (pxPerSec >= 25 * 100) {
        retval = 10;
    } else if (pxPerSec >= 25 * 40) {
        retval = 4;
    } else if (pxPerSec >= 25 * 10) {
        retval = 10;
    } else if (pxPerSec >= 25 * 4) {
        retval = 4;
    } else if (pxPerSec >= 25) {
        retval = 1;
    } else if (pxPerSec * 5 >= 25) {
        retval = 5;
    } else if (pxPerSec * 15 >= 25) {
        retval = 15;
    } else {
        retval = Math.ceil(0.5 / pxPerSec) * 60;
    }
    return retval;
}

function secondaryLabelInterval(pxPerSec) {
    // draw one every 10s as an example
    return Math.floor(10 / timeInterval(pxPerSec));
}
console.log('hello!!')
wavesurfer.on('region-mouseenter', function(region, e) {
    console.log(region.attributes.label)
       console.log(region.start)
    console.log(region.end)
    var stutterEl = $("#stutter"+region.attributes.index)
    stutterEl.removeClass('bg-lighten-4');
    stutterEl.addClass('white text-bold-700');
    
});
wavesurfer.on('region-mouseleave', function(region, e) {
    console.log(region.attributes.label)
    var stutterEl = $("#stutter"+region.attributes.index)
    stutterEl.addClass('bg-lighten-4');
    stutterEl.removeClass('white text-bold-700');
});

wavesurfer.on('region-in', function(region, e) {
    console.log(region.attributes.label)
    var stutterEl = $("#stutter"+region.attributes.index)
    stutterEl.removeClass('bg-lighten-4');
    stutterEl.addClass('white text-bold-700');
    
});
wavesurfer.on('region-out', function(region, e) {
    console.log(region.attributes.label)

    var stutterEl = $("#stutter"+region.attributes.index)
    
    stutterEl.addClass('bg-lighten-4');
    stutterEl.removeClass('white text-bold-700');
});
// 서버에서 파일불러와야됨
wavesurfer.load("/resources/output.ogg")
</script>