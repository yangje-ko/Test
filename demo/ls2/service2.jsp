<%@page import="SafeIdentity.SSO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file= "../jsputil/util.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
String sToken=request.getParameter("ssotoken");
String sUid=null;
String sPermission=null;
if( sToken !=null ) {
	String sApiKey="368B184727E89AB69FAF";
	SSO sso = new SSO(sApiKey);
	String sBase = request.getRequestURI();
	if(sBase.lastIndexOf(".jsp") >= 0) {
		sBase = sBase.substring(0, sBase.lastIndexOf(".jsp"));
	}
	sPermission=sso.getPermission(sBase, sToken, request.getRemoteAddr(), true );
	int nResult=sso.getLastError();
	if( nResult>=0 ) {
		sUid=sso.getValueUserID();
		sUid = sUid + "-" + sPermission;
	}
}
%>
<html>
<head>
<title>Secureon Service 2 [DEMO]</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../assets/modern-demo.css">
</head>
<body>
<% if( sPermission !=null ){ %>
  <div class="landing-wrap">
    <div class="landing-card app-card">
      <div class="app-header">
        <div class="brand"><img src="../img/secureon.jpg" alt="Secureon 로고"></div>
        <div><a href="../as/index.jsp">Home</a> | <a href="../as/logoff.jsp">Logoff</a></div>
      </div>
      <h1 class="landing-title">서비스 2</h1>
      <p class="landing-sub"><%= sUid %> 님의 카드 결제 요약 정보입니다.</p>
      <table class="modern-table">
        <tr><th>날짜</th><th>카드번호</th><th>결제계좌은행</th><th>결제계좌번호</th></tr>
        <tr><td>2001/08/02</td><td>4404 4500 1234 5678</td><td>외환은행</td><td>971018****</td></tr>
      </table>
    </div>
  </div>
<% } else { %>
  <script type="text/javascript">
    alert("사용자가 인증되지 않았거나 서비스 권한이 부족합니다.");
    history.back(-1);
  </script>
<% } %>
</body>
</html>
