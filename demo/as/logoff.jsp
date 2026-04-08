<%@page import="SafeIdentity.SSO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file= "../jsputil/util.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
String sToken=getCookie(request, "ssotoken");
int nResult=-1;
if( sToken !=null ) {
	setCookie( response, "ssotoken", "" );
	SSO sso = new SSO();
	nResult = sso.unregUserSession( sToken );
}
%>
<html>
<head>
<title>seucreon [DEMO]</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../assets/modern-demo.css">
</head>
<body>
  <% if( nResult >= 0 ) { %>
  <div class="landing-wrap">
    <div class="landing-card app-card">
      <div class="brand"><img src="../img/secureon.jpg" alt="secureon 로고"></div>
      <h1 class="landing-title">로그아웃 완료</h1>
      <p class="landing-sub">모든 세션이 안전하게 정리되었습니다.</p>
      <div class="landing-actions">
        <a class="action-btn" href="../index.html">메인으로</a>
      </div>
    </div>
  </div>
  <% } else { %>
  <script type="text/javascript">
    alert("로그오프 오류가 발생했습니다.\n\n [오류코드=<%=nResult%>]");
    history.back(-1);
  </script>
  <% } %>
</body>
</html>
