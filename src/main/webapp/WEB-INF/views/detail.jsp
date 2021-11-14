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
				<input type="hidden" id="newCmtWriter" value="${sessionScope.loginId}">
				<textarea id="newCmtContent" placeholder="댓글을 입력해주세요."></textarea>
				<div class="invalid-fb">1자 이상 입력해주세요.</div>
				<button id="cmtWriteBtn" onclick="writeComment()">등록</button>
			</div>
		</c:if>
		<br/>
		
		<div id="cmtList">
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
	getComments(1);
	
	$(".invalid-fb").hide(); //빈 댓글 작성 시 피드백
	
	//댓글을 로드하는 함수
	function getComments(currPage){
		$("#pagination").twbsPagination('destroy');
		
		$.ajax({
			type : "POST",
			url : "getComments",
			data : {
				"postId" : postId,
				"page" : currPage
			},
			dataType : 'JSON',
			success : function(data) {
				//댓글이 있는 경우
				if(data.list != null){
					drawComments(data.list, data.loginId); //댓글리스트를 브라우저에 그려준다

					$("#pagination").twbsPagination({
						startPage : data.currPage, //시작페이지
						totalPages : data.pages, //총 페이지 개수
						visiblePages : 5,
						initiateStartPageClick: false,
						first : "<<", //처음, 이전, 다음, 마지막 페이지 표시
						prev : "<",
						next : ">",
						last : ">>",
						onPageClick : function(e, page){
							//페이지 클릭이 일어나면
							getComments(postId, page);
						}
					});
				//댓글이 없는 경우
				}else{
					$("#pagination").twbsPagination({
						startPage : 1, //시작페이지
						totalPages : 1, //총 페이지 개수
						visiblePages : 1,
						initiateStartPageClick: false,
						first : "<<",
						prev : "<",
						next : ">",
						last : ">>",
						onPageClick : function(e, page){
							//페이지 클릭이 일어나면
							console.log("댓글 없음");
						}
					});
				}
			},
			error : function(e) {
				console.log("ajax loadComments() 에러 : " + e);
			}
		})
	} //end getComments()
	
	//댓글리스트를 브라우저에 그려주는 함수
	function drawComments(list, loginId){
		var content = "";
		
		list.forEach(function(item, idx){
			//현재 로그인된 아이디와 댓글쓴이가 같은 지 확인 
			var check = (loginId == item.userId);
			
			content += "<div class='updateCheck'>"
			+ "<p class='toBold'>" + item.nickName + "</p>"
			+ "<p class='cmtContent'>" + item.cmtContent;
			
			if(check){
				content += "<button type='button' onclick='getUpdateForm("+item.cmtId+")'>수정</button>"
				+ "<button type='button' onclick='cmtDelete("+item.cmtId+")'>삭제</button>";
			}
			
			content += "</p><hr/></div><br/>";
		});
		$("#cmtList").empty();
		$("#cmtList").append(content);
	}
	
	//댓글을 작성하는 함수
	function writeComment(){
		var cmtContent = $("#newCmtContent").val(); //내용
		var writer = $("#newCmtWriter").val(); //댓글쓴이
		
		if(cmtContent == null){
			$(".invalid-fb").show();
			return;
		}else{
			alert(writer+" / "+cmtContent)
		}
	}
	
</script>
</html>