package protocolo1_1

class Solicitacao {
	
	Pessoa requerente
	Tipo tipo
	Date data
	String descricao
	static hasMany = [situacoes: Situacao]
		
    static constraints = {
    }
	
	String toString(){
		return tipo
	}
}
