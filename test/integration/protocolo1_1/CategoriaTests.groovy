package protocolo1_1

import grails.test.*

class CategoriaTests extends GroovyTestCase {

	void testConstraints(){
		def cat = new Categoria(nome: "XPTO")
		assertTrue cat.validate()
		cat = new Categoria()
		assertFalse cat.validate()
		
		}
	
}
