package protocolo1_1

class Encaminhamento {
	
	Pessoa remetente
	Pessoa destinatario
	String justificativa
	Date data


    static constraints = {
    }
	
	String toString(){
		return "De: ${remetente}  Para: ${destinatario}" 
	}
}
