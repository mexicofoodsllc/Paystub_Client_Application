<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    
<!-- Static content -->
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
        
        .regstyle{
            width: 400px !important;
    		margin: auto;
    	    margin-top: 150px; 
    	}
    	    	
</style>
<script src="https://chancejs.com/chance.min.js"></script>
    <!-- Latest compiled and minified CSS -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   <!-- jQuery library -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <!-- Latest compiled JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
 <script src="main.js"></script>
 

<title>Employee Registration</title>
</head>
<body>
   <div class="container">
   
  	<h2 style="text-align:center"><strong>Register to View, Download and Print your PayStub</strong></h2>
  	
  <div class="jumbotron regstyle">
    <form:form action="regmanagement" method="post">
	    <div class="form-group">
	     Employee ID<input type="text" name="empid" id="empId" class="form-control" placeholder="Employee ID" required/>
	    </div>
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
 $('#next').click(function(e) {	
	  	var userName = $('#empId').val()
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