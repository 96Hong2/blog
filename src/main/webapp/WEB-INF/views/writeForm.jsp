<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome! Hong's Blog</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<h2>글쓰기</h2>
	<form action='write' method='POST'>
 	<table>
		<tr>
			<th>제목</th>
			<td><input type='text' name='title'/></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type='text' name='userId' value='hong'/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name='content'></textarea></td>
		</tr>
		<!-- <tr>
			<th>사진</th>
			<td><input type='file' name='photo'></td>
		</tr> -->
		<tr>
			<td colspan = "2">
				<input type='button' onclick="location.href='./list'" value='리스트'/>
				<button>저장</button>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>