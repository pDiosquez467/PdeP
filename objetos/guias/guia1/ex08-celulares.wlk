
// -------------------------------------------------------------------------------------
// === CELULARES
// -------------------------------------------------------------------------------------

class Celular {
    var bateria = 5

    method estáApagado() = bateria <= 0 

    method llenarBateríaAlMáximo() {
        bateria = 5
    }

    method bateríaQueConsume(duración) 
  
}

class Samsung inherits Celular{
    
    override method bateríaQueConsume(duración) {
        bateria = bateria - 0.25
    }
  
}


class Iphone inherits Celular{
    
    override method bateríaQueConsume(duración) {
        bateria = bateria - 0.001 * duración
    }

}


// -------------------------------------------------------------------------------------
// === EMPRESAS
// -------------------------------------------------------------------------------------

object movistar {
    method costoLlamada(duración) = 60 * duración

    method costoPorMensaje() = 0.12
}

object personal {
    method costoLlamada(duración) = 70 + 40 * (duración - 10) 

    method costoPorMensaje() = 0.15
}

object claro {
    method costoLlamada(duración) = 0.50 * 1.21 

    method costoPorMensaje() = 0.12
}

// -------------------------------------------------------------------------------------
// === Clase Persona
// -------------------------------------------------------------------------------------

class Persona {
    var property celular 

    var property empresa

    var property montoTotal = 0

    const mensajes = []

    method tieneElCelularApagado() = celular.estáApagado()

    method recargarCelular() {
        celular.llenarBateríaAlMáximo()
    }

    method cambiarCelular(nuevoCelular) {
        celular = nuevoCelular
    }

    method llamar(duración) {
        celular.bateríaQueConsume(duración)
        montoTotal = montoTotal + empresa.costoLlamada(duración)
    } 

    method enviarMensaje(destinatario, texto) {
        destinatario.recibirMensaje(texto)
        montoTotal = montoTotal + empresa.costoPorMensaje()
    }

    method recibirMensaje(texto) {
        mensajes.add(texto)
    }

    method cantidadMensajesRecibidos() = mensajes.size()  

    method recibióEsteMensaje(mensaje) = mensajes.includes(mensaje)

    method recibióMensajeQueEmpieceCon(comienzo) =
         mensajes.findOrElse({ m => m.startsWith(comienzo) }, { null }) 
  
}

// -------------------------------------------------------------------------------------
// === Instancias de Persona
// -------------------------------------------------------------------------------------

const juliana  = new Persona(celular = new Samsung(), empresa = personal)
const catalina = new Persona(celular = new Iphone(), empresa = movistar)
const juan     = new Persona(celular = new Iphone(), empresa = personal)
const ernesto  = new Persona(celular = new Iphone(), empresa = claro)
