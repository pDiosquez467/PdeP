
// ------------------------------------------------------------------------------------------
// === CONTENIDO
// ------------------------------------------------------------------------------------------

class Contenido {
    const titulo
    method titulo() = titulo

    const vistas 
    method vistas() = vistas 

    var property esOfensivo 
    var property tags

    var property monetizacion 

    method totalRecaudado() = monetizacion.dineroRecaudado(self)

    method esPopular()

}

class Video inherits Contenido {
    
    override method esPopular() = vistas > 10000
}

class Imagen inherits Contenido {
    
    override method esPopular() = false

}

// ------------------------------------------------------------------------------------------
// === USUARIOS
// ------------------------------------------------------------------------------------------

class Usuario {
    var property nombre
    var property email 

    const contenidos 

    var property estaVerificado = false 

    method publicar(contenido, monetizacion) {
        contenido.monetizacion(monetizacion)
        contenidos.add(contenido)
    }

    method marcarComoOfensivo(contenido) {
        contenido.esOfensivo(true)
    }

    method saldoTotal() = contenidos.sum({ contenido => contenido.totalRecaudado() })

    method esSuperUsuario() = contenidos.size() > 10

}

// ------------------------------------------------------------------------------------------
// === ESTRATEGIAS DE MONETIZACIÓN
// ------------------------------------------------------------------------------------------

object publicidad {

    method dineroRecaudado(contenido, monto) = monto

    method puedeMonetizar(contenido) = not contenido.esOfensivo()
}

object donacion {

    method dineroRecaudado(contenido, monto) = monto

    method puedeMonetizar(contenido) = true 
}

object ventaDescarga {

    method dineroRecaudado(contenido, monto) = monto

    method puedeMonetizar(contenido) = contenido.esPopular()
}