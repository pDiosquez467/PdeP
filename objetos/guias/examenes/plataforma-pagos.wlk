// ------------------------------------------------------------------------------------------
// === PLATAFORMA
// ------------------------------------------------------------------------------------------

object plataforma {

    const usuarios = []

    method emailUsuariosVerificadosConMayorSaldo() = 
        usuarios
            .filter({ us => us.estaVerificado() })
            .sortedBy({ us, otro => us.saldoTotal() > otro.saldoTotal() })
            .map({ us => us.email() })
            .take(100)

    method cantidadSuperUsuarios() = usuarios.filter({ us => us.esSuperUsuario() }).size()

}


// ------------------------------------------------------------------------------------------
// === CONTENIDO
// ------------------------------------------------------------------------------------------

class Contenido {
    const titulo
    method titulo() = titulo

    const vistas 
    method vistas() = vistas 

    var property valorVenta 

    var property esOfensivo 
    var property tags

    var property monetizacion 

    method totalRecaudado() = monetizacion.dineroRecaudado(self)

    method esPopular()

}

class Video inherits Contenido {

    override method esPopular() = vistas > 10000

    method limiteRecaudacionPublicidad() = 10000

    method esAlquilable() = true 
}

class Imagen inherits Contenido {
    
    override method esPopular() = tags.size() == tags.filter({ tag => ["A", "B", "C"].includes(tag) }).size() 

    method limiteRecaudacionPublicidad() = 4000

    method esAlquilable() = false 
}

// ------------------------------------------------------------------------------------------
// === USUARIOS
// ------------------------------------------------------------------------------------------

class Usuario {
    var property nombre
    var property email 

    const contenidos 

    var property estaVerificado = false 

    method monetizar(contenido, monetizacion) {
        contenido.monetizacion(monetizacion)
    }

    method publicar(contenido) {
        contenidos.add(contenido)
    }

    method marcarComoOfensivo(contenido) {
        contenido.esOfensivo(true)
    }

    method saldoTotal() = contenidos.sum({ contenido => contenido.totalRecaudado() })

    method esSuperUsuario() = contenidos.size() > 10

    method asignarValorVenta(contenido, monetizacion, valor) {
        if (valor < monetizacion.precioMinimoVenta()) 
            throw new Exception(message = "Error")    
        contenido.valorVenta(valor)
    }

}

// ------------------------------------------------------------------------------------------
// === ESTRATEGIAS DE MONETIZACIÓN
// ------------------------------------------------------------------------------------------

object publicidad {

    method dineroRecaudado(contenido) {
        var totalBase = contenido.vistas() * 0.05
        
        if (totalBase > contenido.limiteRecaudacionPublicidad()) {
            throw new Exception(message = "Límite de recaudación excedido")
        }

        if (contenido.esPopular()) {
            totalBase += 2000
        }
        return totalBase 
    }

    method puedeMonetizar(contenido) = not contenido.esOfensivo()
}

object donacion {

    method dineroRecaudado(contenido) = 0

    method puedeMonetizar(contenido) = true 
}

object ventaDescarga {

    method precioMinimoVenta() = 5

    method dineroRecaudado(contenido) = contenido.valorVenta(self) * contenido.vistas()

    method puedeMonetizar(contenido) = contenido.esPopular()
}

object alquiler {
    
    method precioMinimoVenta() = 1

    method dineroRecaudado(contenido) = contenido.valorVenta(self) * contenido.vistas()

    method puedeMonetizar(contenido) = contenido.esAlquilable() 
}