package com.elrancho.paystubwebapp.service;



import com.elrancho.paystubwebapp.entity.Users;

public interface UserService {

	public void registerUser(Users user);
	public boolean activeUserCheck(int empid);
	public boolean passwordValidator(String password);
	public int getEmpId(String password);
	public boolean registeredEmployeeValidator(int employeeId);
}
