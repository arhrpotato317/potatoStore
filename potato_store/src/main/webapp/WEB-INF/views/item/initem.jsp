<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Potato Store</title>
</head>
<body>
	<!-- header -->
	<%@ include file="../include/header.jsp" %>
	
	<div class="container">
		<div class="product_wrap">
			<h1>상품 입고</h1>
			
			<div class="inner_wrap">
				<div class="inner">
					<h4>전체 상품 리스트</h4>
					
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
	
</body>
</html>







































