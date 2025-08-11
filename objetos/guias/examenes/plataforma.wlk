// ============================================================================================
// === CONTENIDOS
// ============================================================================================

class Contenido {
    const property titulo
    var property vistas = 0
    var property esOfensivo = false 
    var property monetizacion 

    method monetizacion(nueva) {
        self.validarMonetizacion()
        monetizacion = nueva 
    }

    override method initialize() {
        self.validarMonetizacion()
    }

    method validarMonetizacion() {
        if (!monetizacion.puedeMonetizar(self)) {
            throw new Exception(message = "El contenido no puede ser monetizado")
        }
    }

    method recaudacion() = monetizacion.recaudacionDe(self)

    method esPopular()

    method recaudacionMaximaParaPublicidad()

    method esAlquilable()
}

class Video inherits Contenido {

    override method esPopular() = vistas > 10000

    override method recaudacionMaximaParaPublicidad() = 10000

    override method esAlquilable() = true 

}

const tagsDeModa = []
class Imagen inherits Contenido {
    
    const property tags

    override method esPopular() = tagsDeModa.all({ tag => tags.contains(tag) })

    override method recaudacionMaximaParaPublicidad() = 4000

    override method esAlquilable() = false 
}

// ============================================================================================
// === MONETIZACIÓN
// ============================================================================================

object publicidad {

    method recaudacionDe(contenido) = (
        contenido.vistas() * 0.05 +
        if (contenido.esPopular()) 2000 else 0
    ).min(contenido.recaudacionMaximaParaPublicidad())

    method puedeMonetizar(contenido) = not contenido.esOfensivo()
}

class Donacion {
    var property donacion

    method recaudacionDe(contenido) = donacion

    method puedeMonetizar(contenido) = true 
}

class Descarga {
    var property precio 
    
    override method initialize() {
        if (precio < 5) {
            throw new Exception(message = "El precio de venta debe ser >= $5")
        }
    }

    method recaudacionDe(contenido) = contenido.vistas() * precio 

    method puedeMonetizar(contenido) = contenido.esPopular()
}

class Alquiler inherits Descarga {

    override method initialize() {
        if (precio < 1) {
            throw new Exception(message = "El precio de alquiler debe ser >= $1")
        }
    }

    override method puedeMonetizar(contenido) = contenido.esAlquilable()
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

    method publicar(contenido) {
        contenidos.add(contenido)
    }
}
