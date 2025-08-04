
// -------------------------------------------------------------------------------------
// === Celulares
// -------------------------------------------------------------------------------------

object samsung {
    var bateria = 5

    method estáApagado() = bateria == 0 

    method recargar() {
        bateria = 5
    }

    method realizarLlamada(duración) {
        bateria = bateria - 0.25
    }
  
}


object iphone {
    var property bateria = 5

    method estáApagado() = bateria == 0 

    method recargar() {
        bateria = 5
    }

    method llamar(duración) {
        bateria = bateria - 0.001 * duración
    }

}


// -------------------------------------------------------------------------------------
// === Empresas
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
// === Personas
// -------------------------------------------------------------------------------------

object juliana {
    const celular = samsung

    const empresaTelefónica = personal

    var property monto = 0

    method tieneElCelularApagado() = celular.estáApagado()

    method llamar(duración) {
        celular.llamar(duración)
        monto = monto + empresaTelefónica.costoLlamada(duración)
    } 
  
}

object catalina {
    const celular = iphone

    const empresaTelefónica = movistar

    var property monto = 0

    method tieneElCelularApagado() = celular.estáApagado()

    method llamar(duración) {
        celular.llamar(duración)
        monto = monto + empresaTelefónica.costoLlamada(duración)
    } 

}
