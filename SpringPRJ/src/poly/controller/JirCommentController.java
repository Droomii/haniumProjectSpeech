package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.FeedbackCommentDTO;
import poly.dto.JirCommentDTO;
import poly.service.IJirCommentService;

@Controller
public class JirCommentController {
	
	public Logger log = Logger.getLogger(this.getClass().getName());
	
	@Resource(name = "JirCommentService")
	private IJirCommentService jirCommentService;
	
	@RequestMapping(value="jobIntrvReview/jirCommentInsert")
	public @ResponseBody void JirCommentReg(HttpSession session, HttpServletRequest request, JirCommentDTO jcDTO, Model model) throws Exception{
	
		log.info("reviewNo : " + jcDTO.getReviewNo());
		log.info("comment : " + jcDTO.getrCommenttext());
		log.info("regno : " + jcDTO.getrRegno());
		
		try {
			jirCommentService.jirCommentReg(jcDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		log.info(this.getClass().getName() + " end.");
	}
	
	@RequestMapping(value="jobIntrvReview/jirCommentEdit")
	public @ResponseBody void JirCommentEdit(HttpSession session, HttpServletRequest request, Model model, JirCommentDTO jcDTO) throws Exception{
		
		log.info(this.getClass().getName());
		
		log.info("rCommentNo : " + jcDTO.getrCommentNo());
		log.info("rCommenttext : " + jcDTO.getrCommenttext());
		log.info("rRegNo : " + jcDTO.getrRegno());
	
		try {
			jirCommentService.jirCommentEdit(jcDTO);
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			log.info(this.getClass().getName() + " successfully ended.");
		}
	}
	
	@RequestMapping(value="jobIntrvReview/jirCommentDelete")
	public @ResponseBody void JirCommentDel(HttpSession session, HttpServletRequest request, Model model, String rCommentNo) throws Exception{
		
		log.info(this.getClass().getName());
		log.info(rCommentNo);
		
		try {
			jirCommentService.jirCommentDel(rCommentNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			log.info(this.getClass().getName() + " successfully ended.");
		}
		
	}
	
	@RequestMapping(value="jobIntrvReview/jirCommentListPage")
	public String JirCommentListPage(HttpSession session, HttpServletRequest request, Model model, String reviewNo) throws Exception {
		
		log.info(reviewNo);
		log.info("start : "+ this.getClass().getName());
		
		List<JirCommentDTO> jcDTO = jirCommentService.jcList(reviewNo);
		
		log.info(jcDTO.size());
		
		model.addAttribute("jcDTO", jcDTO);
		
		log.info("end : " + this.getClass().getName());
		
		return "/jobIntrvReview/jirCommentList";
	}
}
