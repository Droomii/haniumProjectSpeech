package poly.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.QSetDTO;
import poly.service.IQSetService;

@Controller
public class QSetController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "QSetService")
	private IQSetService qSetService;
	
	
	
	
	// 짊문 세트 작성
	@RequestMapping(value="qset/CreateQSet")
	public String CreateQset() throws Exception{
		
		return "/qset/CreateQSet";
	}
	
	@RequestMapping(value="qset/SubmitQSet")
	public String SubmitQSet(HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session) throws Exception{
		String title = request.getParameter("qsetTitle");
		String desc = request.getParameter("qsetDesc");
		String content = request.getParameter("content");
		String interestNo = request.getParameter("interest");
		String userNo = (String)session.getAttribute("userNo");
		log.info("title : " + title);
		log.info("desc : " + desc);
		log.info("content : " + content);
		log.info("userNo : " + userNo);
		
		QSetDTO qDTO = new QSetDTO();
		
		qDTO.setQsetTitle(title);
		qDTO.setQsetDesc(desc);
		qDTO.setContent(content);
		qDTO.setRegNo(userNo);
		qDTO.setInterestNo(interestNo);
		
		int result = 0; 
		try {
			result = qSetService.insertQSet(qDTO);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		if (result > 0) {
			model.addAttribute("url", "/qset/QSetList.do");
			model.addAttribute("msg", "등록 성공");
		} else {
			model.addAttribute("url", "/qset/SubmitQSet.do");
			model.addAttribute("msg", "등록 실패");
		}
		
		return "/redirect";
	}
	
	//질문 세트 목록
	@RequestMapping(value="qset/QSetList")
	public String QSetList(HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session) throws Exception{
		List<QSetDTO> qList = new ArrayList<>();
		try {
			qList = qSetService.getQSetList(0);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		// 업종코드
		Map<String, String> interestMap = new HashMap<>();
		for(HashMap<String, String> interest: qSetService.getAllInterests()) {
			log.info(interest);
			interestMap.put(interest.get("key"), interest.get("value"));
		}
		log.info(interestMap);
		
		model.addAttribute("qList", qList);
		model.addAttribute("interestMap", interestMap);
		return "qset/QSetList";
	}
	
	// 질문 세트 추가로 불러오기
	@RequestMapping(value="qset/QSetLoadMore")
	public String QSetLoadMore(HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session) throws Exception{
		int i = Integer.parseInt(request.getParameter("page"));
		
		List<QSetDTO> qList = new ArrayList<>();
		try {
			qList = qSetService.getQSetList(i);
		} catch(Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("qList", qList);
		
		return "qset/QSetCard";
	}
	
	// 질문 세트 자세히 보기
	@RequestMapping(value="qset/QSetDetail")
	public String QSetDetail(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String qsetNo = request.getParameter("no");
		log.info("qsetNo : " + qsetNo);
		qSetService.viewcount(qsetNo);
		QSetDTO qDTO = new QSetDTO();
		
		try {
			qDTO = qSetService.getQSetDetail(qsetNo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String interestName;
		log.info("interestNo : " + qDTO.getInterestNo());
		if(qDTO.getInterestNo()==null) {
			interestName = "";
		}else {
			// 질문분야
			interestName = qSetService.getInterestName(qDTO.getInterestNo());
		}
		log.info("interestName : " + interestName);
		log.info("qset title : " + qDTO.getQsetTitle());
		model.addAttribute("interestName", interestName);
		model.addAttribute("qDTO", qDTO);
		return "qset/QSetDetail";
	}
	
	@RequestMapping(value="interview/Ready")
	public String Ready(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String qsetNo = request.getParameter("no");
		log.info("qsetNo : " + qsetNo);
		QSetDTO qDTO = new QSetDTO();
		
		try {
			qDTO = qSetService.getQSetDetail(qsetNo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		log.info("qset title : " + qDTO.getQsetTitle());
	
		model.addAttribute("qDTO", qDTO);

		return "interview/Ready";
	}
	
	@RequestMapping(value="interview/GetRandQ", produces="application/text;charset=utf8")
	@ResponseBody
	public String GetRandQ(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String qsetNo = request.getParameter("qsetNo");
		log.info("accessed getRandQ");
		log.info("qsetNo : " + qsetNo);
		QSetDTO qDTO = new QSetDTO();
		
		try {
			qDTO = qSetService.getQSetDetail(qsetNo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		log.info("qset title : " + qDTO.getQsetTitle());
		
		String[] splitQ = qDTO.getContent().split("`");
		int rand = (int)(Math.random() * splitQ.length);
		String randQ = splitQ[rand];
		log.info("random selected question :" + randQ);
		
		return randQ.replaceAll("& ", "&");
	}
	
}
