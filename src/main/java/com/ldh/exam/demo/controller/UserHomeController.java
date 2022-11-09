package com.ldh.exam.demo.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.ldh.exam.demo.service.GenFileService;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserHomeController {

	private GenFileService genFileService;
	private Rq rq;

	public UserHomeController(GenFileService genFileService, Rq rq) {
		this.genFileService = genFileService;
		this.rq = rq;
	}

	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/user/list/suggest";
	}

	@RequestMapping("/user/home/upload")
	public String showUpload() {
		return "/user/home/default";
	}

	@RequestMapping("/user/home/doUpload")
	@ResponseBody
	public String doUpload(MultipartRequest multipartRequest) {

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, 1);
			}
		}

		return rq.jsReplace("사진등록완료", "/");
	}

}
