package protocolo1_1

class SolicitacaoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def mailService
	def springSecurityService
	
    def index = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def usuarioLogado = SecUser.get(springSecurityService.principal.id)
		def total = Solicitacao.findAllByRequerente(usuarioLogado.pessoa).size()
		def solicitacoes = Solicitacao.findAllByRequerente(usuarioLogado.pessoa, params)
		
        [solicitacoes: solicitacoes, solicitacaoInstanceTotal: total]
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [solicitacaoInstanceList: Solicitacao.list(params), solicitacaoInstanceTotal: Solicitacao.count()]
    }

    def create = {
        def solicitacaoInstance = new Solicitacao()
        solicitacaoInstance.properties = params
        return [solicitacaoInstance: solicitacaoInstance]
    }

    def save = {
		def usuarioLogado = SecUser.get(springSecurityService.principal.id)
        def solicitacaoInstance = new Solicitacao(params)
		solicitacaoInstance.requerente = usuarioLogado.pessoa
       
		 if (solicitacaoInstance.save(flush: true)) {
			 
			def criado = Estado.findByNome('Criado')
			def encaminhado = Estado.findByNome('Encaminhado')
			def situacao = new Situacao(estado: criado, data: new Date(),  observacao: '', 
				responsavel: solicitacaoInstance.requerente, solicitacao: solicitacaoInstance, encaminhamento: null).save(flush: true, failOnError: true)
			def e = new Encaminhamento(remetente: solicitacaoInstance.requerente, destinatario: solicitacaoInstance.tipo.responsavel,
				 justificativa: '', data: new Date()).save(flush: true, failOnError: true)
			situacao = new Situacao(estado: encaminhado, data: new Date(), observacao:'', responsavel:solicitacaoInstance.requerente,
				 solicitacao: solicitacaoInstance, encaminhamento: e).save(flush: true, failOnError: true)	
				
				 mailService.sendMail {
					 to solicitacaoInstance.tipo.responsavel.email
					 subject solicitacaoInstance.tipo.nome
					 html  "Nova solicita��o para voc�, clique no link a seguir para visualizar <a href='http://localhost:8080/Protocolo1_1/solicitacao/aceitar/${solicitacaoInstance.id}'>Clique aqui</a>"
				 }
				 
			    mailService.sendMail {
					 to solicitacaoInstance.requerente.email
					 subject "Solicitacao"
					 html "Sua solicitacao foi criada e encaminhada para o responsavel, aguarde o resultado.clique no link a segui para acompanhar o andamento: <a href='http://localhost:8080/Protocolo1_1/solicitacao/show/${solicitacaoInstance.id}'>Clique aqui</a>"
				 }
			

			
		
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), solicitacaoInstance.id])}"
            redirect(action: "show", id: solicitacaoInstance.id)
        }
        else {
            render(view: "create", model: [solicitacaoInstance: solicitacaoInstance])
        }
    }
	
	def aceitar = {
		def encaminhamento = Encaminhamento.get(params.id)
		def emProcesso = Estado.findByNome("Em Processo")
		def situacao = Situacao.findByEncaminhamento(encaminhamento)
		def novaSituacao = new Situacao(estado: emProcesso, data: new Date(), observacao: "", responsavel: encaminhamento.destinatario,
		solicitacao: situacao.solicitacao).save(flush: true, failOnError: true)
		redirect(action: "show", id: situacao.solicitacao.id)
		}


    def show = {
        def solicitacaoInstance = Solicitacao.get(params.id)
        if (!solicitacaoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), params.id])}"
            redirect(action: "list")
        }
        else {
			def situacoes = Situacao.findAllBySolicitacao(solicitacaoInstance, [max: 1, sort: 'data', order: 'desc'])
			def ultimaSituacao = situacoes[0]
			def resolvido = Estado.findByNome('Resolvido')
			def rejeitado = Estado.findByNome('Rejeitado')
			def podeResolver = ultimaSituacao.estado != resolvido
			def podeRejeitar =  ultimaSituacao.estado != rejeitado
			
            [solicitacaoInstance: solicitacaoInstance, podeResolver: podeResolver, podeRejeitar: podeRejeitar]
        }
    }

    def edit = {
        def solicitacaoInstance = Solicitacao.get(params.id)
        if (!solicitacaoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [solicitacaoInstance: solicitacaoInstance]
        }
    }

    def update = {
        def solicitacaoInstance = Solicitacao.get(params.id)
        if (solicitacaoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (solicitacaoInstance.version > version) {
                    
                    solicitacaoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'solicitacao.label', default: 'Solicitacao')] as Object[], "Another user has updated this Solicitacao while you were editing")
                    render(view: "edit", model: [solicitacaoInstance: solicitacaoInstance])
                    return
                }
            }
            solicitacaoInstance.properties = params
            if (!solicitacaoInstance.hasErrors() && solicitacaoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), solicitacaoInstance.id])}"
                redirect(action: "show", id: solicitacaoInstance.id)
            }
            else {
                render(view: "edit", model: [solicitacaoInstance: solicitacaoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def solicitacaoInstance = Solicitacao.get(params.id)
        if (solicitacaoInstance) {
            try {
                solicitacaoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'solicitacao.label', default: 'Solicitacao'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def resolver = {
		def solicitacao = Solicitacao.get(params.id)
		def justificativa = params.justificativa
		def resolvido = Estado.findByNome('Resolvido')
		
		def situacoes = Situacao.findAllBySolicitacao(solicitacao)
		def ultimaSituacao = situacoes[-1]
		
		new Situacao(estado: resolvido, data: new Date(), observacao: justificativa, responsavel: ultimaSituacao.responsavel, solicitacao: solicitacao).save(flush: true, failOnError: true)
		
		mailService.sendMail{
				to solicitacao.requerente.email
				subject "Solicitacao Resolvida"
				body "Sua Solicitacao ${solicitacao.tipo.nome} Foi resolvida"
			}
		
	}
	
	def rejeitar = {
		def solicitacao = Solicitacao.get(params.id)
		def justificativa = params.justificativa
		def rejeitado = Estado.findByNome('Rejeitado')
		
		def situacoes = Situacao.findAllBySolicitacao(solicitacao)
		
		def situacaoInstance = new Situacao(estado: rejeitado, data: new Date(), observacao: justificativa,
			 responsavel: situacoes[-1].responsavel, solicitacao: solicitacao).save(flush: true, failOnError: true)
		
		mailService.sendMail{
			to solicitacao.requerente.email
			subject "Solicitacao Rejeitada"
			body "Sua Solicitacao ${solicitacao.tipo.nome} Foi Rejeitada.  Motivo:${situacaoInstance.observacao}"
			}
		
		}
	
	def encaminhar = {
		def solicitacao = Solicitacao.get(params.id)
		def justificativa = params.justificativa
		def remetente = Pessoa.get(params.remetente)
		def situacoes = Situacao.findAllBySolicitacao(solicitacao, [max: 1, sort: 'data', order: 'desc'])
		def ultimaSituacao = situacoes[0]
		def encaminhado = Estado.findByNome('Encaminhado')
		
		def e = new Encaminhamento(remetente: ultimaSituacao.responsavel, destinatario: remetente, 
			justificativa: justificativa, data: new Date()).save(flush: true, failOnError: true)
		def situacao = new Situacao(estado: encaminhado, data: new Date(), observacao: justificativa, 
			responsavel:remetente, solicitacao: solicitacao, encaminhamento: e).save(flush: true, failOnError: true)
			
		mailService.sendMail{
			to e.destinatario.email
			subject solicitacao.tipo.nome
			html "Encaminhado de: ${e.remetente} justificativa: ${justificativa}."
			}	
			
	}
	
}
