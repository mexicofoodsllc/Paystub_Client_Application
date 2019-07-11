package com.elrancho.paystubwebapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class HomeController {


	 
	//returns index.jsp
   @GetMapping("/")
   public String login(Model model) {
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
   
}

