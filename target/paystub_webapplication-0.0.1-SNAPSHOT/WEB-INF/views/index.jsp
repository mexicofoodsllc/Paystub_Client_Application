<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

	<!-- Static content -->

	
	<title>Employee Login</title>
	
	<script type='text/javascript'>

	</script>
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

		.pwdinvalid{
			font-size:15px !important;
			color:red;
		}
         /* On screens that are 900px or less, set set the jumbotron width*/
        @media screen and (max-width: 900px) {
            .jumbotron {
                 width: 50%;
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
  
    <form:form  action="home" method="post" id="login-form">
    	<p>Employee Login<p>

    	<div class="form-group">
     		<input type="password" name="pwd" id="password" minlength="6" class="form-control" placeholder="Password" required/>
			<div class="pwdinvalid"></div>
        </div>
		     <!-- <input type="hidden"
            name="${_csrf.parameterName}"
            value="${_csrf.token}"/> -->
        <div class="form-group"> 
              <input type="button" id="login" value="Login" class="btn btn-primary btn-default button_style" />
        </div>
     </form:form>
   
   	<div class="bottom-container">
   		<form:form action="register" method="post">
   			<div class="form-group">
	  			<input type="submit"class="btn btn-primary btn-default button_style" value="Register"/>
	  		</div>
	  	</form:form>
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
 
 $('#login').click(function(e) {

	 var password = $('#password').val()
	 sessionStorage.setItem('pwd', password)


	     var dataPayload = {
	                "userName" : password,
	                "password" : password
	         };

	         $.ajax({
	                 url: "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/login",
	                 data:JSON.stringify(dataPayload),
	                 type:'POST',
	                 contentType: 'application/json',
	         
	             }).then(function(data,status, xhr) {
	            	 var authToken = xhr.getResponseHeader('Authorization');
	 if (authToken == null) {
					 e.preventDefault();
	                 //console.log("Password is incorrect");
	                 
	                 $('.pwdinvalid').html("Password is incorrect!");
	                        
	                 }
	 else{
	                 
	                    // var authToken = xhr.getResponseHeader('Authorization');
	                     console.log(authToken);
	                     sessionStorage.setItem('token', authToken);
	 $("#login-form").submit();
	                 
	 }       
	          
	             });
 });

 </script>

</body>
</html>