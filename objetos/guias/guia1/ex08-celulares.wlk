// =====================================================================================
// === CELULARES
// =====================================================================================

/*
 * Clase base para representar un celular.
 * Tiene una batería con carga de 0 a 5.
 */
class Celular {
    var bateria = 5

    // Devuelve true si la batería está agotada.
    method estaApagado() = bateria <= 0 

    // Recarga la batería al máximo.
    method llenarBateriaAlMaximo() {
        bateria = 5
    }

    // Método polimórfico que indica cuánto consume de batería una llamada.
    // Se redefine en las subclases.
    method bateriaQueConsume(duracion) { }
}

/*
 * Celular Samsung: consume batería de forma fija (0.25 por llamada).
 */
class Samsung inherits Celular {
    override method bateriaQueConsume(duracion) {
        bateria = bateria - 0.25
    }
}

/*
 * Celular iPhone: consume batería de forma proporcional a la duración.
 */
class Iphone inherits Celular {
    override method bateriaQueConsume(duracion) {
        bateria = bateria - 0.001 * duracion
    }
}

// =====================================================================================
// === EMPRESAS DE TELEFONÍA
// =====================================================================================

/*
 * Movistar cobra 60 por cada minuto de llamada. Mensajes: 0.12.
 */
object movistar {
    method costoLlamada(duracion) = 60 * duracion
    method costoPorMensaje() = 0.12
}

/*
 * Personal cobra 70 si la llamada dura hasta 10 min, luego 40 por minuto extra.
 */
object personal {
    method costoLlamada(duracion) = 70 + 40 * (duracion - 10)
    method costoPorMensaje() = 0.15
}

/*
 * Claro cobra 0.50 + IVA (21%) por llamada, independientemente de la duración.
 */
object claro {
    method costoLlamada(duracion) = 0.50 + 0.50 * 0.21
    method costoPorMensaje() = 0.12
}

// =====================================================================================
// === PERSONA
// =====================================================================================

/*
 * Representa una persona que tiene un celular y está asociada a una empresa.
 * Puede hacer llamadas, enviar y recibir mensajes, y acumula su gasto total.
 */
class Persona {
    var property celular 
    var property empresa
    var property montoTotal = 0

    const mensajes = []

    method tieneElCelularApagado() = celular.estaApagado()

    method recargarCelular() {
        celular.llenarBateriaAlMaximo()
    }

    method cambiarCelular(nuevoCelular) {
        celular = nuevoCelular
    }

    method llamar(duracion) {
        celular.bateriaQueConsume(duracion)
        montoTotal = montoTotal + empresa.costoLlamada(duracion)
    } 

    method enviarMensaje(destinatario, texto) {
        destinatario.recibirMensaje(texto)
        montoTotal = montoTotal + empresa.costoPorMensaje()
    }

    method recibirMensaje(texto) {
        mensajes.add(texto)
    }

    method cantidadMensajesRecibidos() = mensajes.size()  

    method recibioEsteMensaje(mensaje) = mensajes.includes(mensaje)

    method recibioMensajeQueEmpieceCon(comienzo) =
        mensajes.any({ m => m.startsWith(comienzo) })
}

// =====================================================================================
// === INSTANCIAS DE PERSONA
// =====================================================================================

object fabricaDePersonas {
    method conSamsungYPersonal() = new Persona(celular = new Samsung(), empresa = personal)
    method conIphoneYMovistar() = new Persona(celular = new Iphone(), empresa = movistar)
    method conIphoneYPersonal() = new Persona(celular = new Iphone(), empresa = personal)
    method conIphoneYClaro() = new Persona(celular = new Iphone(), empresa = claro)

}


const juliana  = fabricaDePersonas.conSamsungYPersonal()
const catalina = fabricaDePersonas.conIphoneYMovistar()
const juan     = fabricaDePersonas.conIphoneYPersonal()
const ernesto  = fabricaDePersonas.conIphoneYClaro()