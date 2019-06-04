<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Paystub Summary</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.3.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
     <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.7/jquery.validate.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> 
    <script src="https://unpkg.com/jspdf@latest/dist/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js" integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/" crossorigin="anonymous"></script>
   <!--  <script>src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"</script>  -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.1.1/jspdf.plugin.autotable.js"></script>
  	<link href="css/paystub_styles.css"  rel="stylesheet">
	<script src="js/paystubApp.js"></script> 
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
            	
                <center><h2><strong>Pay Stub Portal</strong></h2></center>
                 
            	<ul class="nav navbar-nav navbar-right">
                    <li style="color:#ba150f;">
						<form:form action="logout" method="post">
							<!-- <img src="images/logout.jpg" width="50" height="50" style="margin-left: 10px;"  id="img"/><br> -->
  							 <input type="submit" class="logout" value="Logout" id="logout">
  						</form:form>
        			</li>
             	</ul>
            </div>
        </div>
    </nav>
    

    <div class="container">
    	<div id="empId" class="text-primary empStyle"></div>
    	<div id="empName" class="text-primary empStyle"></div>
        <div class="jumbotron">
            


           <div id="totalPaySummary" class="pay_div">
            	
                 <table class="table table-hover" id="summaryTable">
				  <thead>
				    <tr>
				    	<th>PAY PERIOD END DATE</th>
     					<th>GROSS PAY</th>
     					<th>NET PAY</th>
     					<th>HOURS</th>
				    </tr>
				  </thead>
				  <tbody>

				  </tbody>
				  </table>
            </div>  
            
            <div id="jumbatron_wait" style="display:none;width:69px;height:89px;position:absolute;top:50%;left:50%;padding:5px;">
          		<img src="images/popup_loading.gif" width="64" height="64" />
            </div> 
          </div>
          

          
          <div class="modal fade" id="myModal">
  			<div class="modal-dialog">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        				<center><h4 class="modal-title">Pay Stub Details</h4></center>
      				</div>
      			<div class="modal-body" id="printableArea">
      				<div id="employerDetails" class="hidden">
            	
                 <table id="employerTable">
                 	 <thead>
                 	 	<tr>
                 	 		<th style="width: 50%;">EMPLOYER</th>
                 	 		<th style="width: 50%;">EMPLOYEE</th>
                 	 	</tr>
	                 </thead>
					 <tbody>
					  </tbody>
				  </table>
            </div>
            
   			
      			    <div id="modal_wait" style="display:none;width:69px;height:89px;position:absolute;top:50%;left:50%;padding:2px;">
          				<img src="images/popup_loading.gif" width="64" height="64" />
            		</div> 
            		

            		<table class="table table-hover paystubDatesTable" id="paystubDatesTable"> 
			                <thead>
			                  <tr>
			    				<th class="PaycheckLabel" >Check Date</th>
			    				<th class="PaycheckLabel" >Period End Date</th> 
			    				<th class="PaycheckLabel">Check Number</th>
			 				  </tr>
			                </thead>
		                	<tbody>
							</tbody>

                	</table>
                
            		
			 			<table class="table table-hover earningTable" id="earningTable"> 
		                    <thead>
                   				<tr>
							         <th class="PaycheckLabel">Earnings</th>
							         <th class="PaycheckLabel">Current</th> 
							         <th class="PaycheckLabel">Hours</th>
							         <th class="PaycheckLabel">Year to Date</th>
							        </tr>
							</thead>
							<tbody>
							</tbody>
		                   
                		</table>
                	
                
                		<table class="table table-hover deductionTable" id="deductionTable"> 
			                <thead>
			                  <tr>
			    				<th class="PaycheckLabel">Deductions</th>
			    				<th class="PaycheckLabel">Current</th> 
			    				<th class="PaycheckLabel">Year to Date</th>
			 				  </tr>
			                </thead>
		                	<tbody>
							</tbody>

                		</table>
                
               			 <table class="table table-hover totalPayTable" id="totalPayTable">
               			  <thead>
			                  <tr>
			    				<th class="PaycheckLabel" style="width: 33.3%;">Gross Pay</th>
			    				<th class="PaycheckLabel" style="width: 33.3%;">Deductions</th>
			    				<th class="PaycheckLabel">Net Pay</th> 
			 				  </tr>
			               </thead>
                			<tbody>
                		
                			</tbody>
                
                		</table>
                		

      			</div>
      		<div class="modal-footer">
       			 <button class="btn btn-primary hidden-print print" ><span class="glyphicon glyphicon-print " id="print" aria-hidden="true"></span> Print</button>
     		</div>
   				 </div><!-- /.modal-content -->
  			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
           
          <div class="footer">
            	<p>&copy ElRancho Supermercado</p>
           </div>
        </div>
        
</body>

</html>