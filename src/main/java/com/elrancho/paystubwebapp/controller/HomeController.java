package com.elrancho.paystubwebapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class HomeController {


	 
	//returns index.jsp
   @GetMapping("/login")
   public String login(Model model) {
	  // model.addAttribute("isLoginTrue", false); 
      return "index";
   }
   
   @PostMapping("/register")
   public String registerEmployee() {
	   return "register";
   }
   
   @PostMapping("/forgotpwd")
   public String resetPassword() {
	   return "forgotpwdSecurityQuestions";
   }
   

   @PostMapping("/home") 
   public String getHome() {
	  
	  	  return "paystubSummary";
   }
 
   
   @PostMapping("/paystubSummary")
   public String paystubSummary(Model model) {
	  // model.addAttribute("ispaySelected", false);
	   return "paystubSummary";
   }
   
 
/* @RequestMapping(value="/fetch_paystub")
 
   public String fetchResult() { 
	
	   return "paystubSummary";
	
   }
 

   @PostMapping("/paystubDetail")
   public String paystubDetail() { 
	   
	   return "paystubDetail";
   }
    
   @PostMapping("/logout")
   public String logout() {
      return "index";
   }*/
}

