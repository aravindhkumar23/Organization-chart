<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="connection.jsp" %>
<%
if(session.getAttribute("uname")!=null)
{
ResultSet rs=null;
    
    ResultSet rs1=null;
    String uname=session.getAttribute("uname").toString();
System.out.println(uname);
    /* String pass=session.getAttribute("pass").toString(); */
    String c_id=null;
    int id=0;
    String name=null;
    String c_name=null;
    int root=0;
    String str_root=null;
    String desig_name=null;
    int base=0;
    String name_manipul=null;
    
    
    
    
    p=connection.prepareStatement("Select * from trial_userlist where auname='"+uname+"'");
    rs1=p.executeQuery();
    if(rs1.next()){
    	c_id=rs1.getString("sid");
    	c_name=rs1.getString("uname");
    	
    }
    else
    {
    //	out.println("no such user kindly register urself");
    	//out.println("<a href='Registration.jsp'> here</a>");
    }
    %>
             
<!DOCTYPE html>
<html lang="en">
<head>
	
	<meta charset="utf-8">
	<title>Dashboard</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- ******************************************************************* -->
		
		
    
    <script type="text/javascript" src="googlejsapi.js"></script>
    <script type="text/javascript" src="jquery-1.2.6.min.js"></script>
    
 <link href="bootstrap.css" rel="stylesheet">
	<link rel="stylesheet" href="avgrund.css">
	<script type="text/javascript" src="avgrund.js"></script>
	<script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>

	
	</style>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['orgchart']});
    </script>
    <script type="text/javascript">
      function drawVisualization() {
        // Create and populate the data table.
        var data = google.visualization.arrayToDataTable([
                                                          ['Name','Manager', 'Tooltip'],
                                                        
                                                       <%   p=connection.prepareStatement("Select * from org_level where cid='"+c_id+"' and status=0");
                                                      	rs=p.executeQuery();
                                                      	while(rs.next()){
                                                      		id=rs.getInt("sid");
                                                      		name=rs.getString("name");
                                                      		root=rs.getInt("root");
                                                      		 base=rs.getInt("base");
                                                      		desig_name=rs.getString("designation");
                                                      		str_root=Integer.toString(root);
                                                      		str_root="'"+str_root+"'";
                                                      		name_manipul=base+"//"+name+"//"+id;
                                                            	if(base==0)
                                                            	{
                                                            		str_root=null;
                                                            	}
                                                            	
                                                            	System.out.println(id+"***********"+name+"**********"+root +"*****"+str_root+ "*****"+desig_name);
                                                      	
                                                            	
                                                            	%>
                                                            	[{v:'<%=id%>', f: '<%=name%><br/><div id="<%=name_manipul%>" onclick="test(this.id)" ><font color="red"><i><%=desig_name%> <i></font></div>'},<%=str_root%>, '<%=name%>'],
                                                            	<%
                                                            	
                                                      	}
                                                          %>
                                                          	 
                                                          
                                                          ]);
       // alert(data);
        // Create and draw the visualization.
        new google.visualization.OrgChart(document.getElementById('visualization')).
            draw(data, {allowHtml: true});
      }
      

      google.setOnLoadCallback(drawVisualization);
      
     
      
      
      function test(a)
     {
    	  var splits = a.split("//");
    	  var a=splits[0];
    	 // alert("a= "+a);
    	  var x=splits[1];
    	  //alert("x= "+x);
    	  var js_id=splits[2];
    //	  alert("x= "+x);
    	 /* document.getElementById('visualization').style.display="none"; */
    	  var status="createorg";
    	//  $('#myModal').modal('show');
    	Avgrund.show( "#default-popup" );
    	 document.getElementById("uid").innerHTML="You are looking into id:"+x;
    	 document.getElementById('div_report').style.display="none";
    	 document.getElementById('levele').style.display="none";
    	
    	 $('#add').click(function(){
	    	   $('#levele').show();
	    	   $('#div_report').hide();
	      	 $.post("popup.jsp",{'c_id':<%=c_id%>,'level':a,'status':status,'selected_name':x},function(data){
	      		 if(data.length >0) 
	      	     {
	      	       $('#levele').html(data);  
	      	   //    $('#levele').show();
	      	       $('#sub').click(function(){
	      	    	   var rno=$('#rno').val();
	      	    	  //alert(rno);
	      	    	  var status="createusers";
	     	    	   $.post("popup.jsp",{'c_id':<%=c_id%>,'rno':rno,'level':a,'status':status,'selected_name':x},function(data)
	     		  	             {
	     		  	             if(data.length >0) 
	     		  			     {
	     		  	            	 $('#users').html(data);
	     		  	           
	     		  	            $('#but').click(function()
	  	  				  	         {   
	  	  				  			 // alert("hello");
	  	  				  			var root = [];
	  	  				  			var name = [];
	  	  				  			var desig = [];
	  	  				  		var spec = [];
	  	  				  	var zone = [];
	  	  				  var stateval = [];
	  	  				var cityval = [];
	  	  				
	  				  			    $("select[name='root']").each(function(i){
	  				  			    	root[i] = $(this).val();
	  				  						});
	  				  			  $("input:text[name='name1']").each(function(i){
	  				  			    	name[i] = $(this).val();
	  				  						});
	  				  			$("input:text[name='desig']").each(function(i){
	  			  			    	desig[i] = $(this).val();
	  			  						});
	  				  			
	  				  			 $("select[name='spec']").each(function(i){
	  				  			    	spec[i] = $(this).val();
	  				  						});
	  				  			
	  				  			$("select[name='zone']").each(function(i){
	  			  			    	zone[i] = $(this).val();
	  			  						});
	  				  			
	  				  			$("select[name='stateval']").each(function(i){
	  			  			    	stateval[i] = $(this).val();
	  			  						});
	  				  			
	  				  			$("select[name='cityval']").each(function(i){
	  			  			    	cityval[i] = $(this).val();
	  			  						});
	  				  			// alert(spec);
	  				  			//alert(zone);
	  				  			//alert(stateval);
	  				  			//alert(cityval);
	  				  			// alert(root);
	  				  		//	alert(name);
	  				  			   /*  alert(root);
	  				  			  alert(name);
	  				  			alert(desig);  */
	  				  			$.post("./level1rec.jsp",{'root':root,'name':name,'desig':desig,'c_id':<%=c_id%>,'level':a,
	  				  				'spec':spec,'zone':zone,'stateval':stateval,'cityval':cityval},function(data)
	  					  	             {
	  				  				window.location.href="org-config.jsp";
	  				  				//closeDialog();
	  					  	             });
	  				  			
	  	  				  	         });
	     		  			     }
	     		  	             });
	     					  			 
	      	       });
	      	     }
	      	 }); 
	    	  
	       });
	       
	       $('#rep').click(function(){
	    	   
	    	   var status="reportaccess";
	    	   
	    	  
	    	   $('#levele').hide();
	    	 //  $('#users').hide();
	    	 
	    	 $.post("popup.jsp",{'status':status},function(data){
    		 if(data.length >0) 
    	     {
    	       $('#div_report').html(data);  
    	       $('#div_report').show();
    	       
    	       $('#areport').click(function(){
    	    	   //alert("hello");
    	    	   var checkreport=[];
    	    	   $("input[name='creports']:checked").each(function(i){
    	    		   checkreport[i] = $(this).val();
     						});
    	    	// alert("id "+js_id);
    	    	
    	    	// alert("selected rep "+ checkreport);
    	    	 var status="reportServer";
    	    	// alert("name "+x);
    	    	 $.post("masterServlet.jsp",{'status':status,'uid':js_id,'checkreport':checkreport,'name':x},function(data){
    	    		 if(data.length >0) 
    	    	     {
    	    	       $('#block_report').html(data);  
    	    	     }
    	    	 });
    	       });
    	       
    	     }
	    	 });
	       });
	       $('#delete').click(function(){	    
	    	   alert("Are you sure delete----"+x);
	    	   var status="delete";
	    	    $.post("masterServlet.jsp",{'c_id':<%=c_id%>,'level':a,'status':status,'selected_name':x},function(data){
	    	    	window.location.href="org-config.jsp";	    	    	
	    	    });
	       });
	       
	      
     }
      function closeDialog() {
			Avgrund.hide();
			/*   document.getElementById('visualization').style.display="block"; */ 
		//	window.location.href="test.jsp";
		}
      
    </script>
 
	
		
		<!-- ******************************************************************** -->
		
		
