<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title></title>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	 <link href="bootstrap.css" rel="stylesheet">
    <link href="flat-ui.css" rel="stylesheet">
</head>
<body>


<div class="container login">
        <div class="login-screen">
          <div class="login-icon">
            <img src="../template/img/login.png" style="background-color:white;" alt="geni" />
            <h4>Welcome </h4>
          </div>
<form name="test" action="#" id="login_frm">
          <div class="login-form">
            <div class="form-group">
              <input type="text" id="username" name="uname" class="form-control login-field" value="" placeholder="Enter your name" />
              <label class="login-field-icon fui-user" for="login-name"></label>              
            </div>

            <div class="form-group">
              <input type="password" class="form-control login-field" value="" placeholder="Password" name="pass" id="password" />
              <label class="login-field-icon fui-lock" for="login-pass"></label>              
            </div>
            <div id="msgbox"></div>
            <input type="hidden" value="adminlogin" name="check" id="check">
            <input class="btn btn-primary btn-lg btn-block" type="submit" id="login_form" value="Log in"/>
</div>
</form>            
            <a class="login-link" href="#">Lost your password?</a>
          </div> 
          </div>
        
          <script type="text/javascript" src="jquery-1.4.2.min.js"></script>
          <!-- <script type="text/javascript" src="js/jquery-1.2.6.min.js"></script> -->
	<script type="text/javascript">
	$(document).ready(function(){
		$("#login_frm").submit(function(){
	         $("#msgbox").text('Validating Your Login ').fadeIn(1000);
			this.timer = setTimeout(function () {
				$.ajax({
		          	url: 'login-validation.jsp',
		        	data: 'uname='+ $('#username').val() +'&pass=' + $('#password').val() +'&check=' + $('#check').val(),
		          	type: 'post',
		   			success: function(msg){
		   				var reply= msg.replace(/\s+/, "");
						if(reply!="ERROR")
						{ 
							 $("#msgbox").html('Login Verified, Logging in.....').fadeTo(900,1,function()
			                  {
			                     //redirect if matches 
			                     document.location='login-session.jsp?uname='+reply;
			                  }); 
						}
						else
						{
							 $("#msgbox").fadeTo(200,0.1,function() //start fading the messagebox
		                	{
			                  $("#msgbox").html('Sorry, Wrong Combination Of Username And Password.').fadeTo(900,1);
			                });
						}
					}
				});
			}, 200);
			return false; 
 		});		
	});

	</script>
		
	 </body>
</html>
