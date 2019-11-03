package poly.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.QSetDTO;
import poly.persistance.mapper.QSetMapper;
import poly.service.IQSetService;

@Service("QSetService")
public class QSetService implements IQSetService {
	
	@Resource(name="QSetMapper")
	private QSetMapper qSetMapper;

	@Override
	public int insertQSet(QSetDTO qDTO) throws Exception {
		return qSetMapper.insertQSet(qDTO);
	}

	@Override
	public List<QSetDTO> getQSetList(int i) throws Exception {
		return qSetMapper.getQSetList(i);
	}

	@Override
	public void viewcount(String qsetNo) throws Exception {
		qSetMapper.viewcount(qsetNo);
		
	}

	@Override
	public QSetDTO getQSetDetail(String qsetNo) throws Exception {
		return qSetMapper.getQSetDetail(qsetNo);
	}

	@Override
	public String getInterestName(String interestNo) throws Exception {
		return qSetMapper.getInterestName(interestNo);
	}

	@Override
	public List<HashMap<String, String>> getAllInterests() throws Exception {
		return qSetMapper.getAllInterests();
	}
	

}
