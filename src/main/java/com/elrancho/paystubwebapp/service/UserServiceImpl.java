package com.elrancho.paystubwebapp.service;


import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.elrancho.paystubwebapp.entity.Users;
import com.elrancho.paystubwebapp.repository.UsersRepository;


@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UsersRepository usersRepository;
	@Autowired
	EmployeeServiceImpl esimpl;	


	@Override
	public void registerUser(Users user) {
		
		usersRepository.save(user);	
	}

	@Override
	public boolean activeUserCheck(int empid) {
		boolean isActive=false;
		Iterable<Users> userList = usersRepository.findByEmployeeId(empid);
		System.out.println(userList);
		for(Users u:userList) {
			if(u.getEmployeeId()==empid) {
				isActive=true;
			}
			else
				isActive=false;
		}
		System.out.println(isActive);
		return isActive;
	}

	@Override
	public boolean passwordValidator(String password) {
		boolean isValid = false;
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		Iterable<Users> userList = usersRepository.findAll();
		for(Users u:userList) {
			if(encoder.matches(password, u.getPassword())) {
				isValid=true;
				//System.out.println("u.getPassword()  "+u.getEmployeeId());
				
			}
		}
		
		
		return isValid;
	}

	@Override
	public int getEmpId(String password) {
		Iterable<Users> userList = usersRepository.findAll();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		int eId = 0;
		for(Users u:userList) {
			if(encoder.matches(password, u.getPassword())) {
				eId=u.getEmployeeId();
			}
		}
		return eId;
	}

	@Override
	public boolean registeredEmployeeValidator(int employeeId) {
		boolean isEmployeeRegistered = true;
		 Optional<Boolean> isRegistered = usersRepository.findRegisterdEmployeeByEmployeeId(employeeId);
		 if(isRegistered.isPresent()) {
			 isEmployeeRegistered = true;
		 }
		 else
			 isEmployeeRegistered = false;
		return isEmployeeRegistered;
	}


	
	
	

	
}
