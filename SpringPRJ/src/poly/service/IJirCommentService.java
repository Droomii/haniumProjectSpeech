package poly.service;

import java.util.List;

import poly.dto.JirCommentDTO;

public interface IJirCommentService {

	List<JirCommentDTO> jcList(String reviewNo) throws Exception;

	void jirCommentReg(JirCommentDTO jcDTO) throws Exception;

	void jirCommentEdit(JirCommentDTO jcDTO) throws Exception;

	void jirCommentDel(String rCommentNo) throws Exception;

}
