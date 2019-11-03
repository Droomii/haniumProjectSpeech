package poly.persistance.mapper;

import java.util.ArrayList;

import config.Mapper;
import poly.dto.ResultDTO;

@Mapper("ResultMapper")
public interface ResultMapper {

	int regResult(ResultDTO rDTO) throws Exception;

	String getTranscript(String answerNo) throws Exception;

	int updateMorpheme(ResultDTO uDTO) throws Exception;

	String getMorpheme(String answerNo) throws Exception;

	ArrayList<String> getAllMorphemes(String qsetNo) throws Exception;

	String getWholeConfidence(String qsetNo);

}
