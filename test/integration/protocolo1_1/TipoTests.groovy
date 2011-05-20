package protocolo1_1

import grails.test.*

class TipoTests extends GroovyTestCase {
   
	void testConstraints(){
		def pessoa = new Pessoa(nome:"Daniel", email: "email@email.com")
		def cat = new Categoria(nome:"AA")
		def tipo = new Tipo(nome:"trancamento", categoria: cat, responsavel: pessoa)
		assertTrue tipo.validate()
		
		tipo =  new Tipo(nome:"tr", categoria: cat, responsavel: pessoa)
		assertFalse tipo.validate()
		tipo = new Tipo(nome:"Daniel", responsavel: pessoa)
		assertFalse tipo.validate()
		tipo = new Tipo(nome:"Daniel", categoria: cat)
		assertFalse tipo.validate()
		tipo = new Tipo(nome:"Daniel", categoria: cat, responsavel: "responsavel")
		assertFalse tipo.validate()
		tipo = new Tipo(nome:"Daniel", categoria: "categoria", responsavel: pessoa)
		assertFalse tipo.validate()
		}
	
}
