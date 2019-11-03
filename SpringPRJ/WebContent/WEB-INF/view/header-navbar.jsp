<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <nav class="header-navbar navbar navbar-with-menu navbar-fixed-top navbar-semi-dark navbar-shadow">
      <div class="navbar-wrapper">
        <div class="navbar-header">
          <ul class="nav navbar-nav">
            <li class="nav-item mobile-menu hidden-md-up float-xs-left"><a class="nav-link nav-menu-main menu-toggle hidden-xs"><i class="icon-menu5 font-large-1"></i></a></li>
            <li class="nav-item"><a href="/index.do" class="navbar-brand nav-link"><img alt="branding logo" src="/resources/app-assets/images/logo/logo_transparent.png" data-expand="/resources/app-assets/images/logo/logo_transparent.png" data-collapse="/resources/app-assets/images/logo/logo_small.png" class="brand-logo"></a></li>
            <li class="nav-item hidden-md-up float-xs-right"><a data-toggle="collapse" data-target="#navbar-mobile" class="nav-link open-navbar-container"><i class="icon-ellipsis pe-2x icon-icon-rotate-right-right"></i></a></li>
          </ul>
        </div>
        <div class="navbar-container content container-fluid">
          <div id="navbar-mobile" class="collapse navbar-toggleable-sm">
            <ul class="nav navbar-nav">
              <li class="nav-item hidden-sm-down"><a class="nav-link nav-menu-main menu-toggle hidden-xs"><i class="icon-menu5">         </i></a></li>
              <li class="nav-item hidden-sm-down"><a href="#" class="nav-link nav-link-expand"><i class="ficon icon-expand2"></i></a></li>
            </ul>
            
            <!-- 언어 설정 -->
            <ul class="nav navbar-nav float-xs-right">
              <!-- 사용자 정보관리창 설정 -->
              <li class="dropdown dropdown-user nav-item"><a href="#" data-toggle="dropdown" class="dropdown-toggle nav-link dropdown-user-link"><span class="avatar avatar-online"><img src="/resources/app-assets/images/portrait/small/avatar-s-1.png" alt="avatar"><i></i></span><span class="user-name"><%=id %>님</span></a>
                <div class="dropdown-menu dropdown-menu-right"><a href="/UserEdit.do" class="dropdown-item"><i class="icon-head"></i>정보 수정</a>
                  <div class="dropdown-divider"></div><a href="/logout.do" class="dropdown-item"><i class="icon-power3"></i>로그아웃</a>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </nav>