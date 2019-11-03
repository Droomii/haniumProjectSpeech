package poly.util;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;

import com.google.cloud.speech.v1.RecognitionAudio;
import com.google.cloud.speech.v1.RecognitionConfig;
import com.google.cloud.speech.v1.RecognitionConfig.AudioEncoding;
import com.google.cloud.speech.v1.RecognizeResponse;
import com.google.cloud.speech.v1.SpeechClient;
import com.google.cloud.speech.v1.SpeechRecognitionAlternative;
import com.google.cloud.speech.v1.SpeechRecognitionResult;
import com.google.cloud.speech.v1.WordInfo;
import com.google.protobuf.ByteString;

public class SpeechRecognition {
	/**
	 * Performs speech recognition on raw PCM audio and prints the transcription.
	 *
	 * @param fileName the path to a PCM audio file to transcribe.
	 */
	public static HashMap<String, String> syncRecognizeFile(String fileName) throws Exception {
		try (SpeechClient speech = SpeechClient.create()) {
			System.out.println("starting");
			Path path = Paths.get(fileName);
			byte[] data = Files.readAllBytes(path);
			ByteString audioBytes = ByteString.copyFrom(data);
			System.out.println("read complete");
			// Configure request with local raw PCM audio
			RecognitionConfig config = RecognitionConfig.newBuilder().setEncoding(AudioEncoding.OGG_OPUS)
					.setLanguageCode("ko-KR").setSampleRateHertz(48000).setEnableWordTimeOffsets(true).build();
			System.out.println("config complete");
			RecognitionAudio audio = RecognitionAudio.newBuilder().setContent(audioBytes).build();

			// Use blocking call to get audio transcript
			RecognizeResponse response = speech.recognize(config, audio);
			List<SpeechRecognitionResult> results = response.getResultsList();
			HashMap<String, String> rMap = new HashMap<>();

			String sentence = "";
			for (SpeechRecognitionResult result : results) {
				// There can be several alternative transcripts for a given chunk of speech.
				// Just use the
				// first (most likely) one here.

				SpeechRecognitionAlternative alternative = result.getAlternativesList().get(0);

				// confidence
				rMap.put("confidence", Float.toString(Math.round(alternative.getConfidence() * 10000) / 10000.0f));

				// transcript
				rMap.put("transcript", alternative.getTranscript());

				// WordInfo
				List<WordInfo> wordInfos = alternative.getWordsList();

				List<String> word = new ArrayList<>();
				List<String> startTime = new ArrayList<>();
				List<String> endTime = new ArrayList<>();
				List<String> term = new ArrayList<>();
				
				
				for (WordInfo wordInfo : wordInfos) {
					
					// start, end time
					long startTimeSec = wordInfo.getStartTime().getSeconds();
					float startTimeNano = (float)wordInfo.getStartTime().getNanos() / 1000000000;
					long endTimeSec = wordInfo.getEndTime().getSeconds();
					float endTimeNano = (float)wordInfo.getEndTime().getNanos() / 1000000000;
					float startTimeValue = startTimeSec + startTimeNano;
					float endTimeValue = endTimeSec + endTimeNano;
					float termValue = Math.round((endTimeValue - startTimeValue) * 10) / 10.0f;
					
					
					System.out.println("word : " +wordInfo.getWord());
					System.out.println("starttime : " + startTimeValue);
					System.out.println("endtime : " +endTimeValue);
					System.out.println("term : " +termValue);
					System.out.println();
					
					
					word.add("\"" + wordInfo.getWord()+"\"");
					startTime.add("\"" +Float.toString(startTimeValue)+ "\"");
					endTime.add("\"" + Float.toString(endTimeValue) + "\"");
					term.add("\"" + Float.toString(termValue) + "\"");
					
				}

				rMap.put("word", word.toString());
				rMap.put("startTime", startTime.toString());
				rMap.put("endTime", endTime.toString());
				rMap.put("term", term.toString());

				sentence += alternative.getTranscript();
			}
			System.out.println("sentence: " + sentence);
			return rMap;
		}
	}

	public static HashMap<String, String> RecognizeBlob(String blob) throws Exception {
		try (SpeechClient speech = SpeechClient.create()) {
			byte[] decodedBytes = Base64.getDecoder().decode(blob.split(",")[1]);

			ByteString audioBytes = ByteString.copyFrom(decodedBytes);
			System.out.println();
			// Configure request with local raw PCM audio
			RecognitionConfig config = RecognitionConfig.newBuilder().setEncoding(AudioEncoding.OGG_OPUS)
					.setLanguageCode("ko-KR").setSampleRateHertz(48000).setEnableWordTimeOffsets(true).build();
			RecognitionAudio audio = RecognitionAudio.newBuilder().setContent(audioBytes).build();

			// Use blocking call to get audio transcript
			RecognizeResponse response = speech.recognize(config, audio);
			List<SpeechRecognitionResult> results = response.getResultsList();
			HashMap<String, String> rMap = new HashMap<>();

			String sentence = "";
			for (SpeechRecognitionResult result : results) {
				// There can be several alternative transcripts for a given chunk of speech.
				// Just use the
				// first (most likely) one here.

				SpeechRecognitionAlternative alternative = result.getAlternativesList().get(0);

				// confidence
				rMap.put("confidence", Float.toString(alternative.getConfidence()));

				// transcript
				rMap.put("transcript", alternative.getTranscript());

				// WordInfo
				List<WordInfo> wordInfos = alternative.getWordsList();

				List<String> word = new ArrayList<>();
				List<String> startTime = new ArrayList<>();
				List<String> endTime = new ArrayList<>();
				List<String> term = new ArrayList<>();
				
				
				for (WordInfo wordInfo : wordInfos) {
					
					// start, end time
					long startTimeSec = wordInfo.getStartTime().getSeconds();
					float startTimeNano = (float)wordInfo.getStartTime().getNanos() / 1000000000;
					long endTimeSec = wordInfo.getEndTime().getSeconds();
					float endTimeNano = (float)wordInfo.getEndTime().getNanos() / 1000000000;
					float startTimeValue = startTimeSec + startTimeNano;
					float endTimeValue = endTimeSec + endTimeNano;
					float termValue = endTimeValue - startTimeValue;
					
					
					System.out.println("word : " +wordInfo.getWord());
					System.out.println("starttime : " + startTimeValue);
					System.out.println("endtime : " +endTimeValue);
					System.out.println("term : " +termValue);
					System.out.println();
					
					
					word.add(wordInfo.getWord());
					startTime.add(Float.toString(startTimeValue));
					endTime.add(Float.toString(endTimeValue));
					term.add(Float.toString(termValue));
					
				}

				rMap.put("word", word.toString());
				rMap.put("startTime", startTime.toString());
				rMap.put("endTime", endTime.toString());
				rMap.put("term", term.toString());

				sentence += alternative.getTranscript();
			}
			System.out.println("sentence: " + sentence);
			return rMap;
		}
	}
}
