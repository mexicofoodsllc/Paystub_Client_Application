       $(function () {
    	   
        	 var token = sessionStorage.getItem('authToken');
          	 var pwd = sessionStorage.getItem('pwd');
          	var userName = sessionStorage.getItem('userName');
          	 
    	   
    	   
    	 
          	 
    	 //call to get employee details
        	 $.ajax({
		         url: "https://www.mxf-employeepaystub.com/paystubWS/employee/" +userName,
		         type:'GET',
		         contentType: 'application/json',
		         beforeSend: function (xhr) {
		         	   xhr.setRequestHeader ("Authorization", token);
		         	},
		     }).then(function(data, status, xhr) {
		    	 
		    	 window.empId = data.employeeId;
		     	 //console.log("emp details",data)
		    	 $('#empId').html("<b>Employee ID: "+data.employeeId+"</b>")
		     	 $('#empName').html("<b>Employee Name: "+data.firstName+" "+data.lastName+"</b>")
		     	 //window.employeeAddress = ["EMPLOYEE", data.firstName+" "+data.lastName, data.address1, data.city+" "+ data.state+" "+ data.zipCode]
		     	 $("#employerTable>tbody").empty();
		    	 var str1 = "<tr><td>" +"Mexico Foods LLC"+"</td><td>"
        			 + data.firstName+" "+data.lastName +"</td></tr><tr><td>"+"2600 McCree Rd Ste 100"+"</td><td>"
        			 + data.address1 + "</td></tr><tr><td>"+"Garland TX 75041-3901"+"</td><td>"
        			 + data.city+" "+ data.state+" "+ data.zipCode +"</td></tr>";

        			 $("#employerTable>tbody").append(str1) 
		    	 
		     	 
		     })
        	 //paystub summary
        	 
		     var url1 = "https://www.mxf-employeepaystub.com/paystubWS/paystubs/checkNum/" + userName;
        	 var url2 = "https://www.mxf-employeepaystub.com/paystubWS/paystubs/dates/" + userName;
        	 var url3 = "https://www.mxf-employeepaystub.com/paystubWS/paystubs/grossPays/" + userName;
        	 var url4 = "https://www.mxf-employeepaystub.com/paystubWS/paystubs/netPays/" + userName;
        	 var url5 = "https://www.mxf-employeepaystub.com/paystubWS/paystubs/hours/" + userName;
        	 
		     

        	 
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
        	 var a5 = getUserData(url5);
        	 
        	 $.when(a1, a2, a3, a4, a5).done(function (r1, r2, r3, r4, r5) {
        	 $('#jumbatron_wait').hide(); 

        	 $("#summaryTable>tbody").empty();
        	 //each is equivalent to for loop
        	 $.each(r1[0], function (i, v) { //i and v are index and value
        	 var str = "<tr id='" + r1[0][i] + "'><td>" + r2[0][i] + "</td><td>" + "$"+ r3[0][i] + "</td><td>" + "$"+ r4[0][i] + "</td><td>" + r5[0][i] + "</td></tr>";
        	
        		 $("#summaryTable>tbody").append(str)
        	 
        	 
        	 })
        	 
        	 //method to show paystub detail popup
        	 
        	  $('#summaryTable tr').click(function() {
        		// console.log(this.id)
        		 var checkNum = this.id;
        		 
        		 var url1 = "https://www.mxf-employeepaystub.com/paystubWS/earnings/"+ userName + "/" + checkNum;
        		 var url2 = "https://www.mxf-employeepaystub.com/paystubWS/deductions/"+ userName + "/" + checkNum;
        		 var url3 = "https://www.mxf-employeepaystub.com/paystubWS/grossNetDed/"+ userName + "/" + checkNum;
        		 
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
        			 console.log(r1);
        		 	 window.earnings = r1[0];
        		 	 //window.deductions = r2[0];
        		 	 //window.netPay = r3;
        		 	
        			 //empying tables to avoid appending to old values
        		 $(".earningTable>tbody").empty();

        		 $.each(r1[0], function(k, v) {
        			 var str1 = "<tr><td class='latestPaycheckLabel'>" 
        			 + v.description + "</td><td>" 
        			 + "$"+ v.currentAmount +"</td><td>" 
        			 + v.hours + "</td><td>" 
        			 + "$"+ v.ytdAmount+"</td></tr>";

        			 $(".earningTable>tbody").append(str1) //populating the earnings in paystubdetail popup
        			 
        		 });
        		 
        		 $(".paystubDatesTable>tbody").empty();
        		 
        		 
    			 var str2 = "<tr><td class='latestPaycheckLabel'>" 
        			 + r1[0][0].checkDate + "</td><td>" 
        			 + r1[0][0].payPeriodEndDate +"</td><td>" 
        			 + r1[0][0].id.checkControl +"</td></tr>";
    			 $(".paystubDatesTable>tbody").append(str2) //populating the dates and check num in paystubdetail popup
        		 
        		 $(".deductionTable>tbody").empty();
        		 
        		 $.each(r2[0], function(k, v) {
        			 var str = "<tr><td class='latestPaycheckLabel'>" 
        			 + v.description + "</td><td class='latestPaycheckLabel'>" 
        			 + "$"+ v.currentAmount +"</td><td class='latestPaycheckLabel'>"  
        			 + "$"+ v.ytdAmount+"</td></tr>";
        		
        			 $(".deductionTable>tbody").append(str)
        			 });
        		 	
        		 	$(".totalPayTable>tbody").empty(); //emptying body if it has previous values
        		 	var totalPay = "<tr><td class='latestPaycheckLabel'>" + "$"+r3[0].grossPay + "</td><td class='latestPaycheckLabel'>" 
       			 + "$"+r3[0].deduction + "</td><td class='latestPaycheckLabel'>" 
       			 + "$"+r3[0].netPay + "</td></tr>";
        		 	 $(".totalPayTable>tbody").append(totalPay)
        		 });
        		 
        		 $("#myModal").modal("show");
        		  
        		  		   
        		}); //end of paystub detail popup
        		
        	 
      }); //end of paystub summary table
      
     			$('.print').on('click', function() {
     				
     			// Internet Explorer 6-11
     				var isIE = /*@cc_on!@*/false || !!document.documentMode;
     			// Edge 20+
     				var isEdge = !isIE && !!window.StyleMedia;
     				
     				if(isIE){
     					//console.log("IE");
     					$('#employerDetails').attr("style",
                        "display: block !important;");
     					$('.jumbotron').hide();
     					$('#empId').hide();
     					$('#empName').hide();
     					window.print();
     					
     					$('#employerDetails').hide();
     					$('.jumbotron').show();
     					$('#empId').show();
     					$('#empName').show();
     				}
     				
     				else if(isEdge){
     					//pdf generation
 				     	 var doc = new jsPDF();

 				     	 
 				     	 doc.autoTable({html: '#employerTable'})
 				     	 //doc.autoTable({html: '#employeeTable'})
 				     	 doc.autoTable({html: '#paystubDatesTable'});
 				     	 doc.autoTable({html: '#earningTable'});
 				     	 doc.autoTable({html: '#deductionTable'});
 				     	 doc.autoTable({html: '#totalPayTable'});
 				     	 doc.save('Paystub'+window.empId+'.pdf');
 				     	//doc.save('Paystub.pdf');
     				}
     				else{
     				
     				//pdf generation
  				     	 var doc = new jsPDF();

  				     	 
  				     	 doc.autoTable({html: '#employerTable'})
  				     	 //doc.autoTable({html: '#employeeTable'})
  				     	 doc.autoTable({html: '#paystubDatesTable'});
  				     	 doc.autoTable({html: '#earningTable'});
  				     	 doc.autoTable({html: '#deductionTable'});
  				     	 doc.autoTable({html: '#totalPayTable'});
  				     	 //doc.save('Paystub'+data.employeeId+'.pdf');
  				     	//doc.save('Paystub.pdf');
  				     	doc.output('dataurlnewwindow');
     				}
  			});
          
    	  $('#logout').click(function() {
    		  
    		  sessionStorage.clear();
    		  
    	  });
    	   
    });
