<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Welcome! Hong's Blog</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<table>
        <thead>
            <tr>
                <th>글번호</th>
                <th>제목</th>
                <th>내용</th>
                <th>작성날짜</th>
                <th>조회수</th>
                <th>작성자</th>
                <th>카테고리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td>${item.postId}</td>
                    <td>${item.title}</td>
                    <td>${item.postContent}</td>
                    <td>${item.regDate}</td>
                    <td>${item.hits}</td>
                    <td>${item.userId}</td>
                    <td>${item.categoryId}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
