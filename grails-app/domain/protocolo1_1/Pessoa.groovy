package protocolo1_1

class Pessoa {

	String nome
	String email
	
    static constraints = {
		nome(blank:false, minLength:3)
		email(blank: false,email: true)
    }
	
	String toString(){
		return nome
		}
}
