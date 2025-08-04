
// -------------------------------------------------------------------------------------
// === CELULARES
// -------------------------------------------------------------------------------------

object samsung {
    var bateria = 5

    method estáApagado() = bateria == 0 

    method llenarBateríaAlMáximo() {
        bateria = 5
    }

    method bateríaQueConsume(duración) {
        bateria = bateria - 0.25
    }
  
}


object iphone {
    var property bateria = 5

    method estáApagado() = bateria == 0 

    method llenarBateríaAlMáximo() {
        bateria = 5
    }

    method bateríaQueConsume(duración) {
        bateria = bateria - 0.001 * duración
    }

}


// -------------------------------------------------------------------------------------
// === EMPRESAS
// -------------------------------------------------------------------------------------

object movistar {
    method costoLlamada(duración) = 60 * duración
}

object personal {
    method costoLlamada(duración) = 70 + 40 * (duración - 10) 
}

object claro {
    method costoLlamada(duración) = 1.21 * 50 * duración 
}

// -------------------------------------------------------------------------------------
// === PERSONAS
// -------------------------------------------------------------------------------------

object juliana {
    var celular = samsung

    var property empresa = personal

    var property montoTotal = 0

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
  
}

object catalina {
    var celular = iphone

    var property empresa = movistar

    var property montoTotal = 0

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

}
