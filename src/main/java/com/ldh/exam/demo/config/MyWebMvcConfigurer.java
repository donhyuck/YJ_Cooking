package com.ldh.exam.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ldh.exam.demo.interceptor.BeforeActionInterceptor;
import com.ldh.exam.demo.interceptor.NeedLoginInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {

	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	// needLoginInterceptor 인터셉터 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;

	// addInterceptors 함수 -> 인터셉터를 적용하는 역할
	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		InterceptorRegistration ir;

		ir = registry.addInterceptor(beforeActionInterceptor);
		ir.addPathPatterns("/**");
		ir.excludePathPatterns("/resource/**");
		ir.excludePathPatterns("/error");

		ir = registry.addInterceptor(needLoginInterceptor);
		ir.addPathPatterns("/user/recipe/write");
		ir.addPathPatterns("/user/recipe/doWrite");
		ir.addPathPatterns("/user/recipe/modify");
		ir.addPathPatterns("/user/recipe/doModify");
		ir.addPathPatterns("/user/recipe/doDelete");
	}
}