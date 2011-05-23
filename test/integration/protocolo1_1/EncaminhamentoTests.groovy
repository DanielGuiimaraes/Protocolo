package protocolo1_1

import grails.test.*


class EncaminhamentoTests extends GrailsUnitTestCase {

	void testConstraints() {
		def pessoa = new Pessoa(nome: "faluno", email: "georgenesal@gmail.com")
		def encaminhamento = new Encaminhamento(remetente: pessoa, destinatario: pessoa, justificativa: "xpto", data: new Date()) 
		assertTrue encaminhamento.validate() //minha categoria com o atributo setado não é para ter erro
		encaminhamento = new Encaminhamento()
		assertFalse encaminhamento.validate() //este é para dar erro
	}

}
