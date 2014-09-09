<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="connection.jsp" %>
    <%@page import="java.util.ArrayList" %>
    <style>
    .tt{
    width:120px;
    }
    </style>
    <script>
    var xmlHttp;
    var divcount;
    var divnum;
	function showState(str) {
		if (typeof XMLHttpRequest != "undefined") {
			xmlHttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (xmlHttp == null) {
			alert("Browser does not support XMLHTTP Request")
			return;
		}

		//  var str = (document.getElementById('district').options[document.getElementById('district').selectedIndex].text);
//alert(str);
divcount = str.substring(0, 1);
divnum= str.substring(0, 1);

divcount="state"+divcount;
 str = str.substring(1);
 //alert(str+"***"+divcount);
//alert(divnum);
		var url = "statecityview.jsp?count="+str+"&&status=stateview&&divnum="+divnum;
	

		xmlHttp.onreadystatechange = stateChange;
		xmlHttp.open("GET", url, true);
		xmlHttp.send(null);
	}

	function stateChange() {
		if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
			document.getElementById(divcount).innerHTML = xmlHttp.responseText
		//	alert(divnum);
			 $('#'+divnum+'stateval').change(function()
			  	         {   
				// alert(divcount);
				// var count= $('#'+divnum+'stateval').val();
				
				//alert("divnum"+divnum);
				var count= $( this ).val();
				var count1= $( this ).val();
				
			// alert("this "+count);
				 count=count.substring(1);
				// alert(count);
				 var citynum=count1.substring(0,1);
				 var a="cityview";
				 $.post("statecityview.jsp",{'count':count,'status':a},function(data){
    		 if(data.length >0) 
    	     {
    			// alert("citynum"+citynum);
    	       $('#city'+citynum).html(data);  
    	     }
				 });
				 
				 
				 
			  	         });
		
		}
	}

    </script>
    <%
    String levels=request.getParameter("level");
   System.out.println("selected level is: "+levels+"<br>");
    String c_id=request.getParameter("c_id");
    System.out.println("company sid "+c_id);
    String selected_name=request.getParameter("selected_name");
    System.out.println("selected_name= "+selected_name);
    
String status=request.getParameter("status");

%>

<%

if(status.equals("createorg")){
	
    %>
    <div style="margin-top:10px;">
    
enter the number of Records : <input type="text" id="rno" value="1" name="rno"><br>
<input type="button" class="btn btn-primary" id="sub" value="createusers">
</div>
<%} %>

<!-- dropdown -->
<div id="users">
<%if(status.equals("createusers")){
	ArrayList<Object> uid = new ArrayList<Object>();
	ArrayList<Object> uname = new ArrayList<Object>();
	int rno=Integer.parseInt(request.getParameter("rno"));
	//out.println("no of elt: "+rno+"  ");
	int level=Integer.parseInt(request.getParameter("level"));
	//out.println("level"+level);
	//out.println(rno);
	 ResultSet rs=null;
    p=connection.prepareStatement("Select * from org_level where base="+level+" and cid="+c_id);
    rs=p.executeQuery();
    uid.clear();
    uname.clear();
    while(rs.next())
    {
    	int id=rs.getInt("sid");
    	
    	String name=rs.getString("name");
    	System.out.println(id+"***"+name);
    	uid.add(id);
    	uname.add(name);
    } 
	%>

<table>
<thead>
<tr>

<th>Root</th>

<th>Name</th>
<th>Designation</th>
<th>Access</th>
<th>Zone</th>
<th>State</th>
<th>city</th>

</tr>
</thead>
<tbody>
<% for(int i=0;i<rno;i++)
 {
 %> 
<tr>

<td> <select id="root" name="root" class="tt">
<option value="">***SELECT***</option>
<%for(int z=0;z<uid.size();z++){
%>
 <option <%if(uname.get(z).equals(selected_name)){%> selected <% } %> value="<%=uid.get(z)%>"><%=uname.get(z) %></option>
<%} %>
</select></td>    

<td> <input type="text" id="name1" name="name1" class="tt"></td>    
<td> <input type="text" id="desig" name="desig" class="tt"></td>   
<td><select id="spec" name="spec" class="tt"><option value="">***Select***</option>
<option value="zone">Zone level</option>
<option value="state">state level</option>
<option value="city">city level</option>
</select></td> 
<td> <select id="zone" name="zone"  onchange="showState(this.value)" class="tt"><option value="">***Select***</option>
<option value="<%=i %>north">North</option>
<option value="<%=i %>east">East</option>
<option value="<%=i %>west">West</option>
<option value="<%=i %>south">South</option>
<option value="<%=i %>central">Central</option>
</select></td> 
<td> <div id="state<%=i %>" class="tt">click zone</div></td> 
<td> <div id="city<%=i %>" class="tt">click state</div></td> 

</tr>
       
<%
 }
%>	
</tbody>
</table>
 <br> 
 <input type=button class="btn btn-primary" id=but value="update" ><br><br>
   
<div id="samp">

</div> 
<%} %>
  
</div>


<%

if(status.equals("reportaccess"))
{
%>
<div style="margin-top:10px;">
<%
ArrayList<Object> reportlist = new ArrayList<Object>();
ResultSet rs=null;
    p=connection.prepareStatement("SELECT reports FROM access_restriction where status=0");
    rs=p.executeQuery();
    reportlist.clear();
    while(rs.next())
    {
    	String name=rs.getString("reports");
    	System.out.println("rep"+name);
    	reportlist.add(name);
    } 
    %>

<ol>
<% for(int i=0;i<reportlist.size();i++)
 {
	System.out.println("rep1111  "+reportlist.get(i));
 %> 
 <li><input type="checkbox" name="creports" value="<%out.println(reportlist.get(i)); %>"><%out.println(reportlist.get(i)); %></input></li> 
 <%} %>
 <!-- 
<li><input type="checkbox" id="r1" name="creports" value="daily"></input>Daily sales</li>
<li><input type="checkbox" id="r2" name="creports" value="monthly"></input>Monthly sales</li>
<li><input type="checkbox" id="r3" name="creports" value="mis"></input>Mis at a glance</li>
<li><input type="checkbox" id="r4" name="creports" value="Finance"></input>Finance </li>
-->
</ol> 
<input type="button" value="add reports" id="areport"></input>
<div id="block_report"></div>

</div>


<%} %>


