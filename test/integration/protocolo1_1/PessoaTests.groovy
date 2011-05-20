package protocolo1_1

import grails.test.*

class PessoaTests extends GroovyTestCase {
   
	void testConstraints(){
		
		def pessoa =  new Pessoa(nome:"Daniel",email: "email@email.com")
		assertTrue pessoa.validate()
		pessoa =  new Pessoa(nome:"Aa",email: "email@email.com")
		assertFalse pessoa.validate()
		pessoa = new Pessoa(nome:"Ana", email: "email")
		assertFalse pessoa.validate()
		pessoa = new Pessoa(nome: "   ", email:"email@email.com")
		assertFalse pessoa.validate()
		pessoa = new Pessoa(nome: "Daniel", email:"   @   .com")
		assertFalse pessoa.validate()
		}
	
}
