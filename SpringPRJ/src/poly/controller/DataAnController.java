package poly.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import poly.dto.DataAnDTO;
import poly.dto.ResultDTO;
import poly.persistance.mapper.DataAnMapper;
import poly.persistance.mapper.ResultMapper;
import poly.service.IDataAnService;
import poly.service.IResultService;
import poly.util.Wiki;

@RequestMapping(value = "/dataAn")
@Controller
public class DataAnController {
	
	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name = "dataAnMapper")
	private DataAnMapper dataAnMapper;
	
	@Resource(name="DataAnService")
	private IDataAnService dataAnService;
	
	@Resource(name="ResultMapper")
	private ResultMapper resultMapper;
	
	@Resource(name="ResultService")
	private IResultService resultService;

	@RequestMapping(value = "/viewChart")
	public String viewChart(HttpServletRequest req, Model model) throws Exception {
		String qsetNo = req.getParameter("qsetNo");
		String answerNo = req.getParameter("answerNo");
		DataAnDTO dDTO = new DataAnDTO();
		dDTO.setAnswerNo(answerNo);
		dDTO = dataAnMapper.getTranscript(dDTO);
		model.addAttribute("dDTO", dDTO);
		model.addAttribute("qsetNo", qsetNo);
		model.addAttribute("answerNo", answerNo);
		dDTO = null;

		return "/dataAn/viewChart";
	}

	@RequestMapping(value = "/singleWordCloud")
	public String singleAnalysis(HttpServletRequest req, Model model) throws Exception {
		List<String> rList = new ArrayList<>();
		List<DataAnDTO> wList = new ArrayList<>();
		Gson gson = new Gson();
		String answerNo = req.getParameter("answerNo");
		String wcd = resultMapper.getMorpheme(answerNo);
		
		rList.add(wcd.substring(1, wcd.length() - 1));
		log.info("wcd : "+ wcd);
		model.addAttribute("rList", rList);

		wList = null;
		rList = null;
		wcd = null;
		return "/dataAn/chart/singleWordCloud";
	}

	@RequestMapping(value = "/singleAccuracy")
	public String singleAccuracy(HttpServletRequest req, Model model) throws Exception {
		// 단일 정확도, 텀
		ResultDTO rDTO = new ResultDTO();
		rDTO.setAnswerNo(req.getParameter("answerNo"));
		rDTO.setSpeechMakerName(req.getParameter("userNo"));
		rDTO = dataAnMapper.getDataSingle(rDTO);
		model.addAttribute("rDTO", rDTO);
		return "/dataAn/chart/singleAccuracy";
	}

	@RequestMapping(value = "/singleWordTerm")
	public String wordTermChart(HttpServletRequest req, Model model) throws Exception {
		// 단일 정확도, 텀
		ResultDTO rDTO = new ResultDTO();
		rDTO.setAnswerNo(req.getParameter("answerNo"));
		rDTO.setSpeechMakerName(req.getParameter("userNo"));
		rDTO = dataAnMapper.getDataSingle(rDTO);
		model.addAttribute("rDTO", rDTO);
		return "/dataAn/chart/singleWordTerm";
	}

	@RequestMapping(value = "/wikiQA")
	public String wikiQA(HttpServletRequest req, Model model) throws Exception {

		List<String> wList = new ArrayList<String>();
		String word = req.getParameter("word");
		Wiki wk = new Wiki();
		word = wk.SearchWord(word);
		wList.add(word);
		model.addAttribute("wList", wList);
		return "/dataAn/chart/wikiQA";
	}

	@RequestMapping(value = "/wholeWordCloud")
	public String wholeWordCloud(HttpServletRequest req, Model model) throws Exception {
		log.info(this.getClass().getName() + ".wholeWordCloud start!!");
		List<String> rList = new ArrayList<String>();
		String qsetNo = req.getParameter("qsetNo");
		String wcd = resultService.getAllMorphemes(qsetNo);
		log.info("wcdAll : "+ wcd);
		String wholeConfidence = resultMapper.getWholeConfidence(req.getParameter("qsetNo"));
		rList.add(wcd);
		model.addAttribute("rList", rList);
		model.addAttribute("wholeConfidence",wholeConfidence);
		rList = null;
		wcd = null;
		return "/dataAn/chart/wholeWordCloud";
	}

	@RequestMapping(value = "/singleWordCloud2")
	public String singleAnalysis2(HttpServletRequest req, Model model) throws Exception {
		List<String> rList = new ArrayList<>();
		List<DataAnDTO> wList = new ArrayList<>();
		Gson gson = new Gson();
		String answerNo = req.getParameter("answerNo");
		String wcd = resultMapper.getMorpheme(answerNo);
		
		rList.add(wcd.substring(1, wcd.length() - 1));
		log.info("wcd : "+ wcd);
		model.addAttribute("rList", rList);

		wList = null;
		rList = null;
		wcd = null;
		return "/dataAn/chart/singleWordCloud2";
	}

	@RequestMapping(value = "/singleAccuracy2")
	public String singleAccuracy2(HttpServletRequest req, Model model) throws Exception {
		// 단일 정확도, 텀
		ResultDTO rDTO = new ResultDTO();
		rDTO.setAnswerNo(req.getParameter("answerNo"));
		rDTO.setSpeechMakerName(req.getParameter("userNo"));
		rDTO = dataAnMapper.getDataSingle(rDTO);
		model.addAttribute("rDTO", rDTO);
		return "/dataAn/chart/singleAccuracy2";
	}
	
	@RequestMapping(value = "/stutterAnalysis")
	public String stutturAnalysis(HttpServletRequest req, ModelMap model) throws Exception{
		
		ResultDTO rDTO = new ResultDTO();
		rDTO.setAnswerNo(req.getParameter("answerNo"));
		rDTO.setSpeechMakerName(req.getParameter("userNo"));
		rDTO = dataAnMapper.getDataSingle(rDTO);
		
		// 말습관 분석해서
		List<HashMap<String, String>> stutterList = dataAnService.getStutterAnalysis(rDTO);
		if(stutterList==null) {
			log.info("stutterList is empty!!");
		}
		JSONArray stutterArray = new JSONArray();

		for (Map<String, String> map : stutterList) {
			JSONObject jsonObj = new JSONObject(map);
			stutterArray.add(jsonObj);
		}
		
	
		// 더듬는 비율 
		int wordCount = rDTO.getTranscript().split(" ").length;
		log.info("wordcount : " + wordCount);
		log.info("number of stutter list : " + stutterList.size());
		log.info("transcript : " + rDTO.getTranscript());
		Map<String, String> hlMap = dataAnService.highlightStutter(rDTO.getWord());
		log.info("replaced transcript : " + hlMap.get("result"));
		double stutterRate = (double)stutterList.size() / wordCount;
		stutterRate = Math.round(stutterRate * 1000) / 1000.0;
		model.addAttribute("stutterRate", stutterRate);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("hlMap", hlMap);
		model.addAttribute("stutterArray",stutterArray);
		return "/dataAn/chart/stutterAnalysis";
	}
	
	@RequestMapping(value="/genderAgeChart.do")
	public String genderAgeChart(HttpServletRequest req,Model model) throws Exception{
		List<HashMap<String,Object>> hList = dataAnMapper.getDataGenderAgeCount(req.getParameter("qsetNo"));
		List<HashMap<String,Object>> hList2 = dataAnMapper.getDataFemaleGenderAgeCount(req.getParameter("qsetNo"));
		JSONArray jsonMaleArr = new JSONArray();
		JSONArray jsonFemaleArr = new JSONArray();
		int maxCount = dataAnMapper.getGenderAgeMaxCount(req.getParameter("qsetNo"));
		int maxCount2 = dataAnMapper.getGenderFemaleAgeMaxCount(req.getParameter("qsetNo"));
		for (HashMap<String, Object> map : hList) {
			JSONObject jsonObj = new JSONObject(map);
			jsonMaleArr.add(jsonObj);
		}
		for (HashMap<String, Object> map : hList2) {
			JSONObject jsonObj = new JSONObject(map);
			jsonFemaleArr.add(jsonObj);
		}
		model.addAttribute("jsonMaleArr",jsonMaleArr);
		model.addAttribute("jsonFemaleArr",jsonFemaleArr);
		model.addAttribute("maxCount",maxCount);
		model.addAttribute("maxCount2",maxCount2);
		return "/dataAn/chart/genderAgeChart";
	}
	
	

}
