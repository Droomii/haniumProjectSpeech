package poly.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class WebmToOgg {
	public static String webmToOgg(String filePath) throws IOException {
		
		String mkvextract = "c:\\mkvtool\\mkvextract.exe ";

		String input = filePath + ".webm";
		String tracks = "tracks";
		String output = "0:" + filePath + ".ogg";

		ProcessBuilder pb = new ProcessBuilder();
		pb.command(mkvextract, input, tracks, output);
		pb.redirectErrorStream(true);
	    Process process = pb.start();

	    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
	    String line = null;
	    String fullLine = "";
	    while ((line = reader.readLine()) != null) {
	        fullLine += line;
	    }
	    return fullLine;
	    
	}
	
	public static String test() throws IOException{
		Resource resource = new ClassPathResource("classpath.txt", WebmToOgg.class);
		File file = resource.getFile();
		String path = file.getPath();
		return path;
	}
	
	
	public static void main(String[] args) {
		String filePath = new File("").getAbsolutePath();
		String mkvextract = filePath + "\\src\\poly\\util\\mkvextract.exe";
		List<String> command = new ArrayList<>();
		Resource resource = new ClassPathResource("/application/context/references/user/user.xml");
	}
}
