package poly.controller;

import java.io.File;
import java.util.Base64;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.ResultDTO;
import poly.persistance.mapper.ResultMapper;
import poly.service.IResultService;
import poly.util.SpeechRecognition;
import poly.util.WebmToOgg;

@Controller
public class ResultController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "ResultService")
	private IResultService resultService;
	
	@Resource(name="ResultMapper")
	private ResultMapper resultMapper;

	@ResponseBody
	@RequestMapping(value = "result/analyzeAudio", produces = "application/text;charset=utf8")
	public String analyzeAudio(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session) throws Exception {
		log.info("access analyzeAudio");
		String blob = request.getParameter("data");
		String mimeType = request.getParameter("mimeType");
		String qsetNo = request.getParameter("qsetNo");
		String question = request.getParameter("randQ");
		String userNo = (String) session.getAttribute("userNo");
		log.info("mimetype : " + mimeType);

		byte[] decodedBytes = Base64.getDecoder().decode(blob.split(",")[1]);

		HashMap<String, String> rMap = null;
		String filePath = "c:\\tempAudio\\output";
		if (mimeType.contains("webm")) {

			log.info("File path : " + filePath);
			FileUtils.writeByteArrayToFile(new File(filePath + ".webm"), decodedBytes);
			log.info("command : " + WebmToOgg.webmToOgg(filePath));
			rMap = SpeechRecognition.syncRecognizeFile(filePath + ".ogg");
		} else {
			rMap = SpeechRecognition.RecognizeBlob(blob);
		}
		
		ResultDTO rDTO = new ResultDTO();
		rDTO.setResult(rMap);
		rDTO.setFileNo(null);
		rDTO.setQsetNo(qsetNo);
		rDTO.setQuestion(question);
		rDTO.setUserNo(userNo);
		log.info("transcript : " + rMap.get("transcript"));
		log.info("confidence : " + rMap.get("confidence"));
		log.info("word : " + rMap.get("word"));
		log.info("startTime : " + rMap.get("startTime"));
		log.info("endTime : " + rMap.get("endTime"));
		log.info("term : " + rMap.get("term"));

		String msg;

		resultService.regResult(rDTO);
		String answerNo = rDTO.getAnswerNo();
		if (answerNo == null) {
			msg = "0";
		} else {
			msg = answerNo;
		}
		return msg;

	}
	
	@RequestMapping(value="result/getMorpheme", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getMorpheme(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session) throws Exception {
		String result = resultMapper.getMorpheme(request.getParameter("answerNo"));
		log.info("getMorpheme : " + result);
		return result;
	}
	
	@RequestMapping(value="result/getAllMorphemes", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getAllMorphemes(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session) throws Exception {
		
		String result=  "[" +resultService.getAllMorphemes(request.getParameter("qsetNo"))+ "]";
		return result;
	}
}
