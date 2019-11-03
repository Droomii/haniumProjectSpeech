package poly.util;

import java.util.Arrays;
import java.util.List;

public class SpeechUtil {
//	public static final String[] STUTTER_WORDS = {
//			"^이제$",
//			"^그$",
//			"^어$",
//			"^음$",
//			"^뭐지$",
//			"^뭐냐$",
//			"^사실$",
//			"^아니$",
//			"^그런데$",
//			"^근데$",
//			"^그니까$",
//			"^그러니까$",
//			"^그래서$",
//			"^아$",
//			"^완전$",
//			"^솔직히$",
//			"^진짜$",
//			"^막$",
//			"^좀$",
//			"^조금$",
//			"^네$",
//			"^여러가지$",
//			"^다양한$",
//			"^이것저것$",
//			"[가-힣]*어요$",
//			"[가-힣]*아요$",
//			"[가-힣]*라요$",
//			"[가-힣]*든요$",
//			"[가-힣]*거든",
//			"[가-힣]*예요$",
//			"[가-힣]*에요$"};
	
	// 표현력 부족
	public static final String[] LACK_OF_EXPR = {
			"^완전$",
			"^솔직히$",
			"^진짜$",
			"^매우$",
			"^엄청$"
	};
	
	// 모호한 표현
	public static final String[] VAGUE = {
			"^여러가지$",
			"^다양한$",
			"^이것저것$"
	};
	
	// 습관적인 말
	public static final String[] BAD_HABIT = {
			"^이제$",
			"^그$",
			"^어$",
			"^음$",
			"^뭐지$",
			"^뭐냐$",
			"^아$",
			"^막$",
			"^좀$",
			"^조금$",
			"^네$",
			"^아니$",
			"^그런데$",
			"^근데$",
			"^그니까$",
			"^그러니까$",
			"^그래서$"
	};
	
	// 자신감 없어보임
	public static final String[] UNCONFIDENT = {
			"같습니다",
			"같아요", 
			"같거든요", 
			"같은데", 
			"같은데요"
	};
	
	// 비격식체
	public static final String[] INFORMAL = {
			"[가-힣]*어요$",
			"[가-힣]*아요$",
			"[가-힣]*라요$",
			"[가-힣]*든요$",
			"[가-힣]*거든",
			"[가-힣]*예요$",
			"[가-힣]*에요$"
	};
	
	public static List<String> parseResult(String result){
		String[] splitResult = result.replaceAll("[\\[\\]\"\\s]", "").split(",");
		
		List<String> rList = Arrays.asList(splitResult);
		
		return rList;
	}
}
