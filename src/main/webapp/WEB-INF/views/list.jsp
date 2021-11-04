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
	<button id="write_btn" type="button" onclick="location.href='writeForm'">글쓰기</button>
	<button id="delete_btn" type="button" onclick="getDelBtn()">포스팅 삭제</button>
	<button class="del_btn" type="button" onclick="cancel_del()">취소</button>
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
            	<th class="del_btn">삭제</th>
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
                    <td class="del_btn"><a href="javascript:del('${item.postId}')">삭제하기</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
<script>

	$(".del_btn").hide();

	function getDelBtn(){
		$(".del_btn").show();	
	}
	
	function cancel_del(){
		$(".del_btn").hide();
	}

	function del(postId){
		if(confirm("글을 삭제하시겠습니까?") == true){
			alert(postId+" 번 글 제거!");
			/* $.ajax({
	               url:'delPost',
	               type:'GET',
	               data : {"postId" : postId},
	               dataType:'JSON',
	               success:function(data){
	                              
	               },
	               error:function(e){
	                  console.log("에러발생 : ", e);
	               }               
	            }); */
		}else{
			return;
		}
	}
</script>
</html>