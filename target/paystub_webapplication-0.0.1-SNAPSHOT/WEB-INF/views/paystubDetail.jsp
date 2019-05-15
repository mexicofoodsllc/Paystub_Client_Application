<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<%@ page isELIgnored="false" %>
    <title>El Rancho Employee Pay Check</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js" integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/" crossorigin="anonymous"></script>
    <style>
        .navbar-color {
            margin-top: 20px;
            padding: 1pc;
            font-size: 20px
        }
		
		.navbar-inverse {
			border-color:white;
		}
        h3 {
            font-size: 20px;
            color: #777;
            font: 22px "DINNextLTPro-Regular", sans-serif;
        }

		 .paystub_btn{
        	    background-color: #ba150f;
    			margin: 50px;
   				color: white;
    			border: #eee;
    			padding: 13px;
    			font-size: 15px;
        }
        .pay_div {
        	color: #777;
            font: 20px "HelveticaNeue-Roman", sans-serif;
            margin: -16px 0;
        }
		
        .nav>li:hover {
            /* background-color: #b85855; 
            background-color: #9c0702;*/
			background-color: transparent;
            opacity: 0.6 !important;
        }

       .latestPaycheckLabel,
       .latestPaycheckNumber {
       		font-size:15px;
       }

        .PaycheckLabel {
            font-weight: bold;
            font-size:15px;
        }

		tr:hover{
			background-color:white;
		}
		tr:hover td {
    		background-color: transparent; 
		}
       td:nth-child(2) {
 			 /*text-align: left; /* NEW */
		}
       


        /* On screens that are 900px or less, set the background color to olive */
        @media screen and (max-width: 900px) {
            .pay_div {
                font-size: 15px;
            }
        }

         /* On screens that are 600px or less, set the background color to olive */
         @media screen and (max-width: 600px) {
            .pay_div {
                font-size: 13px;
            }
           
        }
    </style>
</head>

<body>
	
    <nav class="navbar navbar-inverse navbar-static-top navbar-color" role="navigation" style="background-color:white">
        <div class="container">
            <div class="navbar-header">
				<img src="https://s3.amazonaws.com/wbd.employer-images/01984_logo_1522248608_v.jpg" width="200" height="142"/>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
                    <li>
                    	<form action="paystubSummary" method="post">
                    		<input type="hidden"
            						name="${_csrf.parameterName}"
            						value="${_csrf.token}"/>
                    		<input type="submit" value="Paystub Summary" class="paystub_btn"/>
                    	</form>
                    </li>
				</ul>

                <ul class="nav navbar-nav navbar-right">
                   <li style="color:#ba150f;">
						<form action="/logout" method="post">
    						 <input type="hidden"
            						name="${_csrf.parameterName}"
            						value="${_csrf.token}"/>
  							 <input type="submit" value="Logout">
  						</form>
        			</li>
                </ul>
            </div>
        </div>
    </nav>
 
    <div class="container" style=",background-color:white">
        <div class="jumbotron" style="height: 100%">  
            <div id="paycheckAmount" class="pay_div">
            	<p class="PaycheckLabel">Earnings</p>
            	
                <table class="table table-hover"> 
                  <tr>
    				<th class="PaycheckLabel">Description</th>
    				<th class="PaycheckLabel">Current</th> 
   					<th class="PaycheckLabel">Hours</th>
    				<th class="PaycheckLabel">Year to Date</th>
 				  </tr>
                    <tbody>
						 
                    	<c:forEach var="paystub" items="${paystubList}">
                    		<c:set var = "hour" scope = "session" value = "${paystub.hours}"/>
                    		<c:if test="${hour ne 0}">
	                    		<tr>
			                      	<td class="latestPaycheckLabel">${paystub.description}</td>
			                      	<td class="latestPaycheckNumber">$${paystub.currentAmount}</td>
			                      	<td class="latestPaycheckLabel">${paystub.hours}</td>
			                      	 <td class="latestPaycheckNumber">$${paystub.ytdAmount}</td> 
			                	</tr> 
		                	 </c:if>
		                 </c:forEach>
                     </tbody>
                </table>
                <p class="PaycheckLabel">Taxes&Deduction</p>
                <table class="table table-hover"> 
                 <tr>
    				<th class="PaycheckLabel" style="width: 30%;">Description</th>
    				<th class="PaycheckLabel" style="width: 39%;">Current</th> 
    				<th class="PaycheckLabel">Year to Date</th>
 				  </tr>
                    <tbody>
						 
                    	<c:forEach var="paystub" items="${paystubList}">
                    		<c:set var = "hour" scope = "session" value = "${paystub.hours}"/>
                    		<c:if test="${hour eq 0}">
	                    		<tr>
			                      	<td class="latestPaycheckLabel">${paystub.description}</td>
			                      	<td class="latestPaycheckNumber">$${paystub.currentAmount}</td>
			                      	<td class="latestPaycheckNumber">$${paystub.ytdAmount}</td> 
			                	</tr> 
		                	 </c:if>
		                 </c:forEach>
                     </tbody>
                </table>
                
                <table class="table table-hover">
                	<tbody>
                		<tr>
                			<td  class="PaycheckLabel">Net Pay</td>
                			<td class="latestPaycheckLabel" style="width: 70%;">${NetPay}</td>
                		</tr>
                	</tbody>
                
                </table>
            </div>
		
            <button class="btn btn-primary hidden-print" ><span class="glyphicon glyphicon-print" aria-hidden="true"></span> Print</button>
	    

        </div>
        <div class="footer">
            <p>&copy ElRancho Supermercado</p>
        </div>
    </div>

</body>

</html>