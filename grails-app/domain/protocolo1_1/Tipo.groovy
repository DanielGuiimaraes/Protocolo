package protocolo1_1

class Tipo {
	
	String nome
	Categoria categoria
	Pessoa responsavel

    static constraints = {
		nome(blank:false, minLength:3)
		categoria(blank:false)
		responsavel(blank:false)
    }
	
	String toString(){
		return nome
		}
}
