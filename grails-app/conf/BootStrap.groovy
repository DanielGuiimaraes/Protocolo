import protocolo1_1.*
class BootStrap {
		
	def springSecurityService
	
    def init = { servletContext ->
		

		
		Estado.findByNome('Criado') ?: new Estado(nome:'Criado').save()
		Estado.findByNome('Encaminhado') ?: new Estado(nome:'Encaminhado').save()
		Estado.findByNome('Resolvido') ?: new Estado(nome:'Resolvido').save()
		Estado.findByNome('Rejeitado') ?: new Estado(nome:'Rejeitado').save()
		Estado.findByNome('Em Processo') ?: new Estado(nome:'Em Processo').save()
		
		def controleAcademico = Categoria.findByNome('Controle academico') ?: new Categoria(nome:'Controle Academico').save()
		def coordenacaoDeCurso = Categoria.findByNome('Coordenacao de Curso') ?: new Categoria(nome:'Coordenacao de Curso').save()
		def diretoriaAdministraticaFinanceira = Categoria.findByNome('Diretotia Administratica Financeira') ?: new Categoria(nome:'Diretotia Administratica Financeira').save()
		
		def diretorAcademico = Pessoa.findByNome('Diretor Academico') ?: new Pessoa(nome:'Diretor Academico',email: 'dnlguimaraes@gmail.com').save()
		def diretorDeCurso = Pessoa.findByNome('Coordenacao De Curso') ?: new Pessoa(nome:'Coordenacao De Curso', email: 'dnlguimaraes@gmail.com').save()
		def diretorFincanceiro = Pessoa.findByNome('Diretor Fincanceiro') ?: new Pessoa(nome:'Diretor Fincanceiro', email: 'dnlguimaraes@gmail.com').save()
		
		Tipo.findByNome('Certidao de Conclusao de Curso') ?: new Tipo(nome:'Certidao de Conclusao de Curso', responsavel: diretorAcademico, categoria: controleAcademico).save()
		Tipo.findByNome('Dispensa de Disciplina') ?: new Tipo(nome:'Dispensa de Disciplina', responsavel: diretorDeCurso, categoria: coordenacaoDeCurso).save()
		Tipo.findByNome('Segunda Via de Carne') ?: new Tipo(nome:'Segunda Via de Carne', responsavel: diretorFincanceiro, categoria: diretoriaAdministraticaFinanceira).save()
		
		def userRole = SecRole.findByAuthority('ROLE_USUARIO') ?: new SecRole(authority: 'ROLE_USUARIO').save(failOnError: true)
		def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
		
		def adminUser = SecUser.findByUsername('admin') ?: new SecUser(
						username: 'admin',
						password: springSecurityService.encodePassword('admin'),
						enabled: true).save(failOnError: true)
				    	if (!adminUser.authorities.contains(adminRole)) {
						SecUserSecRole.create adminUser, adminRole
					}
			
		
				
		
		
		Pessoa.findByNome('Daniel Guimaraes') ?: new Pessoa(nome:'Daniel Guimaraes', email:'dnlguimaraes@gmail.com').save()
	    
    }
    def destroy = {
    }
}
