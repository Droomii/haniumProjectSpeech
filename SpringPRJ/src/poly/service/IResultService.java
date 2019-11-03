package poly.service;

import poly.dto.ResultDTO;

public interface IResultService {

	int regResult(ResultDTO rDTO) throws Exception;

	String getTranscript(String answerNo) throws Exception;

	int updateMorpheme(ResultDTO uDTO) throws Exception;

	String getAllMorphemes(String qsetNo) throws Exception;

}
