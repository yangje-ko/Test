<% /*
Project : SafeIdentity 5.0 Demo
Filename : /jsputil/util.jsp
Last Update : 2001.02.28-2001.08.14
*/ %>


<%@ page import="java.io.*" %>

<%!

public void setCookie ( HttpServletResponse response, String sName, String sValue )
{
	Cookie c = new Cookie( sName, sValue );
	c.setPath( "/" );
//	c.setDomain("www.min.co.kr");
	response.addCookie(c);
}	

public void setDomainCookie ( HttpServletResponse response, String sName, String sValue,String sDomain )
{
	Cookie c = new Cookie( sName, sValue );
		
	c.setPath( "/" ); 
	c.setDomain("www.min.com");	
	c.setMaxAge(365*24*60*60);
	// 필요에 따라 쿠키의 옵션값을 추가한다.	
	System.out.println("util.jsp ** cookieDomain ="+ c.getDomain());
	response.addCookie(c);
}

public String getCookie ( HttpServletRequest request, String sName )
{
	
	Cookie[] cookies = request.getCookies();	
	
	if ( cookies != null ) 
	{	
	
		//System.out.println("cookies.length[" + cookies.length + "]");
		for (int i=0; i < cookies.length; i++) 
		{
	
			String name = cookies[i].getName();
			
			String sDomain = cookies[i].getDomain();		
		
			
			if( name != null && name.equals(sName) ) 
			{
//				System.out.println("util.jsp  *********************cookiename ="+ cookies[i].getName() );
//				System.out.println("util.jsp  *cookiedomain="+ cookies[i].getDomain() );				
//				System.out.println("util.jsp  cookievalue="+ cookies[i].getValue());
//				System.out.println("util.jsp cookies[i].getValue()=" + cookies[i].getValue());
				return cookies[i].getValue();
			}
		}
		;
	}
	return null;	
}	

public String toHangul( String str )        
{
	if ( str == null )
    	return null;
    	
    String newstr=null;	
    try {	
		newstr = new String( str.getBytes("8859_1"), "KSC5601" );
	}	
	catch (Exception e )
    {  ;   }
        
	if ( newstr!=null && str.length() == newstr.length() )  
		return str;
	else
		return newstr;
}

public String toEng( String str )        
{
	if ( str == null )
    	return null;
    	
    String newstr=null;	
    try {	
		newstr = new String( str.getBytes("KSC5601"), "8859_1" );
	}	
	catch (Exception e )
    {  ;   }
        
	if ( newstr!=null && str.length() == newstr.length() ) 
		return str;
	else
		return newstr;
}

%>	
