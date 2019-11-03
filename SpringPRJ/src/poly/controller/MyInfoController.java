package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.ResultDTO;
import poly.dto.UserDTO;
import poly.persistance.mapper.MyInfoMapper;

@RequestMapping(value="/myInfo")
@Controller
public class MyInfoController {
	@Resource(name="myInfoMapper")
	private MyInfoMapper myInfoMapper;
	@RequestMapping(value="/mySpeechReport")
	public String mySpeechReport(HttpServletRequest req,Model model) throws Exception{
		List<ResultDTO> mySpeechList = new ArrayList<>();
		ResultDTO speechMaker;
		String spcAnswerCount="";
		List<ResultDTO> speechMakers = new ArrayList<>();
		List<String> spcAnswerCounts = new ArrayList<>();
		//유저번호를 변수로 넣어야됨 req.getParameter("userNo");
	
		mySpeechList = myInfoMapper.getMySpeechAnswer(req.getParameter("userNo"));
		for(int i = 0 ; i<mySpeechList.size();i++) {
			speechMaker = myInfoMapper.getSpeechMaker(mySpeechList.get(i).getQsetNo());
			System.out.println(speechMaker);
			speechMakers.add(speechMaker);
		}
		//답변수
		for(int i = 0 ; i<mySpeechList.size();i++) {
			spcAnswerCount = myInfoMapper.getSpcAnswerCount(mySpeechList.get(i).getQsetNo());
			spcAnswerCounts.add(spcAnswerCount);
		}
		model.addAttribute("mySpeechList",mySpeechList);
		model.addAttribute("speechMakers",speechMakers);
		model.addAttribute("spcAnswerCounts",spcAnswerCounts);
		return "/myInfo/mySpeechReport";
	}
}
