package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.JirCommentDTO;

@Mapper("JirCommentMapper")
public interface JirCommentMapper {

	List<JirCommentDTO> jcList(String reviewNo) throws Exception;

	void jirCommentReg(JirCommentDTO jcDTO) throws Exception;

	void jirCommentEdit(JirCommentDTO jcDTO) throws Exception;

	void jirCommentDel(String rCommentNo) throws Exception;

}
