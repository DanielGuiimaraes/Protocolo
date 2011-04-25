package protocolo1_1

class Situacao {
	
	Estado estado
	Date data
	String observacao
	Pessoa responsavel
	Solicitacao solicitacao
	Encaminhamento encaminhamento

    static constraints = {
		encaminhamento(nullable: true)
    }
	
	String toString() {
		return "${estado} [${responsavel} - ${data}]"
	}
}
