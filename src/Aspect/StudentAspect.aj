package Aspect;

import model.Student;

public aspect StudentAspecto extends Object {
	
    pointcut construtor(int cpf, String name, String gender) : execution(Model.Student.new(int, String, String)) && args(cpf, name, gender);
    pointcut addStudent(Student student) : call(* *.addStudent(Student)) && args(student);
    pointcut findStudent(int cpf) : call(* *.findStudent(int)) && args(cpf);
    pointcut editStudent(int cpf, String attribute, String value) : call(* *.editStudent(int, String, String)) && args(cpf, attribute, value);
    pointcut removeStudent(int cpf) : call(* *.removeStudent(int)) && args(cpf);
    
    before(int cpf, String name, String gender) : construtor(cpf, name, gender)
    {
        Boolean sentinel = false;

    	if(cpf.contains("^[a-Z]") || (cpf.length != 11)) {
        	this.handleError("O cpf deve conter apenas números, e onze caracteres",false);
            sentinel = true;
    	}
    	if(name.contains("[0-9]*")) {
    		this.handleError("O nome deve conter apenas letras", false);
            sentinel = true;
    	}
    	if(gender.contains("[0-9]*")) { 
    		this.handleError("O gênero deve conter apenas letras", false);
    		sentinel = true;
    	}

        if(sentinel) {
            this.terminatedProgram();
        }
    }

    before(Student student) : addStudent(student){
        if(student == null)
        {
            this.handleError("O estudante é nulo. Não é possível adicioná-lo", true);
        }
    }

    before(int cpf) : findStudent(cpf){
        if(cpf.contains("^[a-Z]") || (cpf.length != 11)) {
        	this.handleError("O cpf deve conter apenas números, e onze caracteres",true);
    	}
    }
    
    before(int cpf, String attribute, String value) : editStudent(cpf, attribute, value){
        if(cpf.contains("^[a-Z]") || (cpf.length != 11)) {
        	this.handleError("O cpf deve conter apenas números, e onze caracteres",true);
    	}
    	if(attribute != "cpf" || attribute != "name" || attribute != "gender"){
    		this.handleError("Atributo inválido!",true);
    	}
    	if(value == ""){
    		this.handleError("Valor inválido", true);
    	}
    }

	before(int cpf) : removeStudent(cpf){
        if(cpf.contains("^[a-Z]") || (cpf.length != 11)) {
        	this.handleError("O cpf deve conter apenas números, e onze caracteres",true);
    	}
    }
  
    private void terminatedProgram() {
    	System.err.println("Finalizando Programa");
        System.exit(-1);
    }

    private void handleError(String message, Boolean sentinel) {
        System.err.println(message);
        if(sentinel) {
            this.terminatedProgram();
        }
    }

}