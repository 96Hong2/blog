<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Welcome! Hong's Blog</title>
	<c:set var="path" value="${pageContext.request.contextPath}" />
    <link href="${path}/resources/css/home.css" rel="stylesheet">
</head> 
<body>

<div class="wrap">
      <div class="intro_bg">
        <div class="header">
          <div class="searchArea">
            <form>
              <input type="search" placeholder="search">
              <span>검색</span>
            </form>
          </div>
          <ul class="nav">
            <li><a href="#">HOME</a></li>
            <li><a href="list">DIARY</a></li>
            <li><a href="list">DEV</a></li>
            <li><a href="list">GAME</a></li>
          </ul>
        </div>
        <div class="intro_text">
          <h1>Welcome to Hong's Daily Life!</h1>
          <h4 class="contents1">게임과 맛있는 것, 그리고 개발을 좋아하는 개발자 홍의 블로그입니다.</h4>
        </div>
      </div>
      </div>
      <!-- intro end-->
      <ul class="amount">
        <li>
          <div>
            <div class="contents1">달성한 최대 월 수익</div>
            <div class="result">$10,021,924</div>
          </div>
        </li>
        <li>
          <div>
            <div class="contents1">정복한 알고리즘 문제 수</div>
            <div class="result">12,345</div>
          </div>
        </li>
        <li>
          <div>
            <div class="contents1">최종 목표 문제 수</div>
            <div class="result">100,000+</div>
          </div>
        </li>
        <li>
            <div>
              <div class="contents1">블로그 방문자 수</div>
              <div class="result">59,221,084</div>
            </div>
        </li>
      </ul>


      <div class="main_text0">
        <h1>WHAT'S NEW</h1>
        <div class="contents1"> 매주 월, 수, 금 새로운 포스팅을 업데이트합니다.</div>
        
        <ul class="icons">
          <li>
            <div class="icon_img">
              <img src="${path}/resources/img/food.jpg">
            </div>
            <div class="contents1_bold">환상적인 음식</div>
            <div class="contents2">
                음식은 비주얼로 한 번, 맛으로 또 한 번 음미합니다. 
            </div>
            <div class="more">
              MORE
            </div>
          </li>

          <li>
            <div class="icon_img">
              <img src="${path}/resources/img/maple.PNG">
            </div>
            <div class="contents1_bold">매료시키는 게임</div>
            <div class="contents2">
                메이플 스토리에서 로스크 아크로 갈아 탈 준비 중에 있습니다.
            </div>
            <div class="more">
              MORE
            </div>
          </li>

          <li>
            <div class="icon_img">
              <img src="${path}/resources/img/code.jpg">
            </div>
            <div class="contents1_bold">감각적인 개발</div>
            <div class="contents2">
                사람들의 마음을 움직이는 감각적인 &nbsp;소프트웨어를 개발하고 싶습니다.
            </div>
            <div class="more">
              MORE
            </div>
          </li>
        </ul>
      </div>

      <div class="main_text1">
        <h1>WHO'S HONG</h1>
        <div class="contents1">욕심도 많고 사랑도 많은 최고의 파트너, 개발자 권은홍입니다.</div>
        <div class="service">
          <div class="my_photo">
            <img src="${path}/resources/img/me.jpg">
          </div>
          <div class="contents2">
              <h2>EUN-HONG KWON</h2>
              <h3>SOFTWARE ENGINEER</h3>
              <h4>Major in Industrial Engineering | Soongsil Univ. Seoul</h4>
              <h4>Study for Junior Software Engineer (2020~) </h4> <br>
              직관적이고도 효율적인, 그리고 창의적인 소프트웨어 개발에  매료되어<br>
              약 2년동안 IT소양을 기르며 주니어 소프트웨어 엔지니어로서 구직중입니다.<br><br>
              
              <h5>Phone | (+82) 010 - 3933 - 3134 </h5> <br>
              <h5>Email | dmsghd95@naver.com </h5> <br>
              <h5>Another Blog | https://blog.naver.com/dmsghd95 </h5> <br>
              <h5>Github | https://github.com/96Hong2/smilegate </h5> <br>
          </div>
        </div>
      </div>

      <div class="main_text2">
      	<div>
            <div><h1>CONTACT</h1></div>
            <div>저에게 파트너십을 신청하거나, 아이디어를 공유해주세요</div>
            <div class="more2">더 알아보기</div>
        </div>  
      </div>

      <div class="footer">
        <div>LOGO</div>
        <div>
          (주) EH 아이티뱅크 <br>
          Addr. 인천광역시 계양구 계산동 123-12 광백캐슬 7F 고객상담실 <br>
          Fax/Tel. 032 - 123 -1234~5 <br>
          COPYRIGHT 2021. EUNHONG. ALL RIGHT RESERVED.
        </div>
      </div>
    </div>
  </body>

</html>
