package controller;

import java.util.ArrayList;
import java.util.List;

import model.Student;

public abstract class StudentController {
	List<Student> studentList = new ArrayList<Student>();
	
	public void addStudent (Student student) {
		studentList.add(student);
		System.out.println("Estudante adicionado com sucesso");
	}
	
	public Student findStudent(int cpf) {
		// testar, acho que tá errado
		Student student = null;
		for (Student students: studentList) {
			if(students.getCpf() == cpf) {
				student = students;
			} else {
				System.out.println("Estudante nao existe!");
				return null;
			}
		}
		return student;
	}
	
	public void editStudent (int cpf, String attribute, String value) {
		Student student = this.findStudent(cpf);
		
		try {
			student.setField(attribute, value);
		} catch (NoSuchFieldException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void removeStudent (int cpf) {
		Student student = this.findStudent(cpf);
		studentList.remove(student);
		System.out.println("Estudante excluido");
	}
	
	public void listStudent () {
		for (Student student : studentList) {
			System.out.println("CPF:" + student.getCpf());
			System.out.println("Nome:" + student.getName());
			System.out.println("Data Nascimento:" + student.getBirthDate());
			System.out.println("Gênero:" + student.getGender());
		}
	}
}
