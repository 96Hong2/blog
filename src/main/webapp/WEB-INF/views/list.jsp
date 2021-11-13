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
	<button id="get_del_btn" type="button" onclick="getDelBtn()">포스팅 삭제</button>
	<button id="chk_all_btn" type="button" onclick="chkAllPost()">전체선택</button>
	<button id="delete_btn" type="button" onclick="delPost()">선택삭제</button>
	<button id="cancel_btn" type="button" onclick="cancel_del()">취소</button>
	<table>
        <thead>
            <tr>
                <th>글번호</th>
                <th>제목</th>
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
                    <td><a href="detail?postId=${item.postId}">${item.title}</a></td>
                    <td>${item.regDate}</td>
                    <td>${item.hits}</td>
                    <td>${item.userId}</td>
                    <td>${item.categoryId}</td>
                    <td class="del_chk"><input type="checkbox" name="delList" value="${item.postId}"></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}

	//삭제-취소 숨기기/보이기
	$("#cancel_btn").hide();
	$(".del_chk").hide();
	$("#delete_btn").hide();
	$("#chk_all_btn").hide();
	
	function getDelBtn(){
		$("#get_del_btn").hide();
		
		$("#delete_btn").show();
		$("#cancel_btn").show();
		$(".del_chk").show();
		$("#chk_all_btn").show();
	}
	
	function cancel_del(){
		$("#get_del_btn").show();
		
		$("#cancel_btn").hide();
		$("#delete_btn").hide();
		$(".del_chk").hide();
		$("#chk_all_btn").hide();
		
		var chkArr = $("input[type='checkbox']:checked");
		chkArr.prop('checked', false);
	}
	
	function chkAllPost(){
		var chkboxes = $("input[type='checkbox']");
		chkboxes.prop('checked', true);
	}

	
	//선택삭제 버튼 클릭 시 삭제 실행
	function delPost(){
		var chkArr = $("input[type='checkbox']:checked");
		console.log(chkArr);
		console.log("chkArr length : "+chkArr.length);
		if(chkArr.length <= 0){
			alert("삭제할 글을 체크해주세요.");
			return;
		}else{
			if(confirm("글을 삭제하시겠습니까?") == true){
				var delArr = [];
				chkArr.each(function(idx, item){
					console.log("delArr에 들어감 : "+$(this).val());
					delArr.push($(this).val());
				});
				console.log(delArr);
				
				$.ajax({
					url:'delPost',
		            type:'POST',
		            data : {"delArr" : delArr},
		            contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		            dataType:'JSON',
		            success:function(data){
		                 if(data.success > 0){
		                	 alert("글 삭제가 완료되었습니다.");
		                	 location.reload(true);
		                 }else{
		                	 alert("글 삭제에 실패했습니다.");
		                 }
		            },
		            error:function(e){
		               console.log("에러발생 : ", e);
		            }
		       	});
			}else{
				return;
			}
		}
	}
</script>
</html>