<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <label id="interestLabel2">관심분야</label>
<fieldset class="form-group position-relative has-icon-left">

							<select name="interest" id="basicSelect" class="form-control">
                                        <option value="" label="관심분야" id="interestLabel"></option>
                                        <optgroup label="서비스업">
											<option value="0108" label="호텔·여행·항공"></option>
											<option value="0109" label="외식업·식음료"></option>
											<option value="0111" label="시설관리·경비·용역"></option>
											<option value="0115" label="레저·스포츠·여가"></option>
											<option value="0118" label="AS·카센터·주유"></option>
											<option value="0119" label="렌탈·임대"></option>
											<option value="0120" label="웨딩·장례·이벤트"></option>
											<option value="0121" label="기타서비스업"></option>
											<option value="0122" label="뷰티·미용"></option>
										</optgroup><optgroup label="제조·화학">
											<option value="0201" label="전기·전자·제어"></option>
											<option value="0202" label="기계·설비·자동차"></option>
											<option value="0204" label="석유·화학·에너지"></option>
											<option value="0205" label="섬유·의류·패션"></option>
											<option value="0207" label="화장품·뷰티"></option>
											<option value="0208" label="생활용품·소비재·사무"></option>
											<option value="0209" label="가구·목재·제지"></option>
											<option value="0210" label="농업·어업·광업·임업"></option>
											<option value="0211" label="금속·재료·철강·요업"></option>
											<option value="0212" label="조선·항공·우주"></option>
											<option value="0213" label="기타제조업"></option>
											<option value="0214" label="식품가공·개발"></option>
											<option value="0215" label="반도체·광학·LCD"></option>
											<option value="0216" label="환경"></option>
										</optgroup><optgroup label="IT·웹·통신">
											<option value="0301" label="솔루션·SI·ERP·CRM"></option>
											<option value="0302" label="웹에이젼시"></option>
											<option value="0304" label="쇼핑몰·오픈마켓"></option>
											<option value="0305" label="포털·인터넷·컨텐츠"></option>
											<option value="0306" label="네트워크·통신·모바일"></option>
											<option value="0307" label="하드웨어·장비"></option>
											<option value="0308" label="정보보안·백신"></option>
											<option value="0313" label="IT컨설팅"></option>
											<option value="0314" label="게임"></option>
										</optgroup><optgroup label="은행·금융업">
											<option value="0401" label="은행·금융·저축"></option>
											<option value="0402" label="대출·캐피탈·여신"></option>
											<option value="0405" label="기타금융"></option>
											<option value="0406" label="증권·보험·카드"></option>
										</optgroup><optgroup label="미디어·디자인">
											<option value="0501" label="신문·잡지·언론사"></option>
											<option value="0502" label="방송사·케이블"></option>
											<option value="0503" label="연예·엔터테인먼트"></option>
											<option value="0504" label="광고·홍보·전시"></option>
											<option value="0505" label="영화·배급·음악"></option>
											<option value="0506" label="공연·예술·문화"></option>
											<option value="0509" label="출판·인쇄·사진"></option>
											<option value="0510" label="캐릭터·애니메이션"></option>
											<option value="0511" label="디자인·설계"></option>
										</optgroup><optgroup label="교육업">
											<option value="0601" label="초중고·대학"></option>
											<option value="0602" label="학원·어학원"></option>
											<option value="0603" label="유아·유치원"></option>
											<option value="0604" label="교재·학습지"></option>
											<option value="0605" label="전문·기능학원"></option>
										</optgroup><optgroup label="의료·제약·복지">
											<option value="0701" label="의료(진료과목별)"></option>
											<option value="0702" label="의료(병원종류별)"></option>
											<option value="0703" label="제약·보건·바이오"></option>
											<option value="0704" label="사회복지"></option>
										</optgroup><optgroup label="판매·유통">
											<option value="0801" label="판매(매장종류별)"></option>
											<option value="0802" label="판매(상품품목별)"></option>
											<option value="0803" label="유통·무역·상사"></option>
											<option value="0804" label="운송·운수·물류"></option>
										</optgroup><optgroup label="건설업">
											<option value="0901" label="건설·건축·토목·시공"></option>
											<option value="0902" label="실내·인테리어·조경"></option>
											<option value="0903" label="환경·설비"></option>
											<option value="0904" label="부동산·임대·중개"></option>
										</optgroup><optgroup label="기관·협회">
											<option value="1001" label="정부·공공기관·공기업"></option>
											<option value="1002" label="협회·단체"></option>
											<option value="1003" label="법률·법무·특허"></option>
											<option value="1004" label="세무·회계"></option>
											<option value="1005" label="연구소·컨설팅·조사"></option>
										</optgroup>
                                    </select>
							<div class="form-control-position">
							    <i class="icon-star-full"></i>
							</div>
							<div style="color: red; height:1.6em;" id="idMsg"></div>
</fieldset>