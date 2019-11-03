package poly.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import poly.dto.ResultDTO;
import poly.persistance.mapper.ResultMapper;
import poly.service.IResultService;

@Service("ResultService")
public class ResultService implements IResultService {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "ResultMapper")
	private ResultMapper resultMapper;

	@Override
	public int regResult(ResultDTO rDTO) throws Exception {
		return resultMapper.regResult(rDTO);

	}

	@Override
	public String getTranscript(String answerNo) throws Exception {

		return resultMapper.getTranscript(answerNo);
	}

	@Override
	public int updateMorpheme(ResultDTO uDTO) throws Exception {
		return resultMapper.updateMorpheme(uDTO);
	}

	@Override
	@ResponseBody
	public String getAllMorphemes(String qsetNo) throws Exception {
		log.info(this.getClass().getName() + ".getAllMorphemes start!!");
		
		// json 파싱용
		ObjectMapper objMapper = new ObjectMapper();
		
		// 모든 형태소 가져오기
		ArrayList<String> morphemes = resultMapper.getAllMorphemes(qsetNo);
		
		// 형태소 해시맵 담아둘 리스트
		List<HashMap<String, Object>> morphMapList = new ArrayList<>();
		
		// 형태소 담아둘 해시맵
		HashMap<String, Object> morphMap = null;
		
		// 콤마 기준으로 스플릿해둔 형태소  문자열 합쳐서 여기에 저장 
		List<String> morphemeList = null;
		
		// 형태소 문자열로 루프 돌림
		for (String morpheme : morphemes) {
			
			// 형태소 담아둘 해시맵 초기화
			morphMap = new HashMap<String, Object>();
			
			// 문자열로 된 형태소 담아둘 리스트 초기화
			morphemeList = new ArrayList<>();
			
			// 양 끝에 대괄호 없애고 콤마 기준으로 스플릿
			// 이렇게 하면 "{aaa:111,", "bbb:222}" 형태로 나눠짐
			String[] morphemeSplit = morpheme.substring(1, morpheme.length()-1).split(",");
			
			// 나눈 형태소 두개씩 합쳐서 형태소 리스트에 넣어줌
			for(int i=0; i<morphemeSplit.length;i+=2) {
				// "{aaa:111,bbb:222}" 형태로 저장됨
				morphemeList.add(morphemeSplit[i] + ","+morphemeSplit[i+1]);
			}
			
			// 문자열로 된 형태소를 맵 형태로 파싱하여 morphMapList에 담아둠
			for(String morphemeStr : morphemeList) {
				morphMap = objMapper.readValue(morphemeStr, 
						new TypeReference<Map<String, Object>>() {});
				log.info("morphMap : " + morphMap.toString());
				morphMapList.add(morphMap);
				morphMap = null;
			}
			
			morphemeList = null;
			
		}
		
		// 같은 형태소들 묶어서 총합 계산
		Map<String, Integer> morphSum = new HashMap<>();
		for(HashMap<String, Object> mMap : morphMapList) {
			if(mMap.get("tag").equals("것")) {
	    		continue;
	    	}
			
			morphSum.put((String)mMap.get("tag"), 
					morphSum.getOrDefault(mMap.get("tag"), Integer.valueOf(0)) 
					+ (Integer)mMap.get("weight"));
		}
		log.info("morphSum : " + morphSum);
		
		// {weight=1, tag=단어} 형태의 해시맵으로 변환하여 finalList에 추가
		List<HashMap<String, Object>> finalList = new ArrayList<>();
		morphSum.forEach((k, v) -> {
			HashMap<String,Object> finalMap = new HashMap<>();
			finalMap.put("weight", v);
			finalMap.put("tag", k);
			finalList.add(finalMap);
			finalMap = null;
		});
		log.info("finalList : " + finalList.toString());
		
		// {"weight":1,"tag":"와이어"},{"weight":2,"tag":"카메라"} 이와 같이 JSON 형식 문자열로 변환  
		String tempStr = "";
		for(HashMap<String, Object> finalMap : finalList) {
	    	String weight = Integer.toString((Integer)finalMap.get("weight"));
	    	tempStr += "{\"weight\":" + weight +","
	    			+"\"tag\":\""+ (String)finalMap.get("tag") + "\"},";
	    }
		
		log.info("finalJSONString : " + tempStr);
		
		
		return tempStr;
	}
}
