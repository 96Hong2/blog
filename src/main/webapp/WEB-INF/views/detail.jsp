<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome! Hong's Blog</title>
<script src=https://code.jquery.com/jquery-3.6.0.min.js></script>
<script src="resources/js/jquery.twbsPagination.js"></script>
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
				<button type="button" onclick="delPost()">삭제</button>
			</td>
		</tr>
	</table>
	<hr/>
	
	<div class="commentZone">
		<c:if test="${not empty sessionScope.loginId}">
			<div class="cmtWriteArea">
				<p>댓글 달기</p>
				<input type="hidden" id="newCmtWriter" value="${sessionScope.loginId}">
				<textarea id="newCmtContent" placeholder="댓글을 입력해주세요."></textarea>
				<div class="invalid-fb">1자 이상 입력해주세요.</div>
				<button id="cmtWriteBtn" onclick="writeComment()">등록</button>
			</div>
		</c:if>
		<br/>
		<hr/>
		
		<div id="cmtList">
			
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
	var loginId = "${sessionScope.loginId}";
	getComments(1);
	
	function delPost(){
		if(confirm("게시글을 정말 삭제하시겠습니까?") == true){
			location.href="./del?postId="+postId;
		}else{
			return;
		}
	}
	
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
					drawComments(data.list, loginId); //댓글리스트를 브라우저에 그려준다

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
			var check = (loginId == item.cmtWriter);
			console.log("loginId : "+loginId+"/"+"item.cmtWriter : "+item.cmtWriter);
			
			if(item.isDel == 'Y'){
				content += "<p>삭제된 댓글입니다.</p>";
				
			}else if(item.cmtDepth == 'C'){ 
				//일반댓글인 경우
				content += "<div class='updateCheck'>"
				+ "<p>" + item.cmtWriterNick + "</p>"
				+ "<p>" + item.cmtContent + "</p>"
				+ "<p>" + item.cmtRegDate + "</p>"
				+ "<button type='button' onclick='getReplyForm()'>답글달기</button>";
				
				if(check){
					content += "<button type='button' onclick='getUpdateForm("+item.cmtId+")'>수정</button>"
					+ "<button type='button' onclick='cmtDelete("+item.cmtId+")'>삭제</button>";
				}
				
				//댓글 수정 폼
				content += "<div class='cmtUpdateForm' id='cmtUpdateForm'"+item.cmtId+">"
				+ "<textarea name='cmtUpdateContent'>"+item.cmtContent+"</textarea>"
				+ "<button type='button' onclick='cmtUpdate("+item.cmtId+")'>수정완료</button>"
				+ "<button type='button' onclick='cancelUpdateForm'>취소</button>"
				+ "</div>";
				
				//대댓글 폼
				content += "<div class='replyForm' id='replyForm'"+item.cmtId+">"
				+ "&nbsp; ▶ &nbsp;"
				+ "<textarea id='repContent' name='repContent' placeholder='대댓글을 입력해주세요.'></textarea>"
				+ "<button type='button' onclick='writeReply("+item.cmtId+")'>등록</button>"
				+ "<button type='button' onclick='cancelReplyForm()'>취소</button>"
				+ "</div>";
				
				content += "<hr/></div><br/>";
			
			}else{
				//대댓글인 경우
				content += "<div class='updateCheck'>"
				+ "<p>&nbsp; ▶ &nbsp;"
				+ item.cmtWriterNick + "</p>"
				+ "<p>" + item.cmtContent + "</p>"
				+ "<p>" + item.cmtRegDate + "</p>";
					
				if(check){
					content += "<button type='button' onclick='getUpdateForm("+item.cmtId+")'>수정</button>"
					+ "<button type='button' onclick='cmtDelete("+item.cmtId+")'>삭제</button>";
				}
				
				//댓글 수정 폼
				content += "<div class='cmtUpdateForm' id='cmtUpdateForm'"+item.cmtId+">"
				+ "<textarea name='cmtUpdateContent'>"+item.cmtContent+"</textarea>"
				+ "<button type='button' onclick='cmtUpdate("+item.cmtId+")'>수정완료</button>"
				+ "<button type='button' onclick='cancelUpdateForm'>취소</button>"
				+ "</div>";
				
				content += "<hr/></div><br/>";
			}
		});
		$("#cmtList").empty();
		$("#cmtList").append(content);
		
		$(".cmtUpdateForm").hide();
		$(".replyForm").hide();
	}
	
	//댓글을 작성하는 함수
	function writeComment(){
		$(".invalid-fb").hide();
		
		var cmtContent = $("#newCmtContent").val().trim(); //내용
		var writer = $("#newCmtWriter").val().trim(); //댓글쓴이
		
		if(cmtContent.length == 0){
			$(".invalid-fb").show();
			return;
		}else{
			$.ajax({
				type: 'POST',
				url: 'cmtWrite',
				data: {
					"cmtContent" : cmtContent,
					"postId" : postId,
					"cmtWriter" : writer
				},
				dataType: 'JSON',
				success: function(data){
					if(data.success > 0){
						alert("댓글 등록에 성공했습니다.");
						//댓글작성란 초기화
						$("#newCmtContent").val("");
						//댓글창 리로드
						getComments(1);
					}else{
						alert("댓글을 등록하지 못했습니다.");
					}
				},
				error: function(e){
					console.log("댓글 작성 실패 :"+e);
					alert("댓글을 등록하지 못했습니다.");
				}
			});
		}
	}
	
	function getReplyForm(){
		$(".replyForm").show();
	}
	
	function cancelReplyForm(){
		if(confirm("대댓글 작성을 취소하시겠습니까?") == true){
			$(".replyForm").hide();	
		}else{
			return;
		}
	}
	
	//대댓글 작성
	function writeReply(cmtId){
		var cmtContent = $("#repContent").val().trim(); //내용
		var writer = $("#newCmtWriter").val().trim(); //댓글쓴이
		
		if(cmtContent.length == 0){
			alert("대댓글 내용을 입력해주세요!");
			return;
		}else{
			$.ajax({
				type: 'POST',
				url: 'replyWrite',
				data: {
					"cmtContent" : cmtContent,
					"postId" : postId,
					"cmtWriter" : writer,
					"cmtParent" : cmtId
				},
				dataType: 'JSON',
				success: function(data){
					if(data.success > 0){
						alert("  대댓글 등록에 성공했습니다.");
						//댓글작성란 초기화
						$("#repContent").val("");
						//댓글창 리로드
						getComments(1);
					}else{
						alert("대댓글을 등록하지 못했습니다.");
					}
				},
				error: function(e){
					console.log("대댓글 작성 실패 :"+e);
					alert("대댓글을 등록하지 못했습니다.");
				}
			});
		}
	}
	
</script>
</html>