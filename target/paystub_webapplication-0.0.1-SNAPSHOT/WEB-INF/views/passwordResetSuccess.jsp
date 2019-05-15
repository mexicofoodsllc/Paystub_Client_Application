<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Password Reset Success</title>
<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://chancejs.com/chance.min.js"></script>
   <!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 

<style type="text/css">
    body {
		font-family: 'Varela Round', sans-serif;
	}
	.modal-confirm {		
		color: #434e65;
		width: 525px;
	}
	.modal-confirm .modal-content {
		padding: 20px;
		font-size: 16px;
		border-radius: 5px;
		border: none;
	}
	.modal-confirm .modal-header {
		background: #47c9a2;
		border-bottom: none;   
        position: relative;
		text-align: center;
		margin: -20px -20px 0;
		border-radius: 5px 5px 0 0;
		padding: 35px;
	}
	.modal-confirm h4 {
		text-align: center;
		font-size: 36px;
		margin: 10px 0;
	}
	.modal-confirm .form-control, .modal-confirm .btn {
		min-height: 40px;
		border-radius: 3px; 
	}
	.modal-confirm .close {
        position: absolute;
		top: 15px;
		right: 15px;
		color: #fff;
		text-shadow: none;
		opacity: 0.5;
	}
	.modal-confirm .close:hover {
		opacity: 0.8;
	}
	.modal-confirm .icon-box {
		color: #fff;		
		width: 95px;
		height: 95px;
		display: inline-block;
		border-radius: 50%;
		z-index: 9;
		border: 5px solid #fff;
		padding: 15px;
		text-align: center;
	}
	.modal-confirm .icon-box i {
		font-size: 64px;
		margin: -4px 0 0 -4px;
	}
	.modal-confirm.modal-dialog {
		margin-top: 80px;
	}
    .modal-confirm .btn {
        color: #fff;
        border-radius: 4px;
		background: #eeb711;
		text-decoration: none;
		transition: all 0.4s;
        line-height: normal;
		border-radius: 30px;
		margin-top: 10px;
		padding: 6px 20px;
        border: none;
    }
	.modal-confirm .btn:hover, .modal-confirm .btn:focus {
		background: #eda645;
		outline: none;
	}
	.modal-confirm .btn span {
		margin: 1px 3px 0;
		float: left;
	}
	.modal-confirm .btn i {
		margin-left: 1px;
		font-size: 20px;
		float: right;
	}
	.trigger-btn {
		display: inline-block;
		margin: 100px auto;
	}
</style>
</head>
<body>


<!-- Modal HTML -->

	<div class="modal-dialog modal-confirm">
		<div class="modal-content">
			<div class="modal-header">
				<div class="icon-box">
					<i class="material-icons">&#xE876;</i>
				</div>
			</div>
			<div class="modal-body text-center">
				<h4>Great!</h4>	
				<p>Your password has been reset successfully.</p>
				<form:form action="home" method="post" id="pwdreset-form">
					<button class="btn btn-success" id="login" data-dismiss="modal"><span>View Pay stub</span> <i class="material-icons">&#xE5C8;</i></button>
				</form:form>
			</div>
		</div>
		<div class="footer">
   			<p>&copy ElRancho Supermercado</p>
        </div>
	</div>
	<script>
    
    $('#login').click(function(e) {

   	 var password = sessionStorage.getItem('pwd')
   	 console.log(password)
   	 


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
   	                 console.log("Password is incorrect");
   	                 
   	                 $('.pwdinvalid').html("Password is incorrect!");
   	                        
   	                 }
   	 else{
   	                 
   	                    
   	                     //console.log(authToken);
   	                     sessionStorage.setItem('token', authToken);
   	 $("#pwdreset-form").submit();
   	                 
   	 }       
   	          
   	             });
    });
	</script>
     
</body>
</html>                                                        