package com.ldh.exam.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ldh.exam.demo.vo.Rq;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {

	private Rq rq;

	@Value("${spring.profiles.active}")
	private String activeProfile;

	public BeforeActionInterceptor(Rq rq) {
		this.rq = rq;
	}

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		req.setAttribute("rq", rq);
		req.setAttribute("activeProfile", activeProfile);

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}