<OBJECT ID="SIClientAccess" CLASSID="CLSID:E3EAC26D-891F-499A-9C38-D8F165DE02B8"></OBJECT>
<%@page import="SafeIdentity.SSO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file= "../jsputil/util.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
String sToken=getCookie(request, "ssotoken");
String sUid=null;
if( sToken !=null ) {
	String sApiKey="368B184727E89AB69FAF";
	SSO sso = new SSO(sApiKey);
	int nResult=sso.verifyToken( sToken,request.getRemoteAddr() );
	if( nResult>=0 ) {
		sUid=sso.getValueUserID();
	}
}
%>
<html>
<head>
<title>seucreon ClientAccess [DEMO]</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="No-Cache">
<link rel="stylesheet" href="../assets/modern-demo.css">
</head>
<body>
  <div class="landing-wrap">
    <div class="landing-card app-card">
      <div class="app-header">
        <div class="brand"><img src="../img/secureon.jpg" alt="secureon 로고"><span>seucreon</span></div>
        <a href="../index.html">Home</a>
      </div>
      <% if( sUid == null ) { %>
      <h1 class="landing-title">ClientAccess SSO 로그인</h1>
      <p class="landing-sub">ClientAccess 연동 로그인 화면입니다.</p>
      <div class="landing-actions">
        <a class="action-btn" href="logon.html">로그인 시작</a>
      </div>
      <% } else { %>
      <h1 class="landing-title"><%= sUid %>님, 환영합니다</h1>
      <p class="landing-sub">ClientAccess 기반 서비스 메뉴를 선택하세요.</p>
      <div class="landing-actions">
        <a class="action-btn" href="../ls1/service1.jsp">서비스 1</a>
        <%
          String sParam="?ssotoken=" + URLEncoder.encode(sToken);
        %>
        <a class="action-btn secondary" href="../ls2/service2.jsp<%=sParam%>">서비스 2</a>
        <a class="action-btn secondary" href="logoff.jsp">로그아웃</a>
      </div>
      <% } %>
    </div>
  </div>
</body>
</html>
