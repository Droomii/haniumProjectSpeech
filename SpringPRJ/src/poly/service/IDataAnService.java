package poly.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import poly.dto.ResultDTO;

public interface IDataAnService {

	List<HashMap<String, String>> getStutterAnalysis(ResultDTO rDTO) throws Exception;

	Map<String, String> highlightStutter(String transcript) throws Exception;

}
