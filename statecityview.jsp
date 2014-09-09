<%@page import="java.sql.*"%>
<%@include file="connection.jsp" %>

<%

ResultSet rs=null;
ResultSet rs1=null;
String status = request.getParameter("status");
if(status.equals("stateview"))
{
String val = request.getParameter("count");
String divcount = request.getParameter("divnum");
System.out.println("*****************"+divcount);


 String query="SELECT distinct(state) as state FROM india_states_cities where Region='"+val+"'";
 System.out.println(query);
 %>
 <select id ='<%=divcount %>stateval' name='stateval' onchange="showcity(this.value)" style="width:120px;">
 <option value='-1'>Select</option>
 <%
 try {
		p=connection.prepareStatement(query);
		rs = p.executeQuery();
		while (rs.next()) {
			String state=rs.getString("state");
			//state
			String state1=divcount+state;
			System.out.println(state1);
			%>
			
			<option value="<%=state1%>"><%=state%></option>
			<%

		}

 }catch (Exception e) {
			System.out.println(e);
		}
		
%>
</select>
<%}


if(status.equals("cityview"))
{

String val1 = request.getParameter("count");


 String query1="SELECT city,sid FROM india_states_cities where state='"+val1+"'";
 System.out.println(query1);
 %>
 <select id ='cityval' name='cityval' style="width:120px;">
 <option value='-1'>Select</option>
 <%
 try {
		p5=connection.prepareStatement(query1);
		rs1 = p5.executeQuery();
		while (rs1.next()) {
			String city=rs1.getString("city");
			//System.out.println(city);
			int cno=rs1.getInt("sid");
			%>
			
			<option value="<%=city%>"><%=city%></option>
			<%

		}

 }catch (Exception e) {
			System.out.println(e);
		}
		
%>
</select>
<%}%>