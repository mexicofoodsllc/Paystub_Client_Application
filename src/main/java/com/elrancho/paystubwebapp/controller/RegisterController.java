package com.elrancho.paystubwebapp.controller;


import java.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elrancho.paystubwebapp.entity.Users;
import com.elrancho.paystubwebapp.service.EmployeeServiceImpl;
import com.elrancho.paystubwebapp.service.PaystubServiceImpl;
import com.elrancho.paystubwebapp.service.UserServiceImpl;
import com.elrancho.paystubwebapp.util.PaystubUtil;

@Controller
public class RegisterController {
	
	private int employeeId;
	private String password;
	
	@Autowired
	EmployeeServiceImpl esimpl;
	@Autowired
	UserServiceImpl usimpl;
	@Autowired
	PaystubServiceImpl psimpl;
	@Autowired
	PaystubUtil psutil;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	

	  @PostMapping("/regmanagement")
	   public String regHome(@RequestParam("empid") int empId, Model model) {
		  
		  employeeId=empId;

		 boolean isActiveEmployee= esimpl.activeEmployeeCheck(employeeId);
		 boolean isActiveUser = usimpl.activeUserCheck(employeeId);	 

		 if(isActiveUser==true) {
			 return "activeUser";
		 }
		 
		 else if(isActiveEmployee==true){
			 return "passwordValidation";
		 }
		 else 
			 return "terminatedUser";
	   }
	   
	  
	  @PostMapping("/pwdValid")
	  public String passwordCheck(@RequestParam("pwd1") String pwd, Model model) {
	    password = pwd;
		//checking if the same password is already in the database
	  		boolean isPwdPresent = usimpl.passwordValidator(password);
			  
	  		if(isPwdPresent==true) {
				  String errMsgPwd = "Please choose another password";
				  model.addAttribute("errMsgPwd", errMsgPwd);
				  return "passwordValidation";
			  }
	  		else
	  			return "security_question"; 
		  
	  }
	  @PostMapping("/empRegSucess")
	  public String paystubHome(@RequestParam("dob") @DateTimeFormat(pattern="MM/dd/yyyy") LocalDate dob, @RequestParam("ssn") String ssn, Model model) {
		  

		  //validating security questions- dob and ssn 4 digits
			boolean securityQuestionValid = esimpl.securityQuestionCheck(dob, ssn);
			System.out.println("securityQuestionValid "+securityQuestionValid);
			  

		  if(securityQuestionValid==false) {
			  String errMsgSecQuestion = "Please choose your correct date of birth and ssn";
			  model.addAttribute("errMsgSecQuestion", errMsgSecQuestion);
			  return "security_question";
		  }
		  
		  else {
			  //password encryption
			  String encodedPassword = bCryptPasswordEncoder.encode(password);
			  

		  //setting new user fields
			  Users user= new Users(employeeId, encodedPassword,Integer.toString(employeeId),true);
		  //registering new user in users table
			  usimpl.registerUser(user);
		   
			 return "accountCreated";  
		  }

	}
}
