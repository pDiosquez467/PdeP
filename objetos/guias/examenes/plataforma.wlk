// ============================================================================================
// === CONTENIDOS
// ============================================================================================

class Contenido {
    const property titulo
    var property vistas = 0
    var property esOfensivo = false 
    var property monetizacion 

    method recaudacion() = monetizacion.recaudacionDe(self)

    method esPopular()

    method recaudacionMaximaParaPublicidad()
}

class Video inherits Contenido {

    override method esPopular() = vistas > 10000

    override method recaudacionMaximaParaPublicidad() = 10000
}

const tagsDeModa = []
class Imagen inherits Contenido {
    
    const property tags

    override method esPopular() = tagsDeModa.all({ tag => tags.contains(tag) })

    override method recaudacionMaximaParaPublicidad() = 4000
}

// ============================================================================================
// === MONETIZACIÓN
// ============================================================================================

object publicidad {

    method recaudacionDe(contenido) = (
        contenido.vistas() * 0.05 +
        if (contenido.esPopular()) 2000 else 0
    ).min(contenido.recaudacionMaximaParaPublicidad())
}

class Donacion {
    var property donacion

    method recaudacionDe(contenido) = donacion
}

class Descarga {
    var property precio 
    
    method recaudacionDe(contenido) = contenido.vistas() * precio 
}

// ============================================================================================
// === USUARIOS
// ============================================================================================

object usuarios {

    const usuarios = []

    method emailsDeUsuariosRicos() = 
        usuarios
            .filter({ us => us.estaVerificado() })
            .sortedBy({ us, otro => us.saldoTotal() > otro.saldoTotal() })
            .take(100)
            .map({ us => us.email() })

    method cantidadDeSuperUsuarios() = usuarios.count({ us => us.esSuperUsuario() })
}

class Usuario {
    const property nombre
    const property email
    var property estaVerificado = false  
    const contenidos 

    method saldoTotal() = contenidos.sum({ contenido => contenido.recaudacion() })

    method esSuperUsuario() = contenidos.count({ contenido => contenido.esPopular() }) >= 10

}