<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header-navbar.jsp" %>

    <!-- ////////////////////////////////////////////////////////////////////////////-->


   
    <!-- main menu-->
    <div data-scroll-to-active="true" class="main-menu menu-fixed menu-dark menu-accordion menu-shadow">
      <!-- main menu header-->
      <div class="main-menu-header">
        <input type="text" placeholder="Search" class="menu-search form-control round"/>
      </div>
      <!-- / main menu header-->
      
      
      <!-- 대쉬보드 설정 -->
      <div class="main-menu-content">
        <ul id="main-menu-navigation" data-menu="menu-navigation" class="navigation navigation-main">
          <li class=" nav-item"><a href="/index.do"><i class="icon-home3"></i>홈</a>
          </li>
          <li class=" nav-item"><a href="/noti/notiList.do"><i class="icon-bullhorn"></i><span data-i18n="nav.bootstrap_tables.table_basic" class="menu-title">공지사항</span></a>
          </li>
          <li class="nav-item"><a href="#"><i class="icon-stack-2"></i><span data-i18n="nav.page_layouts.main" class="menu-title">내 정보</span></a>
            <ul class="menu-content">
              <li><a href="/myInfo/mySpeechReport.do?userNo=<%=CmmUtil.nvl(session.getAttribute("userNo").toString()) %>" class="menu-item">내 면접 기록</a><!-- 김한결 수정 부분  data-i18n="nav.page_layouts.1_column"  -->
              </li>
              <li><a href="layout-2-columns.html" data-i18n="nav.page_layouts.2_columns" class="menu-item">면접 즐겨찾기</a>
              </li>
              <li><a href="layout-static.html" data-i18n="nav.page_layouts.static_layout" class="menu-item">개인 정보</a>
              <ul class="menu-content">
                  <li><a href="/UserEdit.do" data-i18n="nav.error_pages.error_400" class="menu-item">개인정보 수정</a>
                  </li>
                  <li><a href="error-401.html" data-i18n="nav.error_pages.error_401" class="menu-item">회원 탈퇴</a>
                  </li>
                </ul>
              </li>
            </ul>
          </li>
          <li class=" nav-item"><a href="#"><i class="icon-briefcase4"></i><span data-i18n="nav.project.main" class="menu-title">스피치 연습</span></a>
            <ul class="menu-content">
              <li><a href="invoice-template.html" data-i18n="nav.invoice.invoice_template" class="menu-item">면접 질문 세트 선택</a>
              <ul class="question-set-select">
                  <li><a href="/qset/QSetList.do" class="set-popular">인기 세트</a></li>
                  <li><a href="/qset/QSetList.do" class="set-recommend">추천 세트</a></li>
                  <li><a href="/qset/QSetList.do" class="set-new">신규 세트</a></li>
              </ul>
              </li>
              <li><a href="/qset/CreateQSet.do" data-i18n="nav.gallery_pages.gallery_grid" class="menu-item">면접 질문 세트 작성</a>
              </li>
              <li><a href="login-simple.html" data-i18n="nav.login_register_pages.login_simple" class="menu-item">면접 질문 세트 후기</a>
              </li>
            </ul>
          </li>
          <%--
          <li class=" nav-item"><a href="#"><i class="icon-ios-albums-outline"></i><span data-i18n="nav.cards.main" class="menu-title">사용자 커뮤니티</span></a>
            <ul class="menu-content">
              <li><a href="/recruitment/recruitList.do" data-i18n="nav.cards.card_bootstrap" class="menu-item">채용공고 게시판</a>
              </li>
              <li><a href="/resFeedback/resList.do" data-i18n="nav.cards.card_actions" class="menu-item">피드백 게시판</a>
              </li>
              <li><a href="/jobIntrvReview/jirList.do" data-i18n="nav.cards.card_actions" class="menu-item">면접후기 게시판</a>
              </li>
            </ul>
          </li>
          --%>
        
        </ul>
      </div>
      </div>
      <!-- /main menu content-->
      <!-- main menu footer-->
      <!-- include includes/menu-footer-->
      <!-- main menu footer-->

