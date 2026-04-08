<!--  <OBJECT ID="SIClientAccess" CLASSID="CLSID:E3EAC26D-891F-499A-9C38-D8F165DE02B8"> -->
<OBJECT ID="SIClientAccess" CLASSID="CLSID:D8ECD24B-34E3-43CC-BBC7-39DBBD5116A1">
</OBJECT>

<%@page import="SafeIdentity.SsoAuthInfo"%>
<%@page import="SafeIdentity.SSO"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file= "../jsputil/util.jsp" %>

<%
/******************************************************************************
  Copyright (C) 2000-2001 Softforum Corp.

Project		: SafeIdentity 5.0 Demo
Module		: Std. jsp demo
FileName	: logon_result.jsp
Version		: 2.0
Author		: leejh

Comment		: logon_result
History		:
2001.01.29	0.1 Creation
2001.08.14	2.0 
2001.08.28	3.0 Enterprise
2014.02.04  5.0 SI Demo

ETC			:			
****************************************************************************/
%>

 

<%
response.setHeader("Cache-Control", "no-cache");
String sUid    = request.getParameter("uid"); // 사용자로 부터 입력 받은 user id
String sPwd  = request.getParameter("pwd"); 
SsoAuthInfo authInfo = new SsoAuthInfo();	
String sToken = "";

System.out.println("logon_result.jsp sUid="+sUid  );  // for Debug
// id/pwd 인증 했다고 가정하고 토큰 설정하는 부분

int nResult=-1;
if( sUid!=null )
{
	String sApiKey="368B184727E89AB69FAF";	// ServerAPI 와 SafeAgent 간의 인증을 위한 키 정보
	SSO sso = new SSO(7000, sApiKey);	
	
	int nVersion = 23;									// 암호화 토큰 버전(seed, hmac) - 21,22,23 중 하나
	String sTargetServer = "GID_DEMO1";	// ssotoken.key 파일에 등록된 GroupID
	
	nResult = sso.regUserSession( sUid, request.getRemoteAddr(), true);
	nResult = sso.getLastError();
	System.out.println("logon_result.jsp nResult="+nResult );  // for Debug	
	if( nResult >= 0 )  // Ok
	{
		sToken = sso.getToken();
		setCookie( response, "ssotoken", sToken);
		setDomainCookie( response, "ssotoken", sToken, "www.minn.com"  );
		System.out.println("logon_result.jsp sToken="+sso.getToken() );  // for Debug
		
		%>
			<script language=javascript>
				alert("사용자(<%=sUid%>) 인증 완료. \n\n [token =<%=sToken%>]");

				// alert(SIClientAccess.GetToken());
  			SIClientAccess.SetToken("<%=sToken%>");
  			alert(SIClientAccess.GetToken());
  			
  			//SIClientAccess.SetTrustSite("WWW", "Naver.Com" );
  			
  			//SIClientAccess.SetTokenWithCookie("http://www.safe.com", "ssoToken","<%=sToken%>", "86400");	
				//alert(SIClientAccess.GetTokenWithCookie("http://www.safe.com/", "ssoToken"));
				
				location.href = "index.jsp";
			</script>
		<%
		
		return;
	}	
}
%>
	<script language=javascript>
		alert("사용자(<%=sUid%>) 인증 오류입니다. \n\n [오류코드=<%=nResult%>]");
		history.back(-1);
	</script>
	
