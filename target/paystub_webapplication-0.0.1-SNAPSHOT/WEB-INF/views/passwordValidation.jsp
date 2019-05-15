<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Security Questions</title>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<style>
		.pwdinvalid{
			font-size:15px !important;
			color:red;
		}
	</style>
	<script>
	$( function() {
	    $( "#dob_picker" ).datepicker();
	  } );
	
	 window.onload = function () {
	        var pwd1 = document.getElementById("pwd1");
	        var pwd2 = document.getElementById("pwd2");
	        pwd1.onchange = ConfirmPassword;
	        pwd2.onkeyup = ConfirmPassword;
	        function ConfirmPassword() {
	        	pwd2.setCustomValidity("");
	            if (pwd1.value != pwd2.value) {
	            	pwd2.setCustomValidity("Passwords do not match.");
	            }
	            else{
	            	password = $('#pwd1').val()
	            	sessionStorage.setItem('pwd', password);
	            }
	        }
	        
	        
	    }
	</script>
</head>

<body>
   <div class="container">
   
  	<h2 style="text-align:center"><strong>Password</strong></h2>
  	
  <div class="jumbotron">
  	<h3>Set up password</h3>
    <form:form action="pwdValid" method="post">
        <div class="form-group">
     		New Password  <input type="password" name="pwd1" id="pwd1" minlength="6" class="form-control" placeholder="New Password" required/>
        </div>
        <div class="form-group">
     		Confirm Password  <input type="password" name="pwd2" id="pwd2" minlength="6" class="form-control" placeholder="Confirm Password" required/>
     		 <span id='message'></span>
     		 <p class="pwdinvalid">${errMsgPwd }</p>
        </div>
        <div class="form-group"> 
              <input type="submit" value="Next" class="btn btn-primary btn-block"/>
         </div>
     </form:form>
   
  </div>
  <div class="footer">
   <p>&copy ElRancho Supermercado</p>
  </div>
 </div>
</body>
</html>