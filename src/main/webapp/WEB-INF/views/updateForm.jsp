<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateForm.jsp</title>
<script src=https://code.jquery.com/jquery-3.6.0.min.js></script>
</head>
<style>
	table{
		width: 100%;
	}
	input[type='text']{
		width: 100%;
	}
	table, th, td{
		border : 1px solid black;
		border-collapse : collapse;
		padding : 5px 10px;
	}
	textarea{
		width : 99%;
		height: 300px;
		border : 1px solid gray;
		text-align : left;
		margin: 5px;
		overflow: auto;
	}
</style>
<body>
	<h2>수정하기</h2>
	<form action="update" method="POST">
	<table>
		<tr>
			<th>글번호</th>
			<td><input type='hidden' name='postId' value="${post.postId}"/>${post.postId}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type='text' name='title' value="${post.title}"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name='postContent'>${post.postContent}</textarea></td>
		</tr>
		<tr>
			<td colspan = "2">
				<button onclick="location.href='./list'">리스트</button>
				<button>저장</button>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>