package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.DataAnDTO;
import poly.dto.ResultDTO;

@Mapper("dataAnMapper")
public interface DataAnMapper {

	DataAnDTO getTranscript(DataAnDTO dDTO) throws Exception;

	ResultDTO getDataSingle(ResultDTO rDTO) throws Exception;

	//Etri controller
	List<ResultDTO> getAnswerQsetNoList(ResultDTO rDTO) throws Exception;

	ResultDTO getStutterAnalysis(ResultDTO rDTO) throws Exception;

	List<HashMap<String, Object>> getDataGenderAgeCount(String parameter) throws Exception;

	int getGenderAgeMaxCount(String parameter) throws Exception ;

	List<HashMap<String, Object>> getDataFemaleGenderAgeCount(String parameter)throws Exception;

	int getGenderFemaleAgeMaxCount(String parameter);

}
