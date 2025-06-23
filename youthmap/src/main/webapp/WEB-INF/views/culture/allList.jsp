<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/culture/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>전체 콘텐츠 목록</title>


  <style>
.cards {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  max-width: 1200px;
  margin: 0 auto;
  box-sizing: border-box;
  justify-items: center;
}

.card {
  position: relative;
  box-sizing: border-box;
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
  background: #fff;
  text-align: center;
  width: 250px;   /* 카드 크기 고정 */
}

.img-wrap {
  width: 100%;
  height: 300px;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  text-align: center;
}
.img-wrap img {
  max-width: 90%;
  max-height: 90%;
  border-radius: 8px;
}

.card-info {
  padding: 10px;
  box-sizing: border-box;
  text-align: center;
}

/* 제목(한 줄 말줄임) */
.card-info .title {
  font-weight: bold;
  margin-bottom: 4px;
  text-align: center;
  overflow: hidden;
}
.card-info .title a {
  display: block;         /* 필수: block이나 inline-block */
  width: 100%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  text-decoration: none !important;
  color: inherit !important;
}

.card-info .period {
  width: 100%;
  font-size: 0.9rem;
  color: #555;
  text-align: center;
  margin-bottom: 2px;
}

.card-info .location {
  text-align: center;
  margin-top: 2px;
  overflow: hidden;
  color: #555;
}
.card-info .location a {
  display: block;         /* 필수 */
  width: 100%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  text-decoration: none !important;
  color: inherit !important;
}

/* 카드 전체 클릭 가능하게 하는 경우(이미지, 제목, 날짜) */
a.card-link {
  text-decoration: none !important;
  color: inherit !important;
  display: block;
}

