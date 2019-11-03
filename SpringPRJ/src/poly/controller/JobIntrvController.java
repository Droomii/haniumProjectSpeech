package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.JobIntrvReviewDTO;
import poly.service.IJobIntrvReviewService;

@Controller
public class JobIntrvController {

	private Logger log = Logger.getLogger(this.getClass().getName());

	@Resource(name="JobIntrvReviewService")
	private IJobIntrvReviewService jirService;
	
	@RequestMapping(value="/jobIntrvReview/jirList")
	public String ReviewList(Model model) { //model에 담아서 jsp로 보낼 것임
		
		List<JobIntrvReviewDTO> jirList = new ArrayList<>();
		 
		try {
			jirList = jirService.getReviewList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			log.info("succeed!");
			model.addAttribute("jirList", jirList);
		}
		
		
		return "/jobIntrvReview/jirList";
		
	}
	
	@RequestMapping(value="/jobIntrvReview/jirDetail")
	public String ReviewDetail(HttpServletRequest request, Model model) throws Exception {
		String reviewNo = request.getParameter("reviewNo");
		
		JobIntrvReviewDTO jirDTO = new JobIntrvReviewDTO();
		
		try {
			jirDTO = jirService.getReviewDetail(reviewNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			log.info("succeed!");
		}
		
		model.addAttribute("jirDTO", jirDTO);
		
		return "/jobIntrvReview/jirDetail";
		
	}
	
	@RequestMapping(value="/jobIntrvReview/jirReg")
	public String ReviewReg() {
		
		return "/jobIntrvReview/jirReg";
	}
	
	@RequestMapping(value="/jobIntrvReview/jirRegProc")
	public String ReviewRegProc(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		String newTitle = (String)request.getParameter("reviewTitle");
		String newContent = (String)request.getParameter("reviewContent");
		String reviewWriter = (String)session.getAttribute("userNo");
		
		JobIntrvReviewDTO jirDTO = new JobIntrvReviewDTO();
		jirDTO.setReviewTitle(newTitle);
		jirDTO.setReviewContent(newContent);
		jirDTO.setReviewWriter(reviewWriter);
		
		int result = 0;
		
		try {
			result = jirService.insertReview(jirDTO);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		if(result>0) {
			log.info("succeed!");
			model.addAttribute("msg", "후기가 등록되었습니다!");
			model.addAttribute("url", "/jobIntrvReview/jirList.do");
		} else {
			model.addAttribute("msg", "후기 등록 실패");
			model.addAttribute("url", "/jobIntrvReview/jirReg.do");
		} 
		
		return "/redirect";
	}
	
	@RequestMapping(value="/jobIntrvReview/jirModify")
	public String ReviewModify(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		
		String reviewNo = request.getParameter("reviewNo");
		
		JobIntrvReviewDTO jirDTO = new JobIntrvReviewDTO();
		
		try {
			jirDTO = jirService.getReviewDetail(reviewNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			log.info("succeed!");
		}
		
		model.addAttribute("jirDTO", jirDTO);
		
		return "/jobIntrvReview/jirModify";
	}
	
	@RequestMapping(value="/jobIntrvReview/jirModifyProc")
	public String ReviewModifyProc(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		String modifiedTitle = request.getParameter("reviewTitle");
		String modifiedContent = request.getParameter("reviewContent");
		String modifiedReviewNo = request.getParameter("reviewNo");
		
		JobIntrvReviewDTO jirDTO = new JobIntrvReviewDTO();
		jirDTO.setReviewTitle(modifiedTitle);
		jirDTO.setReviewContent(modifiedContent);
		jirDTO.setReviewNo(modifiedReviewNo);
		
		int result = 0;
		
		try {
			result = jirService.updateReview(jirDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result>0) {
			log.info("succeed!");
			model.addAttribute("msg", "후기가 수정되었습니다!");
			model.addAttribute("url", "/jobIntrvReview/jirList.do");
		} else {
			model.addAttribute("msg", "후기 수정 실패");
			model.addAttribute("url", "/jobIntrvReview/jirModify.do");
		} 
		
		return "/redirect";
	}
	
	@RequestMapping(value="/jobIntrvReview/jirDelete")
	public String ReviewDelete(HttpServletRequest request, Model model) {
		String targetReviewNo = request.getParameter("reviewNo");
		
		int result = 0;
		
		try {
			result = jirService.deleteReview(targetReviewNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result>0) {
			log.info("succeed!");
			model.addAttribute("msg", "후기가 삭제되었습니다.");
			model.addAttribute("url", "/jobIntrvReview/jirList.do");
		} else {
			model.addAttribute("msg", "후기 삭제 실패");
			model.addAttribute("url", "/jobIntrvReview/jirDetail.do?reviewNo="+targetReviewNo);
		} 
		
		return "/redirect";
	}
}
