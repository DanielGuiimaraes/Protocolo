package protocolo1_1

class Solicitacao {
	
	Pessoa requerente
	Tipo tipo
	Date data
	String descricao
	static hasMany = [situacoes: Situacao]
	
	static mapping = {
		situacoes(sort: 'data', order: 'desc')
		requerente lazy: false
		tipo lazy: false
	}
	
    static constraints = {
    }
	
	String toString(){
		return tipo
	}
}