/* 뱃지 */
.badge {
  position: absolute;
  top: 7px;
  right: 7px;
  color: #fff;
  background: #008060;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 0.85rem;
  font-weight: bold;
  white-space: nowrap;
  box-shadow: 0 2px 4px rgba(0,0,0,0.2);
  z-index: 10;
}
.badge.exhibitionlist    { background: #008060; }
.badge.performancelist   { background: #a83279; }
.badge.eventlist         { background: #0066cc; }

.pager {
  text-align: center;
  margin: 20px auto;
}
.pager a, .pager span {
  display: inline-block;
  margin: 0 6px;
  padding: 4px 8px;
  text-decoration: none;
  color: #000;
}
.pager .current {
  font-weight: bold;
}
/* 카드 호버 애니메이션 추가 */
    .cards .card {
      transition: all 0.3s ease-in-out;
    }
    .cards .card:hover {
      transform: translateY(-4px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
   
  </style>
</head>
<body>

	

 <div align="center" >
	<a onclick="location.href='allList'" style=" width:100px; height:26px; line-height:26px; text-align:center; 
            font-size:18px; margin:0 8px; cursor:pointer;">
      전체 목록
    </a>
  <a onclick="location.href='exhibitionlist'"
            style="
            width:100px;
            height:26px;
            line-height:26px;			/* 버튼 높이랑 같게 */
            text-align:center;
            font-size:18px;
            margin:0 8px;
            cursor:pointer;">
    전시/미술
  </a>

  <a onclick="location.href='performancelist'"
	  style="
          width:100px;
          height:26px;
          line-height:26px;
          text-align:center;
          font-size:18px;
          margin:0 8px;
          cursor:pointer; ">
    공연
  </a>

  <a onclick="location.href='eventlist'"
          style="
            width:100px;
            height:26px;
            line-height:26px;
            text-align:center;
            font-size:18px;
            margin:0 8px;
            cursor:pointer; ">
    축제/행사
  </a>
</div>

  
<%@ include file="/WEB-INF/views/culture/searchBar.jsp" %>

<%@ include file="/WEB-INF/views/culture/tabs.jsp" %>


	<h2 style="text-align:center; margin:20px 0; margin-top:3rem; margin-bottom:4rem;">
		    전체 콘텐츠 목록 (${page}/${pagecount})
	</h2>

<div id="card-container">
<div class="cards">
  <c:if test="${empty allList }">
    검색 결과가 없습니다.
  </c:if>

  <c:if test="${!empty allList}">
    <c:forEach var="item" items="${allList}">
	<div class="card">
      <!-- 상세페이지 URL 설정 -->
      <c:choose>
        <c:when test="${item.category_name == '전시/미술'}">
        <!-- 1) 카테고리 뱃지 -->
      		<div class="badge exhibitionlist">${item.category_name}</div>
          <c:set var="detailUrl" value="${pageContext.request.contextPath}/exhibitioncont"/>
        </c:when>
        <c:when test="${item.category_name == '콘서트' 
                      or item.category_name == '연극' 
                      or item.category_name == '뮤지컬/오페라'
                      or item.category_name == '국악'
                      or item.category_name == '독주회'
                      or item.category_name == '클래식'
                      or item.category_name == '무용'}">
           <!-- 1) 카테고리 뱃지 -->
      		<div class="badge performancelist">${item.category_name}</div>
          <c:set var="detailUrl" value="${pageContext.request.contextPath}/performancecont"/>
        </c:when>
        <c:otherwise>
        <!-- 1) 카테고리 뱃지 -->
      		<div class="badge eventlist">${item.category_name}</div>
          <c:set var="detailUrl" value="${pageContext.request.contextPath}/eventcont"/>
        </c:otherwise>
      </c:choose>

      <!-- URL 파라미터 설정 -->
      <c:url var="urlWithParams" value="${detailUrl}">
        <c:param name="con_id" value="${item.con_id}" />
        <c:param name="page" value="${page}" />
      </c:url>

      <!-- 카드 구성 -->
        
        <!-- 🔗 이미지에만 링크 -->
        <a href="${urlWithParams}">
          <div class="img-wrap">
            <img src="${item.con_img}" alt="${item.con_title}" />
          </div>
        </a>

        <div class="card-info">
          <!-- 🔗 제목에만 링크 -->
          <div class="title">
            <a href="${urlWithParams}" style="text-decoration:none; color:inherit;">
              ${item.con_title}
            </a>
          </div>
          <div class="period">${item.con_start_date} ~ ${item.con_end_date}</div>
          <div class="location">${item.con_location}</div>
        </div>


    </div>
    </c:forEach>
  </c:if>
</div>
</div>

  <!-- 페이징 UI -->
  <div class="pager">
    <c:if test="${page > 1}">
      <a href="${pageContext.request.contextPath}/culturesearch?mainCategory=all&search=${search}&keyword=${keyword}&page=1">&laquo;</a>
    </c:if>
    <c:if test="${startpage > 10}">
      <a href="${pageContext.request.contextPath}/culturesearch?mainCategory=all&search=${search}&keyword=${keyword}&page=${startpage-10}">[이전]</a>
    </c:if>
    <c:forEach var="i" begin="${startpage}" end="${endpage}">
      <c:choose>
        <c:when test="${i == page}">
          <span class="current">${i}</span>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/culturesearch?mainCategory=all&search=${search}&keyword=${keyword}&page=${i}">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${endpage < pagecount}">
      <a href="${pageContext.request.contextPath}/culturesearch?mainCategory=all&search=${search}&keyword=${keyword}&page=${startpage+10}">[다음]</a>
    </c:if>
    <c:if test="${page < pagecount}">
      <a href="${pageContext.request.contextPath}/culturesearch?mainCategory=all&search=${search}&keyword=${keyword}&page=${pagecount}">&raquo;</a>
    </c:if>
  </div>
  
 <!-- ❶ jQuery 라이브러리 (한 번만!) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 미니리스트 결과를 담을 팝업 레이어 -->
<div id="miniModal" style="
  display:none; position:fixed; left:0; top:0; width:100vw; height:100vh;
  z-index:1000; background:rgba(30,40,50,0.11); 
  backdrop-filter: blur(2.5px);">

  <div style="
    position:absolute; left:50%; top:52%; transform:translate(-50%,-50%);
    background:#fff;
    border-radius: 28px;                   /* 더 부드러운 라운드 */
    box-shadow: 0 10px 38px 0 rgba(30,60,90,0.20), 0 2px 8px 0 rgba(0,0,0,0.07);
    min-width: 390px; max-width: 540px;    /* 크기 여유 */
    max-height: 80vh; overflow-y:auto;
    border: none;
    padding: 0 0 18px 0;
    transition: box-shadow 0.2s;
    ">
    <button id="closeModalBtn" style="
      position:absolute; top:15px; right:16px; z-index:10;
      background:none; border:none; font-size:2.1rem; color:#b5b5b5; cursor:pointer; transition:color 0.18s;"
      onmouseover="this.style.color='#008060';"
      onmouseout="this.style.color='#b5b5b5';"
    >&times;</button>
    <!-- 🟡 여기! 문구 박스 추가 -->
    <div id="miniModalHeader" style="
      border-bottom:1.5px solid #ececec; 
      padding:29px 22px 14px 28px; 
      font-size:1.11em; font-weight:600; color:rgba(40,40,44,0.88);  /* 👈 이 부분만 변경! */ 
      background:rgba(245,240,230,0.67); 
      border-radius:28px 28px 0 0;
      letter-spacing:-1px;
    ">
      실시간 인기 콘텐츠
    </div>
    <div id="miniModalContent" style="padding:28px 22px 16px 22px;">
      <!-- AJAX로 결과 들어옴 -->
    </div>
  </div>
</div>

<!-- ❷ 정렬 팝업 AJAX (한 번만!) -->
<script>
$(function(){
	  $('.sort-nav a').click(function(e){
	    e.preventDefault();

	    var sort = $(this).data('sort');
	    var ctx = '${pageContext.request.contextPath}';
	    var url = ctx + '/allList-mini?sort=' + sort;

	    // 🌟 정렬별로 상단 멘트 다르게!
	    var headerMsg = "실시간 인기 콘텐츠";
	    if(sort == 'newest')     headerMsg = "최신 등록 콘텐츠";
	    if(sort == 'endingSoon') headerMsg = "마감 임박 콘텐츠";
	    $('#miniModalHeader').text(headerMsg);

	    // AJAX로 mini 데이터 가져와서 팝업에 삽입
	    $.get(url, function(html){
	      $('#miniModalContent').html(html);
	      $('#miniModal').fadeIn(180);
	    });
	  });

	  // 팝업 닫기(버튼, 바깥 클릭, ESC)
	  $('#closeModalBtn, #miniModal').on('click', function(e){
	    if(e.target === this) $('#miniModal').fadeOut(180);
	  });
	  $(document).on('keyup', function(e){
	    if(e.key === "Escape") $('#miniModal').fadeOut(180);
	  });
	});
</script>
  
</body>
</html>
