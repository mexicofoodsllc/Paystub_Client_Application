       $(function () {
          	 $("#datepicker2").datepicker();
          	 
          	 var token = sessionStorage.getItem('token');
          	 var pwd = sessionStorage.getItem('pwd');
          	 //console.log(token);
          	 
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
          		 var url3 = "http://ec2-3-214-24-168.compute-1.amazonaws.com:8080/paystubWS/grossNetPay/"+ pwd + "/" + date;
          		 
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
          			 console.log(r3);
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
         			 + "$"+r3[0].netPay + "</td></tr>";
          		 	 $(".totalPayTable>tbody").append(totalPay)
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
    				    	 
    				     	 console.log("emp details",data)
    				     	//saved from the paystub detail ajax call
    				     	/*console.log("netPay",netPay)
    				     	 console.log("earnings",earnings)
    				     	 console.log("deductions", deductions)*/
    				     	 
    				     	 
    				     	 var employerAddress = ["EMPLOYER", "Mexico Foods LLC", "2600 McCree Rd Ste 100", "Garland TX 75041-3901" ]
    				     	 var employeeAddress = ["EMPLOYEE", data.firstName+" "+data.lastName, data.address1, data.city+" "+ data.state+" "+ data.zipCode]
    				     	//pdf generation
    				     	 var doc = new jsPDF();
    				     	 
    				     	
    				     	
    				     	 doc.autoTable({html: '#paystubDatesTable'});
    				     	 doc.autoTable({html: '#earningTable'});
    				     	 doc.autoTable({html: '#deductionTable'});
    				     	 doc.autoTable({html: '#totalPayTable'});
    				     	 //doc.save('Paystub'+data.employeeId+'.pdf');
    				     	 doc.setFont("times");
    				     	 doc.setFontStyle("normal");
    				     	 doc.setFontSize(12);
    				     	 doc.text(employerAddress, 13, 160);
    				     	 doc.text(employeeAddress, 130, 160);
    				     	 //doc.text(" © El Rancho Supermercado",160,400);
    				     	  
    				     	doc.output('dataurlnewwindow');
   		     		 	
   		     	 })
    				  			
    			});
    });
