package poly.dto;

import java.util.HashMap;

public class ResultDTO {
	private String userNo;
	private String answerNo;
	private String question;
	private String transcript;
	private String confidence;
	private String fileNo;
	private String word;
	private String startTime;
	private String endTime;
	private String qsetNo;
	private String term;
	private String speechMakerName;
	private String morpheme;
	
	public String getMorpheme() {
		return morpheme;
	}
	public void setMorpheme(String morpheme) {
		this.morpheme = morpheme;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getSpeechMakerName() {
		return speechMakerName;
	}
	public void setSpeechMakerName(String speechMakerName) {
		this.speechMakerName = speechMakerName;
	}
	public String getAnswerNo() {
		return answerNo;
	}
	public void setAnswerNo(String answerNo) {
		this.answerNo = answerNo;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getTranscript() {
		return transcript;
	}
	public void setTranscript(String transcript) {
		this.transcript = transcript;
	}
	public String getConfidence() {
		return confidence;
	}
	public void setConfidence(String confidence) {
		this.confidence = confidence;
	}
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getQsetNo() {
		return qsetNo;
	}
	public void setQsetNo(String qsetNo) {
		this.qsetNo = qsetNo;
	}
	
	public void setResult(HashMap<String, String> rMap) {
		this.setTranscript(rMap.get("transcript"));
		this.setConfidence(rMap.get("confidence"));
		this.setWord(rMap.get("word"));
		this.setStartTime(rMap.get("startTime"));
		this.setEndTime(rMap.get("endTime"));
		this.setTerm(rMap.get("term"));
	}
	
}
