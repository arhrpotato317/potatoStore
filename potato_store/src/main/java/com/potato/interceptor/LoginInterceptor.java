package com.potato.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// preHandle() : 컨트롤러가 실행되기 전 실행되는 메서드
		HttpSession session = request.getSession(); // 현재 세션
		
		// 로그인 처리를 담당하는 사용자 정보를 담는 객체
		Object obj = session.getAttribute("login");
		
		if(obj == null) {
			// 로그인이 되지 않은 상태
			response.sendRedirect("/");
			return false; // 컨트롤러 요청으로 가지 않도록 처리
		}
		
		return true; // 컨트롤러 URI
	}
}
