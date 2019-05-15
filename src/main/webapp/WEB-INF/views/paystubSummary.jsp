<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js" integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/" crossorigin="anonymous"></script>
    <script>src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.1.1/jspdf.plugin.autotable.js"></script>
  	
  	
    
    <style>
    .navbar-color {
            margin-top: 60px;
            padding: 1pc;
            font-size: 20px;
        }
        
      .navbar-inverse {
			border-color:white;
		}

		.calenderdiv_style{
			width: 40%;
			color: #777;
            font: 15px "HelveticaNeue-Roman", sans-serif;
		}
		.jumbatron{
			-webkit-box-shadow: 0px 3px 11px 2px rgba(0,0,0,0.2) !important;
   			-moz-box-shadow: 0px 3px 11px 2px rgba(0,0,0,0.2) !important;
   			box-shadow: 0px 3px 11px 2px rgba(0,0,0,0.2) !important;
		}
        
		 .paystub_btn{
        	    background-color: #ba150f;
    			margin: 50px;
   				color: white;
    			border: #eee;
    			padding: 13px;
    			font-size: 15px;
        }
        

        .pay_div{
        	    color: #777;
            	font: 15px "HelveticaNeue-Roman", sans-serif;
            
        }
		
	   .pay_span{
		padding: 15px;
		margin:10px;
		}
		
		.pay_period{
			margin: 28px;
		}
		
		.net_pay{
		 margin: 31px;
		 }
        
        h2{
        	    color: #ba150f;
    			
        }
        
        .table {
   			 table-layout: fixed;
			 width: 100%;
			 cursor: pointer;
   		}
   		
        th{
       		width:110px;
        }

        .noPay{
        	background-color: yellow;
   			width: 50%;
   			border-style: solid;
  			border-color: black;
  			padding:10px;
        }
        .logout{
		
		  }
        

        .nav>li:hover {
            /* background-color: #b85855; 
            background-color: #9c0702;*/
            background-color: transparent;
            opacity: 0.6 !important;
        }

     

        .latestPaycheckNetPayLabel,
        .latestPaycheckNetPayNumber {
            font-weight: bold;
            width:110px;
        }

       .selectedPaystyle{
       	    border-top: none;
       }
		
        /* On screens that are 900px or less (tablet), set the background color to olive */
        @media screen and (max-width: 900px) {
            .pay_div {
                font-size: 18px;
            }
        }

         /* On screens that are 600px(mobile) or less, set the below properties */
         @media screen and (max-width: 600px) {
            .pay_div {
                font-size: 15px;
                bottom: 315px;
                right: 10%;
                 
 			}
        }
        
        /* modal properties */
     .modal-body {
    	max-height: calc(100vh - 200px);
    	overflow-y: auto;
	}
        
     .print{
    	 background: #ba150f;
    	 border-color: #ba150f !important;
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
            	
                <h2><strong>Paystub Home</strong></h2>
                 
            	<ul class="nav navbar-nav navbar-right">
                    <li style="color:#ba150f;">
						<form:form action="logout" method="post">
  							 <input type="submit" value="Logout">
  						</form:form>
        			</li>
             	</ul>
            </div>
        </div>
    </nav>
    

    <div class="container">
        <div class="jumbotron">
            
            <div class="calenderdiv_style">
			</div>

           <div id="totalPaySummary" class="pay_div">
            	
                 <table class="table table-hover" id="summaryTable">
				  <thead>
				    <tr>
				    	<th>PAY DATE</th>
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
        				<h4 class="modal-title ">Paystub Details</h4>
      				</div>
      			<div class="modal-body">
      			
      			    <div id="modal_wait" style="display:none;width:69px;height:89px;position:absolute;top:50%;left:50%;padding:2px;">
          				<img src="images/popup_loading.gif" width="64" height="64" />
            		</div> 
       				 <p class="PaycheckLabel">Earnings</p>
			 			<table class="table table-hover earningTable" id="earningTable"> 
		                    <thead>
                   				<tr>
							         <th class="PaycheckLabel">Description</th>
							         <th class="PaycheckLabel">Current</th> 
							         <th class="PaycheckLabel">Hours</th>
							         <th class="PaycheckLabel">Year to Date</th>
							        </tr>
							</thead>
							<tbody>
							</tbody>
		                   
                		</table>
                	
                	<p class="PaycheckLabel">Taxes&Deduction</p>
                
                		<table class="table table-hover deductionTable" id="deductionTable"> 
			                <thead>
			                  <tr>
			    				<th class="PaycheckLabel" style="width: 30%;">Description</th>
			    				<th class="PaycheckLabel" style="width: 39%;">Current</th> 
			    				<th class="PaycheckLabel">Year to Date</th>
			 				  </tr>
			                </thead>
		                	<tbody>
							</tbody>

                		</table>
                
                	<p>Net Pay</p>
               			 <table class="table table-hover netPayTable" id="netPayTable">
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
        
        <script>
        $(function () {
       	 $("#datepicker2").datepicker();
       	 
       	 var token = sessionStorage.getItem('token');
       	 var pwd = sessionStorage.getItem('pwd');

       	 console.log(token);
       	 
       	 //paystub summary
       	 
       	 var url1 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/paystubs/dates/" + pwd;
       	 var url2 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/paystubs/grossPays/" + pwd;
       	 var url3 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/paystubs/netPays/" + pwd;
       	 var url4 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/paystubs/hours/" + pwd;
       	 
       	$('#jumbatron_wait').show();
       	 function getUserData(endpoint) {
       	 return $.ajax({
       	 url: endpoint,
       	 type: 'GET',
       	 contentType: 'application/json',
       	 beforeSend: function (xhr) {
       	 xhr.setRequestHeader('Authorization', token);
       	 },
       	 });
       	 }

       	 var a1 = getUserData(url1);
       	 var a2 = getUserData(url2);
       	 var a3 = getUserData(url3);
       	 var a4 = getUserData(url4);


       	 $.when(a1, a2, a3, a4).done(function (r1, r2, r3, r4) {
       	 $('#jumbatron_wait').hide(); 
        // console.log(r1[0], r2[0], r3[0], r4[0]);
       	 $("#summaryTable>tbody").empty();
       	 //each is equivalent to for loop
       	 $.each(r1[0], function (i, v) { //i and v are index and value
       	 var str = "<tr id='" + r1[0][i] + "'><td>" + r1[0][i] + "</td><td>" + "$"+ r2[0][i] + "</td><td>" + "$"+ r3[0][i] + "</td><td>" + r4[0][i] + "</td></tr>";
       	 $("#summaryTable>tbody").append(str)
       	 
       	 })
       	 
       	 //method to show paystub detail popup
       	 
       	  $('#summaryTable tr').click(function() {
       		// console.log(this.id)
       		 var date = this.id;
       		 
       		 var url1 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/earnings/"+ pwd + "/" + date;
       		 var url2 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/deductions/"+ pwd + "/" + date;
       		 var url3 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/netPay/"+ pwd + "/" + date;
       		 
       		$('#modal_wait').show();
       		 function getUserData(endpoint) {
       			 return $.ajax({
       			 url: endpoint,
       			 type: 'GET',
       			 contentType: 'application/json',
       			 beforeSend: function (xhr) {
       			 xhr.setRequestHeader("Authorization", token);
       			 },
       			 })
       			 }

       		 var a1 = getUserData(url1);
       		 var a2 = getUserData(url2);
       		 var a3 = getUserData(url3);


       		 $.when(a1, a2, a3).done(function (r1, r2, r3) {
       			$('#modal_wait').hide();
       			// console.log(r1[0], r2[0], r3);
       		 	 window.earnings = r1[0];
       		 	 window.deductions = r2[0];
       		 	 window.netPay = r3;
       		 $(".earningTable>tbody").empty();
       		 
       		 $.each(r1[0], function(k, v) {
       			 var str = "<tr><td class='latestPaycheckLabel'>" 
       			 + v.description + "</td><td>" 
       			 + "$"+ v.currentAmount +"</td><td>" 
       			 + v.hours + "</td><td>" 
       			 + "$"+ v.ytdAmount+"</td></tr>";
       		
       			 $(".earningTable>tbody").append(str)
       			 });
       		 
       		 $(".deductionTable>tbody").empty();
       		 
       		 $.each(r2[0], function(k, v) {
       			 var str = "<tr><td class='latestPaycheckLabel'>" 
       			 + v.description + "</td><td class='latestPaycheckLabel'>" 
       			 + "$"+ v.currentAmount +"</td><td class='latestPaycheckLabel'>"  
       			 + "$"+ v.ytdAmount+"</td></tr>";
       		
       			 $(".deductionTable>tbody").append(str)
       			 });
       		 	
       		 	$(".netPayTable>tbody").empty(); //emptying body if it has previous values
       		 	var netPay = "<tr><td class='latestPaycheckLabel'>" + "$"+r3[0] + "</td></tr>";
       		 	 $(".netPayTable>tbody").append(netPay)
       		 });
       		 
       		 $("#myModal").modal("show");
       		  
       		  		   
       		}); //end of paystub detail popup
       		
       	 
     }); //end of paystub summary table

     
    			$('.print').on('click', function() {
 				  $.ajax({
 				         url: "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/employee/" +pwd,
 				         type:'GET',
 				         contentType: 'application/json',
 				         beforeSend: function (xhr) {
 				         	   xhr.setRequestHeader ("Authorization", token);
 				         	},
 				     }).then(function(data, status, xhr) {
 				    	 
 				     	// console.log("emp details",data)
 				     	//saved from the paystub detail ajax call
 				     	/*console.log("netPay",netPay)
 				     	 console.log("earnings",earnings)
 				     	 console.log("deductions", deductions)*/
 				     	 
 				     	 
 				     	 var employerAddress = ["EMPLOYER", "Mexico Foods LLC", "2600 McCree Rd Ste 100", "Garland TX 75041-3901" ]
 				     	 var employeeAddress = ["EMPLOYEE", data.address1, data.address2, data.city, data.state, data.zipCode]
 				     	//pdf generation
 				     	 var doc = new jsPDF();
 				     	
 				     	
 				     	 doc.autoTable({html: '#earningTable'});
 				     	 doc.autoTable({html: '#deductionTable'});
 				     	 doc.setFontSize(10);
 				     	 doc.text("Net Pay", 15, 80);
 				     	 doc.autoTable({html: '#netPayTable'});
 				     	 //doc.save('Paystub'+data.employeeId+'.pdf');
 				     	  doc.setFont("times");
 				     	 doc.setFontStyle("normal");
 				     	 doc.setFontSize(10);
 				     	 doc.text(employerAddress, 10, 130);
 				     	 doc.text(employeeAddress, 10, 160);
 				     	 
 				     	doc.output('dataurlnewwindow');
		     		 	
		     	 })
 				  			
 			});
 });

 </script>

</body>

</html>
