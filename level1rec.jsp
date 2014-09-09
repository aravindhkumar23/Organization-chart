<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="connection.jsp" %>

<% 
String[] root;
root=request.getParameterValues("root");
String[] name=request.getParameterValues("name");
String[] desig=request.getParameterValues("desig");
String c_id=request.getParameter("c_id");
int level=Integer.parseInt(request.getParameter("level"));
//out.println(level);
int l=level+1;

String[] spec=request.getParameterValues("spec");




String pname=null;


	System.out.println("*************************************************");
 for(int j=0;j<root.length;j++)
{
	 System.out.println(root[j]);
	   /* out.println(root[j]);
	 out.println(name[j]);
	 out.println(desig[j]); 
	 out.println(c_id);
	 out.println(level);  */
	 System.out.println("close the dialog to view chart");
	 if(spec[j].equals("zone"))
	 {
		 String[] zoneval=request.getParameterValues("zone");
		 pname=zoneval[j];
		 pname=pname.substring(1);
	 }
	 if(spec[j].equals("state"))
	 {
		 String[] stateval=request.getParameterValues("stateval");
		 pname=stateval[j];
		 pname=pname.substring(1);
	 }
	 if(spec[j].equals("city"))
	 {
		 String[] cityval=request.getParameterValues("cityval");
		 pname=cityval[j];
	 }
	 
	 System.out.println(pname);
	    p=connection.prepareStatement("insert into org_level(name,base,root,cid,designation,access,pname) values('"+name[j]+"',"+l+","+root[j]+","+c_id+",'"+desig[j]+"','"+spec[j]+"','"+pname+"')");
	 p.executeUpdate();  
	
	ResultSet rs=null;
p5=connection.prepareStatement("select sid from org_level WHERE name='"+name[j]+"' and cid='"+c_id+"'");
rs=p5.executeQuery();
 String oid=null;
if(rs.next())
{
	
	oid=rs.getString(1);
}

String password=name[j]+"./"+oid;
p7=connection.prepareStatement("update org_level set pwd='"+password+"' where sid='"+oid+"'");

p7.executeUpdate();   

 
} 

%>
