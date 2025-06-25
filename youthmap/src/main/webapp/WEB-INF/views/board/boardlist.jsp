<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">
</head>
<body>
<!-- 헤더-->
<%@ include file="/WEB-INF/views/header.jsp" %>


<!-- Hero 이미지 영역 -->
<div class="hero-section">
  <img src="${pageContext.request.contextPath}/img/123.jpg" alt="Hero Image" class="hero-img" />
</div>
<div class ="container">
<!-- ✅ 카테고리 탭 메뉴 -->
<div class="category-tabs">
  <a href="/boardlist" class="${empty category ? 'active' : ''}">전체</a>
  <a href="/boardlist?category=공지" class="${category == '공지' ? 'active' : ''}">공지</a>
  <a href="/boardlist?category=정책" class="${category == '정책' ? 'active' : ''}">정책</a>
  <a href="/boardlist?category=문화" class="${category == '문화' ? 'active' : ''}">문화</a>
  <a href="/boardlist?category=맛집" class="${category == '맛집' ? 'active' : ''}">맛집</a>
  <a href="/boardlist?category=유저게시판" class="${category == '유저게시판' ? 'active' : ''}">유저게시판</a>
</div>

<!-- ✅ 게시판 테이블 -->
<table class="board-table">
  <thead>
    <tr>
      <th>No</th>
      <th>글쓴이</th>
      <th>제목</th>
      <th>작성일</th>
      <th>조회수</th>
    </tr>
  </thead>
  <tbody>
    <!-- 🔔 공지사항 (전체카테고리에서만 표시) -->
    <c:if test="${empty category}">
      <c:forEach var="notice" items="${topNotices}">
        <tr class="notice-row">
          <td>📢</td>
          <td>${notice.memName}</td>
          <td><a href="boardview?no=${notice.boardNo}">[공지] ${notice.boardSubject}</a></td>
          <td><fmt:formatDate value="${notice.boardDate}" pattern="yyyy.MM.dd"/></td>
          <td>${notice.boardReadcount}</td>
        </tr>
      </c:forEach>
    </c:if>

    <!-- 📄 일반 게시글 -->
    <c:forEach var="b" items="${boardlist}" varStatus="status">
      <tr>
        <td>${Math.max(1, listcount - ((page-1) * 10 + status.index))}</td>
        <td>${b.memName}</td>
        <td><a href="boardview?no=${b.boardNo}">${b.boardSubject}</a></td>
        <td><fmt:formatDate value="${b.boardDate}" pattern="yyyy.MM.dd"/></td>
        <td>${b.boardReadcount}</td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<!-- 페이징 네비게이션 -->
<c:if test="${totalPages > 1}">
  <div class="pagination">
    <!-- 이전 페이지 -->
    <c:if test="${page > 1}">
      <a href="/boardlist?page=${page-1}&category=${category}&searchType=${searchType}&keyword=${keyword}" class="page-link">&lt;</a>
    </c:if>
    
    <!-- 페이지 번호 -->
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
      <c:choose>
        <c:when test="${i == page}">
          <span class="page-link active">${i}</span>
        </c:when>
        <c:otherwise>
          <a href="/boardlist?page=${i}&category=${category}&searchType=${searchType}&keyword=${keyword}" class="page-link">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    
    <!-- 다음 페이지 -->
    <c:if test="${page < totalPages}">
      <a href="/boardlist?page=${page+1}&category=${category}&searchType=${searchType}&keyword=${keyword}" class="page-link">&gt;</a>
    </c:if>
  </div>
</c:if>

<!-- ✅ 검색 + 글작성 버튼 -->
<div class="search-and-write">
  <!-- 🔍 검색 폼 -->
  <form action="/boardlist" method="get" class="search-form">
    <input type="hidden" name="category" value="${category}" />
    <input type="text" name="keyword" value="${keyword}" placeholder="Search" />
    <button type="submit">🔍</button>
  </form>

  <!-- 📝 글작성 버튼 -->
  <div class="write-btn-wrap">
    <c:choose>
      <c:when test="${empty sessionScope.loginMember}">
        <button class="write-btn" onclick="alert('로그인이 필요합니다.'); location.href='/login';">글작성</button>
      </c:when>
      <c:otherwise>
        <form action="/boardwrite" method="get">
          <button type="submit" class="write-btn">글작성</button>
        </form>
      </c:otherwise>
    </c:choose>
  </div>
</div>
</div>

<!-- ✅ 푸터 -->
<div class="footer">
  <div class="footer-icons">
    <a href="#"><img src="${pageContext.request.contextPath}/img/face.png" alt="facebook"></a>
    <a href="#"><img src="${pageContext.request.contextPath}/img/insta.png" alt="instagram"></a>
    <a href="#"><img src="${pageContext.request.contextPath}/img/twit.svg" alt="twitter"></a>
  </div>

  <p>
    Tel. 000-0000-0000 | Fax. 00-0000-0000 | vivade@vivade.com<br>
    Addr. Seoul, Korea | Biz License 000-00-00000
  </p>

  <p>&copy; 2025 YOUTHMAP. All Rights Reserved.<br>Hosting by YOUTHMAP Team</p>
</div>

</body>
</html>
