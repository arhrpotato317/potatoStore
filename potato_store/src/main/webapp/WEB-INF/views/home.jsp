<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Potato Store</title>
	<script type="text/javascript">
		var ajax = new XMLHttpRequest();
		
		// 사원명부 전체 리스트 팝업 Ajax
		function allEmpListPop() {
			// 팝업 열기
			document.querySelector('.pop_back').style.display = 'block';
			document.querySelector('.popup.allEmp').style.display = 'block';
			document.getElementById("allEmpBody").innerHTML = "";
			
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
		
		function oneEmpListPop() {
			// 팝업 열기
			document.querySelector('.pop_back').style.display = 'block';
			document.querySelector('.popup.oneEmp').style.display = 'block';
			
			// 조회내용 리셋하기
			document.getElementById("oneEmpBody").innerHTML = "";
			document.getElementById("empNo").value = "";
			document.getElementById("empDeptNo").selectedIndex = "0";
			/* document.querySelector('.emp_form').reset(); */
		}
		// 사원 검색 리스트 팝업 Ajax
		function oneEmpList() {
			var empNo = document.getElementById('empNo').value;
			var empDeptNo = document.getElementById('empDeptNo').value;
			
			if(empNo == '' || empDeptNo == '') {
				alert("사원 번호와 부서 번호를 모두 입력해주세요.");
				return false;
			}
			
			var data = {
				"empNo": empNo,
				"empDeptNo": empDeptNo
			}
			
			ajax.onreadystatechange = oneEmpAjax;
			ajax.open("POST", "./oneEmpAjax", true);
			ajax.setRequestHeader('Content-Type', 'aplication/json');
			ajax.send(JSON.stringify(data));
		}
		function oneEmpAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					
					if(response.empList.length < 1) {
						alert("해당하는 사원이 없습니다.");
						return false;
					}
					
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
					document.getElementById("oneEmpBody").innerHTML = resultHtml;
				} else {
					alert("실패");
				}
			}
		}
		
		// 팝업 닫기
		function popClose(obj) {
			document.querySelector('.pop_back').style.display = 'none';
			var closePop = obj.closest('.popup');
			closePop.style.display = 'none';
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
					<button type="button" onclick="allEmpListPop();">사원 명부</button>
					<button type="button" onclick="oneEmpListPop();">사원 여부</button>
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
	
	<!-- 팝업 배경 -->
	<div class="pop_back"></div>
	
	<!-- 사원명부 전체 리스트 팝업 -->
	<div class="popup allEmp">
		<h3>사원 명부</h3>
		<button type="button" class="pop_close" onclick="popClose(this);">닫기</button>
		<table>
			<thead>
				<tr>
					<th>사원명</th>
					<th>판매량</th>
					<th>입사일</th>
					<th>사원번호</th>
					<th>MGR</th>
					<th>직무</th>
					<th>부서명</th>
					<th>급여</th>
				</tr>
			</thead>
			<tbody id="allEmpBody"></tbody>
		</table>
	</div>
	
	<!-- 사원 검색 리스트 팝업 -->
	<div class="popup oneEmp">
		<h3>사원 여부</h3>
		<button type="button" class="pop_close" onclick="popClose(this);">닫기</button>
		
		<form class="emp_form">
			<div class="input_box">
				<label for="empNo">사원 번호</label>
				<input type="text" id="empNo" name="empNo">
			</div>
			<div class="input_box">
				<label for="empDeptNo">부서 이름</label>
				<select id="empDeptNo" name="empDeptNo">
					<option>--- 선택 ---</option>
					<option value="10">재무부</option>
					<option value="20">연구부</option>
					<option value="30">판매부</option>
					<option value="40">집행부</option>
				</select>
			</div>
			<input type="button" value="조회" onclick="oneEmpList();">
		</form>
		
		<table>
			<thead>
				<tr>
					<th>사원명</th>
					<th>판매량</th>
					<th>입사일</th>
					<th>사원번호</th>
					<th>MGR</th>
					<th>직무</th>
					<th>부서명</th>
					<th>급여</th>
				</tr>
			</thead>
			<tbody id="oneEmpBody"></tbody>
		</table>
	</div>
</body>
</html>







































