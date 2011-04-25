package protocolo1_1

class SecUser {

	String username
	String password
	Pessoa pessoa
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static constraints = {
		username (blank: false, unique: true)
		password (blank: false)
		pessoa (nullable: true)
	}

	static mapping = {
		password column: '`password`'
	}

	Set<SecRole> getAuthorities() {
		SecUserSecRole.findAllBySecUser(this).collect { it.secRole } as Set
	}
}
