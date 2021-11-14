<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome! Hong's Blog</title>
<script src=https://code.jquery.com/jquery-3.6.0.min.js></script>
<%
	session.setAttribute("loginId", "hong");
%>
</head>
<body>
	<h2>게시글 상세보기</h2>
	<table>
		<tr>
			<th>카테고리</th>
			<td>${post.categoryId}</td>
		</tr>
		<tr>
			<th>글번호</th>
			<td>${post.postId}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${post.title}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${post.userId}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${post.regDate}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${post.hits}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${post.postContent}</td>
		</tr>
		<tr>
			<td colspan = "2">
				<button onclick="location.href='./list'">리스트</button>
				<button onclick="location.href='./updateForm?postId=${post.postId}'">수정</button>
			</td>
		</tr>
	</table>
	<hr/>
	
	<div class="commentZone">
		<c:if test="${not empty sessionScope.loginId}">
			<div class="cmtWriteArea">
				<input type="hidden" name="newCntWriter" value="${sessionScope.loginId}">
				<textarea name="newCmtContent" placeholder="댓글을 입력해주세요."></textarea>
				<div class="invalid-fb">1자 이상 입력해주세요.</div>
				<label for="newCmtContent">300자 이내로 입력해주세요.</label>
				<button id="cmtWriteBtn">등록</button>
			</div>
		</c:if>
		<br/>
		
		<div class="cmtList">
			<div class="comment">
				<span>$작성자</span>&nbsp;<span>$댓글내용</span>&nbsp;<span>$2021-11-14</span>
				
			</div>
			<button id="cmtUpdateBtn" type="button">수정</button>
			<button id="cmtdeleteBtn" type="button">삭제</button>
			<button id="replyBtn" type="button">답글달기</button>
			
			<div class="cmtUpdate">
				<textarea name="cmtUpdateContent">$댓글내용</textarea>
				<button type="button">수정완료</button>
				<button type="button">취소</button>
			</div>
			
			<div class="reply">
				▶ <textarea name="repContent" placeholder="대댓글을 입력해주세요."></textarea>
				<button type="button">등록</button>
				<button type="button">취소</button>
			</div>
			<br/>
		</div>
		
		<div class="pageContainer">
			<nav aria-lable="Page navigation" style="text-align:center" id="pageNav">
				<ul class="pagination" id="pagination"></ul>
			</nav>
		</div>
	</div>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	var postId = "${post.postId}";
	getComments();
	
	function getComments(){
		//$(".cmtList").empty();
		//$(".pagination").empty();
	}
</script>
</html>