package com.elrancho.paystubwebapp.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elrancho.paystubwebapp.entity.Paystub;
import com.elrancho.paystubwebapp.entity.Users;
import com.elrancho.paystubwebapp.service.EmployeeServiceImpl;
import com.elrancho.paystubwebapp.service.PaystubServiceImpl;
import com.elrancho.paystubwebapp.service.UserServiceImpl;
import com.elrancho.paystubwebapp.util.PaystubUtil;

@Controller
public class PasswordResetController {
	
	
	private int employeeId;
	
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
	
	
	@PostMapping("/securityQnValidate")
	public String securityQnValidator(@RequestParam("dob") @DateTimeFormat(pattern="MM/dd/yyyy") LocalDate dob, @RequestParam("ssn") String ssn, Model model) {
		
		//validating security questions- dob and ssn 4 digits
		  boolean securityQuestionValid = esimpl.securityQuestionCheck(dob, ssn);
		  System.out.println("securityQuestionValid "+securityQuestionValid);
		
		  if(securityQuestionValid==false) {
			  String errMsgSecQuestion = "Please choose your correct date of birth and ssn";
			  model.addAttribute("errMsgSecQuestion", errMsgSecQuestion);
			  return "forgotpwdSecurityQuestions";
		  }
		  
		  else {
				  employeeId = esimpl.getEmpIdWithDobSsn(dob, ssn);
				  System.out.println("employeeId "+employeeId);
		
				  return "forgotpwdPasswordValidation";
		  }
	}
	
	@PostMapping("/pwdReset")
	public String resetPassword(@RequestParam("pwd") String pwd, Model model) {
		
		if(usimpl.registeredEmployeeValidator(employeeId)==false) {
			return "notRegisteredUser";
		}
  		
		boolean isPwdPresent = usimpl.passwordValidator(pwd);

      //checking if the same password is already in the database
  		if(isPwdPresent==true) {
			  String errMsgPwd = "Please choose another password";
			  model.addAttribute("errMsgPwd", errMsgPwd);
			  return "forgotpwdPasswordValidation";
		  }
  		
  		else {
  			
		  //password encryption
		    String encodedPassword = bCryptPasswordEncoder.encode(pwd);
		  
		  //setting new user fields
		    Users user= new Users(employeeId, encodedPassword,pwd,true);
	      //updating existing user in users table
		    usimpl.registerUser(user);
	
			 return "passwordResetSuccess";  
		  }

	}
}
