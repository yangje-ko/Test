<%@page import="SafeIdentity.SSO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file= "../jsputil/util.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
String sToken=getCookie(request, "ssotoken");
String sUid=null;
String sPermission=null;
if( sToken !=null ) {
	String sApiKey="368B184727E89AB69FAF";
	SSO sso = new SSO(sApiKey);
	String sBase = request.getRequestURI();

	sPermission=sso.getPermission("/Button", sToken, request.getRemoteAddr(), true );
	int nResult=sso.getLastError();
	if( nResult>=0 ) {
		sUid=sso.getValueUserID();
		
	}
}
%>
<html>
<head>
<title>Secureon Service 1 [DEMO]</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../assets/modern-demo.css">
</head>
<body>
<% if( sPermission !=null ){ %>
  <div class="landing-wrap">
    <div class="landing-card app-card">
      <div class="app-header">
        <div class="brand"><img src="../img/secureon.jpg" alt="secureon 로고"></div>
        <div><a href="../as/index.jsp">Home</a> | <a href="../as/logoff.jsp">Logoff</a></div>
      </div>
      <h1 class="landing-title">서비스 1</h1>
      <p class="landing-sub"><%= sUid %> 님의 계좌 요약 정보입니다.</p>
      <table class="modern-table">
        <tr><th>계좌번호</th><th>현재잔액</th><th>최근거래일</th><th>개설점</th><th>이체가능여부</th></tr>
        <tr><td>065-19-21464-2</td><td>5,312,760원</td><td>2001/08/10</td><td>퇴계로</td><td>이체가능</td></tr>
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