</head>

<body>
		<!-- topbar starts -->
	<!-- topbar ends -->

		<div class="container-fluid">
		<div class="row-fluid">
				
			<!-- left menu starts -->
			<!-- left menu ends -->
			
			
			<div id="content" class="span10">
			
			 <aside id="default-popup" class="avgrund-popup" style="width:900px;height:300px;overflow-y:scroll;">
			<button class="pull-right" id="cancel" onclick="javascript:closeDialog();">Cancel</button>
<h2 style="font-size:14px;margin-left:300px;font-weight:bold;" id="uid"></h2>

		
			<input type="button" class="btn btn-primary"  id="add" value="Add Users" style="width:300px;"></input>
<input type="button" class="btn btn-primary" id="rep" value="Reports" style="width:300px;"></input>
<input type="button" class="btn btn-primary" id="delete" value="Delete" style="width:100px;"></input>
			<div id="levele" ></div>
			
			<div id="div_report" >

</div> 
			
		</aside>  
		
			<!-- content starts -->
				<div>
				<ul class="breadcrumb">
					<li>
						<a href="#">Home</a> <span class="divider">/</span>
					</li>
					<li>
						<a href="#">Organisation</a>
					</li>
				</ul>
			</div>

			
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-list"></i> Define Your Organisation structure</h2>
						
					</div>
					<div class="box-content">
					
  <div class="alert alert-error">
							
							If you find any difficulties please contact our Technical team at 342/87/88 or mail us at solutions@aaa.com
						</div>
					
    <div id="visualization"></div>
    
   
   
						
					</div>
				</div><!--/span-->
				
				</div><!--/span-->
			</div><!--/row-->
			
			
			
			
			
				  

		  
       
	</div><!--/.fluid-container-->
	
	
	<br>
		<div class="container-fluid" style="background-color:#D4DDE6">


	 
			
	</div>
	
	<%
try
{
	if(rs!=null)
		rs.close();
	if(rs1!=null)
		rs1.close();
	
	if(p!=null)
		p.close();
	if(connection!=null)
		connection.close();
}
catch(Exception e)
{}
%>
	
	<%}
else{ 
		
		
		
		response.sendRedirect("admin-login.jsp");
	}
	%>
	

</body>
</html>
