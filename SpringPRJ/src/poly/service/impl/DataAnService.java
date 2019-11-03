package poly.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.ResultDTO;
import poly.persistance.mapper.DataAnMapper;
import poly.service.IDataAnService;
import poly.util.SpeechUtil;

@Service("DataAnService")
public class DataAnService implements IDataAnService{
	
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="dataAnMapper")
	private DataAnMapper dataAnMapper;

	@Override
	public List<HashMap<String, String>> getStutterAnalysis(ResultDTO rDTO) throws Exception{

		if(rDTO==null) {
			log.info("rDTO is EMPTY!!");
		}else {
			log.info("words list : " + rDTO.getWord());
		}
		// 결과값들 파싱(큰따옴표 제거, 양 끝 대괄호 제거
		List<String> wordsList = SpeechUtil.parseResult(rDTO.getWord());
		List<String> startTimeList = SpeechUtil.parseResult(rDTO.getStartTime());
		List<String> endTimeList = SpeechUtil.parseResult(rDTO.getEndTime());
		List<String> termList = SpeechUtil.parseResult(rDTO.getTerm());
		
		// 더듬은 단어와 구간 저장하는 리스트
		List<HashMap<String, String>> detectedList = new ArrayList<>();
		
		// 더듬은 구간 찾아내기
		HashMap<String, String> dMap;
		
		for(int i=0;; i++) {
			try {
				if(wordsList.get(i).matches("^것$")) {
					for(String stutterWord2: SpeechUtil.UNCONFIDENT) {
						if(wordsList.get(i+1).matches(stutterWord2)) {
							log.info("것 시작: " + startTimeList.get(i));
							log.info("같습니다 시작: " + startTimeList.get(i+1));
							log.info("것 끝: " + endTimeList.get(i));
							log.info("같습니다 끝: " + endTimeList.get(i+1));
							dMap = new HashMap<>();
							dMap.put("word", wordsList.get(i)+" "+wordsList.get(i+1));
							dMap.put("startTime", startTimeList.get(i));
							dMap.put("endTime", endTimeList.get(i+1));
							float totalTerm = Float.parseFloat(termList.get(i)) + Float.parseFloat(termList.get(i+1)); 
							dMap.put("term", Float.toString(totalTerm));
							
							detectedList.add(dMap);
							i += 2;
							dMap = null;
							break;
						}
					}
				}
				
				for(String stutterWord: SpeechUtil.LACK_OF_EXPR) {
					if(wordsList.get(i).matches(stutterWord)) {
						dMap = new HashMap<>();
						// 단어, 시작 시간, 구간 길이 저장
						dMap.put("word", wordsList.get(i));
						dMap.put("startTime", startTimeList.get(i));
						dMap.put("endTime", endTimeList.get(i));
						dMap.put("term", termList.get(i));
						
						detectedList.add(dMap);
						dMap = null;
						i++;
						break;
					}
				}
				for(String stutterWord: SpeechUtil.VAGUE) {
					if(wordsList.get(i).matches(stutterWord)) {
						dMap = new HashMap<>();
						// 단어, 시작 시간, 구간 길이 저장
						dMap.put("word", wordsList.get(i));
						dMap.put("startTime", startTimeList.get(i));
						dMap.put("endTime", endTimeList.get(i));
						dMap.put("term", termList.get(i));
						
						detectedList.add(dMap);
						dMap = null;
						i++;
						break;
					}
				}
				for(String stutterWord: SpeechUtil.BAD_HABIT) {
					if(wordsList.get(i).matches(stutterWord)) {
						dMap = new HashMap<>();
						// 단어, 시작 시간, 구간 길이 저장
						dMap.put("word", wordsList.get(i));
						dMap.put("startTime", startTimeList.get(i));
						dMap.put("endTime", endTimeList.get(i));
						dMap.put("term", termList.get(i));
						
						detectedList.add(dMap);
						dMap = null;
						i++;
						break;
					}
				}
				for(String stutterWord: SpeechUtil.INFORMAL) {
					if(wordsList.get(i).matches(stutterWord)) {
						dMap = new HashMap<>();
						// 단어, 시작 시간, 구간 길이 저장
						dMap.put("word", wordsList.get(i));
						dMap.put("startTime", startTimeList.get(i));
						dMap.put("endTime", endTimeList.get(i));
						dMap.put("term", termList.get(i));
						
						detectedList.add(dMap);
						dMap = null;
						i++;
						break;
					}
				}
			}catch(IndexOutOfBoundsException e) {
				break;
			}
		}
		return detectedList;
	}

	@Override
	public Map<String, String> highlightStutter(String words) throws Exception {
		
		ArrayList<String> wordsList = new ArrayList<>(SpeechUtil.parseResult(words));
		
		Map<String, String> rMap = new HashMap<>();
		rMap.put("unconfident", "");
		rMap.put("lackOfExpr", "");
		rMap.put("vague", "");
		rMap.put("badHabit", "");
		rMap.put("informal", "");
		
		// 습관어 감지 로직
		int stutterIndex = 0;
		for(int i=0;; i++) {
			try {
				
				if(wordsList.get(i).matches("^것$")) {
					for(String stutterWord2: SpeechUtil.UNCONFIDENT) {
						if(wordsList.get(i+1).matches(stutterWord2)) {
							wordsList.set(i, "<span class=\"bg-danger unconfident bg-lighten-4\" id=\"stutter" 
						+ Integer.toString(stutterIndex++) + "\">것 "+wordsList.get(i+1)+"</span>");
							wordsList.remove(i+1);
							i++;
							rMap.put("unconfident", "1");
							break;
						}
					}
				}
				
				for(String stutterWord: SpeechUtil.VAGUE) {
					if(wordsList.get(i).matches(stutterWord)) {
						 wordsList.set(i, "<span class=\"bg-danger vague bg-lighten-4\" id=\"stutter"
								 + Integer.toString(stutterIndex++) + "\">"+wordsList.get(i)+"</span>");
						 rMap.put("vague", "1");
						 i++;
						 break;
					}
				}
				for(String stutterWord: SpeechUtil.BAD_HABIT) {
					if(wordsList.get(i).matches(stutterWord)) {
						 wordsList.set(i, "<span class=\"bg-danger bad-habit bg-lighten-4\" id=\"stutter"
								 + Integer.toString(stutterIndex++) + "\">"+wordsList.get(i)+"</span>");
						 rMap.put("badHabit", "1");
						 i++;
						 break;
					}
				}
				for(String stutterWord: SpeechUtil.INFORMAL) {
					if(wordsList.get(i).matches(stutterWord)) {
						 wordsList.set(i, "<span class=\"bg-danger informal bg-lighten-4\" id=\"stutter"
								 + Integer.toString(stutterIndex++) + "\">"+wordsList.get(i)+"</span>");
						 rMap.put("informal", "1");
						 i++;
						 break;
					}
				}
				for(String stutterWord: SpeechUtil.LACK_OF_EXPR) {
					if(wordsList.get(i).matches(stutterWord)) {
						 wordsList.set(i, "<span class=\"bg-danger lack-of-expr bg-lighten-4\" id=\"stutter"
								 + Integer.toString(stutterIndex++) + "\">"+wordsList.get(i)+"</span>");
						 rMap.put("lackOfExpr", "1");
						 i++;
						 break;
					}
				}
			}catch(IndexOutOfBoundsException e) {
				break;
			}
		}
		
		String[] wordArray = wordsList.toArray(new String[0]);
		String joinedWord =  String.join(" ", wordArray);
		rMap.put("result", joinedWord);
		
		return rMap;
	}
}
