package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import config.Mapper;
import poly.dto.QSetDTO;

@Mapper("QSetMapper")
public interface QSetMapper {

	int insertQSet(QSetDTO qDTO) throws Exception;

	List<QSetDTO> getQSetList(int i) throws Exception;

	void viewcount(String qsetNo) throws Exception;

	QSetDTO getQSetDetail(String qsetNo) throws Exception;

	String getInterestName(String interestNo) throws Exception;

	List<HashMap<String, String>> getAllInterests() throws Exception;

}
