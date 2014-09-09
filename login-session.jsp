<%@page session="true"%>

<%@include file="connection.jsp" %>
<%
		String uname=request.getParameter("uname");
System.out.println(uname);
		session.setMaxInactiveInterval(24 * 60 * 60);
		session.setAttribute("uname",uname);
		/* response.sendRedirect("success.jsp"); */
		String checkurl=session.getAttribute("check").toString();
		if(checkurl.equals("adminlogin"))
		{
		response.sendRedirect("org-config.jsp");
		}
		if(checkurl.equals("userlogin"))
		{
			

ResultSet rs=null;
p=connection.prepareStatement("Select T.uname as 'cname', T.logo as 'logo' from org_level O join trial_userlist T on T.sid=O.cid where O.name='"+uname+"'");
rs=p.executeQuery();
if(rs.next()){
	
	String logo=rs.getString("logo");
	String cname=rs.getString("cname");
	
	String dir_logo="logo/"+logo;
	
	session.setAttribute("dir_logo",dir_logo);
	
}
			
			
		response.sendRedirect("org-config.jsp");
		}
%>