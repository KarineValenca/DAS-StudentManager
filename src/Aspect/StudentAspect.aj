
package Aspect;

import model.Student;

public aspect StudentAspecto extends Object
{
	/*
	 *  Pointcuts
	 */
	
    pointcut construtor(int cpf, String name, Date birthDate, String gender) : execution(Model.Student.new(int, String, Date, String)) && args(cpf, name, birthDate, gender);
    pointcut funcaoadd(double amount) : call(* *.deposit(double)) && args(amount);
    pointcut funcaoeditar(double amount) : call(* *.withDraw(double)) && args(amount);
    pointcut funcaoremover(double amount) : call(* *.withDraw(double)) && args(amount);
    pointcut funcaolistar(double amount) : call(* *.withDraw(double)) && args(amount);
    pointcut funcaobuscar(double amount) : call(* *.withDraw(double)) && args(amount);

    /*
     *  Advices
     */
    
    before(int cpf, String name, Date birthDate, String gender) : construtor(cpf, name, birthDate, gender)
    {
        Boolean sentinela = false;       

        //continuar aqui...... 

    	if(cpf.contains("^[a-Z]") || (cpf.length != 9)) {
        	this.manipulaErro("O cpf deve conter apenas números, e nove caracteres",false);
            sentinela = true;
    	}

       .
       .
       .

    }


    before(double amount) : funcaodeposit(amount)
    {
        if(amount < 0.0)
        {
            this.manipulaErro("Na chamada do método \"deposit\" da classe \"" + thisJoinPoint.getTarget().getClass().getName() + "\" o parâmetro \"amount\" está negativo (" + amount + ")",true);
        }
    }


    before(double amount) : funcaowithDraw(amount)
    {
        BankAccount conta = (BankAccount)thisJoinPoint.getTarget();
        double saldo;
        if(amount < 0.0)
        {
            this.manipulaErro("Na chamada do método \"withDraw\" da classe \"" + thisJoinPoint.getTarget().getClass().getName() + "\" o parâmetro \"amount\" está negativo (" + amount + ")",true);
        }
        if(conta instanceof RegularAccount)
        {
            saldo = ((RegularAccount)conta).getBalance();
            if(!this.verificaSaque(saldo,amount))
            {
                this.manipulaErro("Na chamada do método \"withDraw\" da classe \"RegularAccount\" o parâmetro \"amount\" que tem  (" + amount + ") está maior que o saldo permitido que é de (" + saldo + ")",true);
            }
        }
        else if(conta instanceof SavingsAccount)
        {
            saldo = ((SavingsAccount)conta).getBalance();
            if(!this.verificaSaque(saldo,amount))
            {
                this.manipulaErro("Na chamada do método \"withDraw\" da classe \"SavingsAccount\" o parâmetro \"amount\" que tem (" + amount + ") está maior que o saldo permitido que é de (" + saldo + ")",true);
            }
        }
        else if(conta instanceof LawAccount ||
                conta instanceof CityLawAccount ||
                conta instanceof StateLawAccount ||
                conta instanceof FederationLawAccount)
        {
            saldo = ((LawAccount)conta).getBalance();
            if(!this.verificaSaque(saldo,amount))
            {
                this.manipulaErro("Na chamada do método \"withDraw\" da classe \"" + thisJoinPoint.getTarget().getClass().getName() + "\" o parâmetro \"amount\" que tem (" + amount + ") está maior que o saldo permitido que é de (" + saldo + ")",true);
            }
        }
    }

    /*
     *  Métodos
     */

    // Termina a execução do programa
    private void terminaPrograma()
    {
    	System.err.println("Programa Finalizando sua Execução");
        System.exit(-1);
    }

    // Lida com erros terminando ou não a execução do programa
    private void manipulaErro(String message, Boolean sentinela)
    {
        System.err.println(message);
        if(sentinela)
        {
            this.terminaPrograma();
        }
    }

    /*
     * Verifica se a operação de saque pode ser feita
     */
    private Boolean verificaSaque(double saldo, double quantia)
    {
        return saldo - quantia >= 0.0;
    }
}