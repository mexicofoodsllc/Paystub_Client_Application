<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- <script src="js/paystubApp.js"></script>  -->
<script type='text/javascript'></script>
	
	<title>Employee Login</title>
	
	
	<style>

		.margin{
		    margin-top: 25px;
		    width:50%;
		}
		.button_style{
        	
        	background-color: #EC1313;
        	color:white;
        	border-color: #EC1313;
        }
        p{
        font-size:15px;
        }
        .form-control{
            width: 50% !important;
         }

		.error{
			font-size:15px !important;
			color:red;
		}
         /* On screens that are 900px or less, set set the jumbotron width*/
        @media screen and (max-width: 900px) {
            .jumbotron {
                 width: 60%;
            }
        }
         /* On screens that are 600px or less, set the jumbotron width */
         @media screen and (max-width: 600px) {
            .jumbotron {
                width: 100%;
            }
	</style>
</head>

<body>
   <div class="container">

  	<img src="https://s3.amazonaws.com/wbd.employer-images/01984_logo_1522248608_v.jpg" width="200" height="200"/>
 <div class="jumbotron margin">
  
    <form action="home" method="post" id="login-form">
    	<p>Employee Login<p>
    	
    	<div class="form-group">
     		<input type="text" name="empId" id="empId" class="form-control" placeholder="Employee ID" required/>
     		<div class="error" id="empIderror"></div>
        </div>

    	<div class="form-group">
     		<input type="password" name="pwd" id="password" minlength="6" class="form-control" placeholder="Password" required/>
     		<div class="error" id="pwdError"></div>
        </div>
		      <!--  <input type="hidden"
            name="${_csrf.parameterName}"
            value="${_csrf.token}"/>-->
        <div class="form-group"> 
              <input type="button" id="login" value="Login" class="btn btn-primary btn-default button_style" />
        </div>
     </form>
   
   	<div class="bottom-container">
   		<form action="register" method="post">
   			<div class="form-group">
	  			<input type="submit"class="btn btn-primary btn-default button_style" value="Register"/>
	  		</div>
	  	</form>
	  	<form:form action="forgotpwd" method="post">
	  		<div class="form-group">
	  			<input type="submit"class="btn btn-primary btn-danger" value="Forgot Password?"/>
	  		</div>
	  	</form:form>
	</div>
  </div>
  <div class="footer">
   <p>&copy ElRancho Supermercado</p>
  </div>
 </div>
 <script src="https://chancejs.com/chance.min.js"></script>
    <!-- Latest compiled and minified CSS -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   <!-- jQuery library -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <!-- Latest compiled JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

 <script>
 
 $(document).on('keypress',function(e) {
     if(e.which == 13) {
    	 
    	 var userName = $('#empId').val()
    	 var password = $('#password').val()
    	 
    	 if(userName!=""&& password!=""){
    		 sessionStorage.setItem('userName', userName) 
    		 sessionStorage.setItem('pwd', password)
    	 }
    	 
    	 else if(userName==""&& password==""){
    		 $('#empIderror').html("<i>Please enter Employee Id</i>");
    		 $('#pwdError').html("<i>Please enter password</i>");
    	 }
    	 else if(userName==""&& password!=""){
    		 $('#empIderror').html("<i>Please enter Employee Id</i>");
    	 }
    	 else if(userName!=""&& password==""){
    		 $('#empIderror').html("<i>Please enter password</i>");
    	 }
    	 
    	 var authorizationHeader;
    	 var isLoginSuccess = false;
    	     
        if(userName!=""&& password!=""){
    	 
        	var dataPayload = {
    	                "userName" : userName,
    	                "password" : password,
    	         };
        
    	        $.ajax({
    	                 url: "https://www.mxf-employeepaystub.com/paystubWS/login",
    	                 crossDomain: true,
    	                 data:JSON.stringify(dataPayload),
    	                 type:'POST',
    	                 async: false,
    	                 timeout: 10000,
    	                 contentType: 'application/json',
    	                 
    	             }).done(function(data,status, xhr) {
                  		 sessionStorage.setItem('authToken', xhr.getResponseHeader('Authorization'));
                         isLoginSuccess = true;
               	   		 $("#login-form").submit();
               	   		 
    	             });
                   	    
    	        if(isLoginSuccess === false ) {
                             // Login failed
                        	 
        	       //console.log("Password is incorrect"); 
        	       $('#empIderror').empty();
        	       $('#pwdError').html("<i>Please correct your Employee ID and/or Password!</i>");
        	       e.preventDefault();
        	                 
             			}
         
        } 
     }
     
 }); 
 
 $('#login').click(function(e) {

	 var userName = $('#empId').val()
	 var password = $('#password').val()
	 
	 if(userName!=""&& password!=""){
		 sessionStorage.setItem('userName', userName) 
		 sessionStorage.setItem('pwd', password)
	 }
	 
	 else if(userName==""&& password==""){
		 $('#empIderror').html("<i>Please enter Employee Id</i>");
		 $('#pwdError').html("<i>Please enter password</i>");
	 }
	 else if(userName==""&& password!=""){
		 $('#empIderror').html("<i>Please enter Employee Id</i>");
	 }
	 else if(userName!=""&& password==""){
		 $('#empIderror').empty();
		 $('#pwdError').html("<i>Please enter password</i>");
	 }
	 
	 var authorizationHeader;
	 var isLoginSuccess = false;
	     
    if(userName!=""&& password!=""){
	 
    	var dataPayload = {
	                "userName" : userName,
	                "password" : password,
	         };
    
	        $.ajax({
	                 url: "https://www.mxf-employeepaystub.com/paystubWS/login",
	                 data:JSON.stringify(dataPayload),
	                 type:'POST',
	                 crossDomain: true,
	                 async: false,
	                 timeout: 10000,
	                 contentType: 'application/jsonp',
	                 
	             }).done(function(data,status, xhr) {
              		 sessionStorage.setItem('authToken', xhr.getResponseHeader('Authorization'));
                     isLoginSuccess = true;
           	   		 $("#login-form").submit();
           	   		 
	             });
               	    
       if(isLoginSuccess === false ) {
                         // Login failed
                    	 
    	       //console.log("Password is incorrect"); 
    	       $('#empIderror').empty();
    	       $('#pwdError').html("<i>Please correct your Employee ID and/or Password!</i>");
    	       e.preventDefault();
    	                 
         			}
     
    } 
	           
 });

 </script>

</body>
</html>