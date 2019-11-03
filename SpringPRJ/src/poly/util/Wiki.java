package poly.util;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

public class Wiki {
	 
	public String SearchWord(String word) {
		String openApiURL = "http://aiopen.etri.re.kr:8000/WikiQA";
		String accessKey = "14ee6f69-451b-4555-9807-a0d84683c6b5";	// 발급받은 API Key
		String type = "hybridqa";	// 분석할 문단 데이터
		/*irqa: 언어분석 기반과 기계독해 기반의 질의응답을 통합한 질의응답 방식
		kbqa: 지식베이스 기반의 질의응답 방식
		hybridqa: irqa와 kbqa를 통합한 질의응답 방식*/
		String question = word;		// 질문 데이터
		Gson gson = new Gson();
	 
		Map<String, Object> request = new HashMap<>();
		Map<String, String> argument = new HashMap<>();
	 
		argument.put("question", question);
		argument.put("type", type);
	 
		request.put("access_key", accessKey);
		request.put("argument", argument);
	 
	 
		URL url;
		Integer responseCode = null;
		String responBody = null;
		try {
			url = new URL(openApiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
 
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.write(gson.toJson(request).getBytes("UTF-8"));
			wr.flush();
			wr.close();
 
			responseCode = con.getResponseCode();
			InputStream is = con.getInputStream();
			byte[] buffer = new byte[is.available()];
			int byteRead = is.read(buffer);
			responBody = new String(buffer);
 
			System.out.println("[responseCode] " + responseCode);
			System.out.println("[responBody]");
			System.out.println(responBody);
	 
		} catch (MalformedURLException e) {
				e.printStackTrace();
		} catch (IOException e) {
				e.printStackTrace();
		}
		return responBody;
	}
}
