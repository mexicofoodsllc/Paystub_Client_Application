package com.elrancho.paystubwebapp.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;


@Entity
@Table(name="Users")
public class Users {

	@NotNull
	@Id
	int employeeId;
	String password;
	String userName;
	boolean isRegistered;
	
	public Users() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Users(int employeeId, String password, String userName, boolean isRegistered) {
		this.employeeId = employeeId;
		this.password = password;
		this.userName = userName;
		this.isRegistered = isRegistered;
	}
	
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public boolean isRegistered() {
		return isRegistered;
	}
	public void setRegistered(boolean isRegistered) {
		this.isRegistered = isRegistered;
	}
	@Override
	public String toString() {
		return "Users [employeeId=" + employeeId + ", password=" + password + ", userName=" + userName + "]";
	}
}
