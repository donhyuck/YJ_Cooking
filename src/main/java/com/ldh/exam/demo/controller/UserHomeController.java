package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserHomeController {

	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/user/list/suggest";
	}

}
