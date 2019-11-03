package poly.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.SaraminDTO;

@RequestMapping(value="/chatbot")
@Controller
public class ChatbotController {
   @Value("${saramin.apikey}")
   private String saraminApiKey;
   
   @RequestMapping(value="/view")
   public String view() throws Exception{
      return "/chatbot/chatbot";
   }
   //사람인 취업 정보 
   
   @RequestMapping(value="/saramin")
   public String saramin(SaraminDTO sDTO,Model model) throws Exception{
      try {
         System.out.println(sDTO.getKeyword());
         String url="http://oapi.saramin.co.kr/job-search?access-key="+saraminApiKey;
         String result="";
         BufferedReader br = null;
         if(sDTO.getKeyword()!=null&&sDTO.getBbs_gb()==null&&sDTO.getJob_type()==null&&sDTO.getEdulv()==null&&sDTO.getLoc_cd()==null&&sDTO.getJob_category()==null) {
            url+="&keyword="+sDTO.getKeyword();
         }
         if(sDTO.getKeyword()!=null&&sDTO.getBbs_gb()!=null&&sDTO.getJob_type()==null&&sDTO.getEdulv()==null&&sDTO.getLoc_cd()==null&&sDTO.getJob_category()==null) {
            url+="&keyword="+sDTO.getKeyword()+"&bbs_gb="+sDTO.getBbs_gb();
         }
         if(sDTO.getKeyword()!=null&&sDTO.getBbs_gb()!=null&&sDTO.getJob_type()!=null&&sDTO.getEdulv()==null&&sDTO.getLoc_cd()==null&&sDTO.getJob_category()==null) {
            url+="&keyword="+sDTO.getKeyword()+"&bbs_gb="+sDTO.getBbs_gb()+"&job_type="+sDTO.getJob_type();
         }
         if(sDTO.getKeyword()!=null&&sDTO.getBbs_gb()!=null&&sDTO.getJob_type()!=null&&sDTO.getEdulv()!=null&&sDTO.getLoc_cd()==null&&sDTO.getJob_category()==null) {
            url+="&keyword="+sDTO.getKeyword()+"&bbs_gb="+sDTO.getBbs_gb()+"&job_type="+sDTO.getJob_type()+"&edulv="+sDTO.getEdulv();
         }
         if(sDTO.getKeyword()!=null&&sDTO.getBbs_gb()!=null&&sDTO.getJob_type()!=null&&sDTO.getEdulv()!=null&&sDTO.getLoc_cd()!=null&&sDTO.getJob_category()==null) {
            url+="&keyword="+sDTO.getKeyword()+"&bbs_gb="+sDTO.getBbs_gb()+"&job_type="+sDTO.getJob_type()+"&edulv="+sDTO.getEdulv()+"&loc_cd="+sDTO.getLoc_cd();
         }
         if(sDTO.getKeyword()!=null&&sDTO.getBbs_gb()!=null&&sDTO.getJob_type()!=null&&sDTO.getEdulv()!=null&&sDTO.getLoc_cd()!=null&&sDTO.getJob_category()!=null) {
            url+="&keyword="+sDTO.getKeyword()+"&bbs_gb="+sDTO.getBbs_gb()+"&job_type="+sDTO.getJob_type()+"&edulv="+sDTO.getEdulv()+"&loc_cd="+sDTO.getLoc_cd()+"&job_category="+sDTO.getJob_category();
         }
         System.out.println("url : " + url);
         URL object=new URL(url);
         System.out.println("object : " + object);
           HttpURLConnection urlconnection  = (HttpURLConnection) object.openConnection();
           System.out.println("urlconnection" + urlconnection);
           urlconnection.setRequestMethod("GET");
           urlconnection.setRequestProperty("Accept", "application/json");
           String newUrl = urlconnection.getHeaderField("Location");
           urlconnection = (HttpURLConnection) new URL(newUrl).openConnection();
           int responseCode = urlconnection.getResponseCode();
           System.out.println(responseCode);
           br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8"));
           System.out.println(br);
           String line;
         while((line = br.readLine()) !=null){
            result = result+line+"\n";
         }
         System.out.println("result : " + result);
         //String 을 Json 으로 
         JSONParser parser = new JSONParser();
         Object obj = parser.parse(result);
         JSONObject jsonObj = (JSONObject) obj;
         //결과값 확인 
         System.out.println(jsonObj.get("jobs"));
         jsonObj =(JSONObject)jsonObj.get("jobs");
         System.out.println(jsonObj.get("total"));
         System.out.println(jsonObj.get("count"));
         System.out.println(jsonObj.get("start"));
         System.out.println(jsonObj.get("job"));
         JSONArray jsonArr = (JSONArray)jsonObj.get("job");
         HashMap<String, Object> hMap = new HashMap<>();
         hMap.put("total",jsonObj.get("total"));
         hMap.put("start",jsonObj.get("start"));
         hMap.put("count", jsonObj.get("count"));
         hMap.put("job", jsonObj.get("job"));
         model.addAttribute("hMap", hMap);
      } catch (Exception e) {
         // TODO: handle exception
      }
      
      return "/chatbot/saraminList";
   }
   
}