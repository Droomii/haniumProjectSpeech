package poly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RecruitmtController {
	
	@RequestMapping(value="/recruitment/recruitList")
	public String RecruitmtList() throws Exception {

		return "/recruitment/recruitList";
	}
}
