<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" type="text/css" href="resources/css/style.css">
	<script type="text/javascript">
		var ajax = new XMLHttpRequest();
		
		function loginPop() {
			document.querySelector('.pop_back').style.display = 'block';
			document.querySelector('.popup.login').style.display = 'block';
		}
		
		// 로그인 처리 Ajax
		function login() {
			var userId = document.getElementById("userId").value;
			var userPass = document.getElementById("userPass").value;
			
			if(userId == '' || userPass == '') {
				alert("아이디와 비밀번호를 모두 입력해주세요.");
				return false;
			}
			
			var data = {
				"userId": userId,
				"userPass": userPass
			}
			
			ajax.onreadystatechange = loginAjax;
			ajax.open("POST", "./loginAjax", true);
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function loginAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					if(response.hasOwnProperty('msg')) {
						document.getElementById("loginMsg").innerHTML = response.msg;
						document.getElementById("userId").value = "";
						document.getElementById("userPass").value = "";
					} else {
						alert(response.loginCheck.ID + "님 로그인에 성공하셨습니다.");
						location.reload();
					}
				} else {
					alert("실패");
				}
			}
		}
	</script>
</head>
<body>
	
	<!-- header -->
	<header id="header">
		<div class="inner_header">
			<h1><a href="${pageContext.request.contextPath}">LOGO</a></h1>
			<ul class="menu">
				<c:if test="${login == null}">
					<li><button type="button" onclick="loginPop();">로그인</button></li>
				</c:if>
				<c:if test="${login != null}">
					<li class="info"><span>${login.ID}</span>님</li>
					<li><button type="button" onclick="location.href='./logout'">로그아웃</button></li>
				</c:if>
			</ul>
		</div>
	</header>
	
	<!-- 로그인 팝업 -->
	<div class="popup login">
		<h3>로그인</h3>
		<button type="button" class="pop_close" onclick="popClose(this);">닫기</button>
		
		<form class="login_form">
			<div class="input_box">
				<label for="userId">아이디</label>
				<input type="text" id="userId" name="userId">
			</div>
			<div class="input_box">
				<label for="userPass">비밀번호</label>
				<input type="password" id="userPass" name="userPass">
			</div>
			<p id="loginMsg"></p>
			
			<div class="btn_wrap">
				<button type="button" onclick="login();">로그인</button>
				<button type="button">회원가입</button>
			</div>
		</form>
	</div>
</body>
</html>





























