<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Potato Store</title>
	<script type="text/javascript">
		var ajax = new XMLHttpRequest();
		
		// 전체 상품 리스트 팝업 Ajax
		function allItemPop() {
			document.querySelector('.pop_back').style.display = 'block';
			document.querySelector('.allItem').style.display = 'block';
			document.getElementById("allItemBody").innerHTML = "";
			
			ajax.onreadystatechange = allItemAjax;
			ajax.open("POST", "./allItemAjax", true);
			ajax.send();
		}
		function allItemAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					var resultHtml = "";
					for(var i=0; i<response.allItemList.length; i++) {
						resultHtml += '<tr>\
								<td>'+response.allItemList[i].CDNO+'</td>\
								<td>'+response.allItemList[i].CDLVL+'</td>\
								<td>'+response.allItemList[i].UPCD+'</td>\
								<td>'+response.allItemList[i].CDNAME+'</td>\
								<td><input type="checkbox" '+response.allItemList[i].USEYN+' disabled></td>\
							</tr>';
					}
					document.getElementById("allItemBody").innerHTML = resultHtml;
				} else {
					alert("실패");
				}
			}
		}
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../include/header.jsp" %>
	
	<div class="container">
		<div class="product_wrap">
			<h1>상품 입고</h1>
			<button type="button" onclick="allItemPop();" class="btn_allItem">전체 상품 확인하기</button>
			
			<div class="inner_wrap">
				<div class="inner">
					<h4>상품 조회 리스트</h4>
					
					<div class="input_wrap">
						<div class="input_box">
							<label>카테고리</label>
							<select>
								<option>--- 선택 ---</option>
							</select>
							<select>
								<option>--- 선택 ---</option>
							</select>
						</div>
						<button type="button">조회</button>
					</div>
					
					<div class="in_table">
						<table>
							<thead>
								<tr>
									<th>상품코드</th>
									<th>상품명</th>
									<th>제조사코드</th>
									<th>제조사명</th>
									<th>단위코드</th>
									<th>단위명</th>
									<th>재고수량</th>
									<th>재고여부</th>
									<th>사용여부</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<div class="inner">
					<h4>금일 입고 리스트</h4>
					
					<div class="in_table">
						<table>
							<thead>
								<tr>
									<th>상품코드</th>
									<th>상품명</th>
									<th>제조사코드</th>
									<th>제조사명</th>
									<th>단위코드</th>
									<th>단위명</th>
									<th>입고수량</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<div class="inner">
					<h4>입고내용</h4>
					
					<div class="input_box">
						<label>상품코드</label>
						<input type="text">
					</div>
					<div class="input_box">
						<label>상품명</label>
						<input type="text">
					</div>
					<div class="input_box">
						<label>제조사</label>
						<input type="text">
					</div>
					<div class="input_box">
						<label>단위명</label>
						<input type="text">
					</div>
					<div class="input_box">
						<label>입고수량</label>
						<input type="text">
					</div>
					
					<div class="btn_wrap">
						<button type="button" class="edit">수정</button>
						<button type="button" class="save">저장</button>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- 전체 상품 리스트 팝업 -->
	<div class="popup allItem">
		<h3>전체 상품 리스트</h3>
		<button type="button" class="pop_close" onclick="popClose(this);">닫기</button>
		
		<div class="in_table">
			<table>
				<thead>
					<tr>
						<th>코드번호</th>
						<th>코드레벨</th>
						<th>상위코드</th>
						<th>코드이름</th>
						<th>사용여부</th>
					</tr>
				</thead>
				<tbody id="allItemBody"></tbody>
			</table>
		</div>
	</div>
	
</body>
</html>







































