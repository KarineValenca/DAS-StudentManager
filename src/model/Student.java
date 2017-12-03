package model;

import java.lang.reflect.Field;
import java.util.Date;

public abstract class Student {
	int cpf;
	String name;
	Date birthDate;
	String gender;
	
	public Student() {
		super();
	}
	
	public int getCpf() {
		return cpf;
	}
	public void setCpf(int cpf) {
		this.cpf = cpf;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	 
	public void setField(String fieldName, String value) throws NoSuchFieldException, IllegalAccessException {
	        Field field = getClass().getDeclaredField(fieldName);
	        field.set(this, value);
	}
}
