<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Home</title>
	<script type="text/javascript">
		var ajax = new XMLHttpRequest();
		
		// 사원 명부 리스트 가져오기 Ajax
		function allEmpList() {
			document.querySelector('.pop_back').style.display = 'block';
			document.querySelector('.popup.allEmp').style.display = 'block';
			
			ajax.onreadystatechange = allEmpAjax;
			ajax.open("POST", "./allEmpAjax", true);
			ajax.send();
		}
		function allEmpAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					var resultHtml ="";
					for(var i=0; i<response.empList.length; i++) {
						resultHtml += '<tr>\
								<td>'+response.empList[i].ENAME+'</td>\
								<td>'+response.empList[i].COMM+'</td>\
								<td>'+response.empList[i].HIREDATE+'</td>\
								<td>'+response.empList[i].EMPNO+'</td>\
								<td>'+response.empList[i].MGR+'</td>\
								<td>'+response.empList[i].JOB+'</td>\
								<td>'+response.empList[i].DEPTNO+'</td>\
								<td>'+response.empList[i].SAL+'</td>\
							</tr>';
					}
					document.getElementById("allEmpBody").innerHTML = resultHtml;
				} else {
					alert("실패");
				}
			}
		}
		
		function popClose() {
			document.querySelector('.pop_back').style.display = 'none';
			document.querySelector('.popup').style.display = 'none';
			document.getElementById("allEmpBody").innerHTML = "";
		}
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="include/header.jsp" %>

	<div class="container">
		<div class="home_list">
			<div class="inner_list">
				<h2>사원 관리</h2>
				<div class="btn_wrap">
					<button type="button" onclick="allEmpList();">사원 명부</button>
					<button type="button">사원 여부</button>
				</div>
			</div>
			<div class="inner_list">
				<h2>상품 관리</h2>
				<div class="btn_wrap">
					<button type="button">상품 입고</button>
					<button type="button">상품 출고</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="pop_back"></div>
	<!-- 사원명부 팝업 -->
	<div class="popup allEmp">
		<h3>사원 명부</h3>
		<button type="button" class="pop_close" onclick="popClose();">닫기</button>
		<table>
			<thead>
				<tr>
					<th>사원명</th>
					<th>판매량</th>
					<th>입사일</th>
					<th>사원번호</th>
					<th>MGR</th>
					<th>직무</th>
					<th>부서번호</th>
					<th>급여</th>
				</tr>
			</thead>
			<tbody id="allEmpBody"></tbody>
		</table>
	</div>
</body>
</html>







































