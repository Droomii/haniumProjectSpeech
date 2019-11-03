package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.ResultDTO;

@Mapper("myInfoMapper")
public interface MyInfoMapper {

	List<ResultDTO> getMySpeechAnswer(String userNo) throws Exception;

	ResultDTO getSpeechMaker(String qsetNo)  throws Exception;

	String getSpcAnswerCount(String qsetNo) throws Exception;


}
