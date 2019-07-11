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
			font-size:12px !important;
			color:red;
		}
	</style>

</head>

<body>
   <div class="container">
   
  	<h2 style="text-align:center"><strong>Security Questions</strong></h2>
  	
  <div class="jumbotron">
  	<h3>This will help to reset your password</h3>
    <form:form action="securityQnValidate" method="post">
    	<div class="form-group">
     		Employee ID<input type="text" name="empId" id="empId" class="form-control" placeholder="Employee ID" required/>
        </div>
	    <div class="form-group">
	     	Date of Birth(mm/dd/yyyy)<input type="text" id="dob_picker" name="dob" id="dob" class="form-control" placeholder="Date of Birth" required/>
	    </div>
    	<div class="form-group">
     		Last 4 digits of SSN<input type="text" name="ssn" id="ssn" maxLength="4" class="form-control" placeholder="Last 4 digits of SSN" required/>
        </div>
        <p class="pwdinvalid">${errMsgSecQuestion }</p>
        <div class="form-group"> 
              <input type="submit" value="Next" id="next" class="btn btn-primary btn-block"/>
         </div>
     </form:form>
   
  </div>
  <div class="footer">
   <p>&copy ElRancho Supermercado</p>
  </div>
 </div>
 
 <script>
	$( function() {
		$( "#dob_picker" ).datepicker(); 
		
	});	
	
	$('#next').click(function(e) {	
	  	var userName = $('#empId').val()
	  	//alert(userName)
		sessionStorage.setItem('userName', userName)
		
	});	
	
	 $(document).on('keypress',function(e) {
	     if(e.which == 13) {
	    		var userName = $('#empId').val()
	    	  	//alert(userName)
	    		sessionStorage.setItem('userName', userName)
	     }
	 });
	

	 
	
	</script> 
</body>
</html>