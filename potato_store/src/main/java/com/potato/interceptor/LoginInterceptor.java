package com.potato.interceptor;

import java.io.PrintWriter;

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
		
		String requestUri = request.getRequestURI();
		String[] requestUris = requestUri.split("/");
		String firstPath = requestUris[2];
		
		if(firstPath.equals("item")) {
			if(obj == null) {
				// 로그인 X
				response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('로그인 후 이용가능합니다.');history.go(-1);</script>");
	            out.flush();
	            /*response.sendRedirect(request.getContextPath() + "/");*/
	            return false;
			}
		}
		
		return true; // 컨트롤러 URI
	}
}
