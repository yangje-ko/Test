<!------------ SIClientAccess COM 객체를 호출하기 위한 OBJECT 태그 ------------>
<OBJECT ID="SIClientAccess" CLASSID="CLSID:E3EAC26D-891F-499A-9C38-D8F165DE02B8"
codebase="https://localhost:7070/demo/object/SIClientAccess.cab"></OBJECT>

<%@page import="SafeIdentity.SsoAuthInfo"%>
<%@page import="SafeIdentity.SSO"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file= "../jsputil/util.jsp" %>

<script language=javascript>
//	alert("SIAccess 인증 성공. \n\n ");		
var sToken = SIClientAccess.GetToken();

  alert(sToken);	
// Token 검증
var returnVal = SIClientAccess.VerifyToken("");

if ( returnVal != null ) {  
 // 검증 성공 후 사용자 정보 가져오기
	alert("SIAccess 인증 성공. \n\n " + returnVal);					
}
else { // 검증 실패 
	alert("SIAccess 인증 실패. \n\n ");			
	}



</script>
	
