<%@page import="pack.userprofile"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="connection.jsp" %>
    <%@page import="java.util.*" %>
<%
String status=request.getParameter("status");
System.out.println(status);
if(status.equals("reportServer"))
{
	System.out.println("bye");
	String name=request.getParameter("name");
	int oid=Integer.parseInt(request.getParameter("uid"));
	ArrayList<Object> ob = new ArrayList<Object>();
	String[] checkreport=request.getParameterValues("checkreport");
	System.out.println("in master "+checkreport);
	String temp=null;
	 for(int i=0;i<checkreport.length;i++)
	{ 
		 ob.add(checkreport[i]);	//temp=temp+",";
	 } 
	 temp=ob.toString();
	 temp = temp.replaceAll("\\[", "").replaceAll("\\]",""); // removin brackets
	 String[] s=temp.split(",");
	 for(int i=0;i<s.length;i++){
		 System.out.print("elt i = "+i+" value"+s[i].trim());
		 p7=connection.prepareStatement("update access_restriction set shared=CONCAT(shared,',"+name+"') where reports='"+s[i].trim()+"'");
		 //System.out.println("query "+p7);
		 p7.executeUpdate(); 
	 }
		out.println("Updated Successfully");

}
//delete org level
 if(status.equals("delete"))
{
	 String a=request.getParameter("c_id");
	 String b=request.getParameter("level");
	 String c=request.getParameter("status");
	 String d=request.getParameter("selected_name");
	 System.out.print(a+"+++++"+b+"----"+c+"----"+d); 
	p7=connection.prepareStatement("update org_level set status=1 where base='"+b+"' and name='"+d+"'");
	 //System.out.println(p7);
	p7.executeUpdate();   
	
}
//delete org level ends
%>