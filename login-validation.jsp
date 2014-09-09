    <%@include file="connection.jsp" %>
    <%
    String query=null;
    
    
    String check = request.getParameter("check");
    //out.println(check);
    session.setAttribute("check",check);
    if(check!=null)
    {
    	String uname = request.getParameter("uname"); 
        
        String pass = request.getParameter("pass");
    if(check.equals("adminlogin"))
    {
    query="Select * from trial_userlist where auname='"+uname+"' and apwd='"+pass+"'";
    }
    if(check.equals("userlogin"))
    {
   	query="Select * from org_level where name='"+uname+"' and pwd='"+pass+"'";
    }
    ResultSet rs=null;
    p=connection.prepareStatement(query);
    rs=p.executeQuery();
    if(rs.next()){
     	out.print(uname);
    }
    else
	{
    	out.print("ERROR");	
	}
    }
%>