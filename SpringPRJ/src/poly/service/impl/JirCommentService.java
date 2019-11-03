package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.JirCommentDTO;
import poly.persistance.mapper.JirCommentMapper;
import poly.service.IJirCommentService;

@Service("JirCommentService")
public class JirCommentService implements IJirCommentService {

	@Resource(name="JirCommentMapper")
	private JirCommentMapper jirCommentMapper;
	
	@Override
	public List<JirCommentDTO> jcList(String reviewNo) throws Exception {
		return jirCommentMapper.jcList(reviewNo);
	}

	@Override
	public void jirCommentReg(JirCommentDTO jcDTO) throws Exception {
		jirCommentMapper.jirCommentReg(jcDTO);
	}

	@Override
	public void jirCommentEdit(JirCommentDTO jcDTO) throws Exception {
		jirCommentMapper.jirCommentEdit(jcDTO);
	}

	@Override
	public void jirCommentDel(String rCommentNo) throws Exception {
		jirCommentMapper.jirCommentDel(rCommentNo);
	}

}
