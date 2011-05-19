package protocolo1_1

class Categoria {
	
	String nome

    static constraints = {
		nome(blank: false)
    }
	
	String toString(){
		return nome
		}
}
