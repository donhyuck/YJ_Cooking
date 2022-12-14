package com.ldh.exam.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ldh.exam.demo.interceptor.BeforeActionInterceptor;
import com.ldh.exam.demo.interceptor.NeedLoginInterceptor;
import com.ldh.exam.demo.interceptor.NeedLogoutInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {

	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;

	// needLoginInterceptor 인터셉터 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;

	// needLogoutInterceptor 인터셉터 불러오기
	@Autowired
	NeedLogoutInterceptor needLogoutInterceptor;

	@Value("${custom.genFileDirPath}")
	private String genFileDirPath;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/gen/**").addResourceLocations("file:///" + genFileDirPath + "/")
				.setCachePeriod(20);
	}

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
		ir.addPathPatterns("/user/reply/doWrite");
		ir.addPathPatterns("/user/reply/modify");
		ir.addPathPatterns("/user/reply/doModify");
		ir.addPathPatterns("/user/reply/doDelete");
		ir.addPathPatterns("/user/member/myPage");
		ir.addPathPatterns("/user/member/modify");
		ir.addPathPatterns("/user/member/doModify");
		ir.addPathPatterns("/user/member/leave");
		ir.addPathPatterns("/user/member/doLeave");
		ir.addPathPatterns("/user/reaction/doMakeLike");
		ir.addPathPatterns("/user/reaction/doCancelLike");
		ir.addPathPatterns("/user/reaction/doMakeScrap");
		ir.addPathPatterns("/user/reaction/doCancelScrap");

		ir = registry.addInterceptor(needLogoutInterceptor);
		ir.addPathPatterns("/user/member/join");
		ir.addPathPatterns("/user/member/doJoin");
		ir.addPathPatterns("/user/member/login");
		ir.addPathPatterns("/user/member/doLogin");
		ir.addPathPatterns("/user/member/findLoginId");
		ir.addPathPatterns("/user/member/doFindLoginId");
		ir.addPathPatterns("/user/member/findLoginPw");
		ir.addPathPatterns("/user/member/doFindLoginPw");
		ir.addPathPatterns("/user/member/getLoginIdDup");
		ir.addPathPatterns("/user/member/getNicknameAndEmailDup");
	}
}