//Controladora abstrata, que permite a implementação do padrão definido para estudantes.  
package controller;

import java.util.ArrayList;
import java.util.List;
import model.Student;

public abstract class StudentController {
	List<Student> studentList = new ArrayList<Student>();
	
	//Adiciona o estudante instanciado na lista de estudantes. 
	public void addStudent (Student student) {
		studentList.add(student);
		System.out.println("Estudante adicionado com sucesso");
	}
	
	// Encontra estudantes com base no seu cpf.
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
	
	// Edita estudantes.
	public void editStudent (int cpf, String attribute, String value) {
		Student student = this.findStudent(cpf);
		
		try {
			student.setField(attribute, value);
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
	// Remove um estudante. 
	public void removeStudent (int cpf) {
		Student student = this.findStudent(cpf);
		studentList.remove(student);
		System.out.println("Estudante excluido");
	}
	
	// Lista todos os estudantes dispostos na lista. 
	public void listStudent () {
		for (Student student : studentList) {
			System.out.println("CPF:" + student.getCpf());
			System.out.println("Nome:" + student.getName());
			System.out.println("Data Nascimento:" + student.getBirthDate());
			System.out.println("Gênero:" + student.getGender());
		}
	}
}
