<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome! Hong's Blog</title>
<script src=https://code.jquery.com/jquery-3.6.0.min.js></script>
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
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>