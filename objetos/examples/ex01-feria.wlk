// -------------------------------------------------------------------------------------------
// === JUGADORES
// -------------------------------------------------------------------------------------------
object julieta {
    var tickets = 15
    var cansancio = 0

    method cansancio(nuevoValor) {
        cansancio = nuevoValor
    }

    method fuerza() = 80 - cansancio

    method punteria() = 20 

    method jugar(unJuego) {
        tickets = tickets + unJuego.ticketsGanados()
        cansancio = cansancio + unJuego.cansacioQueGenera()
    }

    method puedeCanjear(unPremio) = false  
    
}

// -------------------------------------------------------------------------------------------
// === JUEGOS
// -------------------------------------------------------------------------------------------

object tiroAlBlanco {
    
}

object pruebaFuerza {
    
}

object ruedaFortuna {
    var property estaBienAceitada = true 

    method ticketsGanados() = 0.randomUpTo(20).roundUp()

    method cansancioQueGenera() = if (estaBienAceitada) 0 else 1
    
}

// -------------------------------------------------------------------------------------------
// === PREMIOS
// -------------------------------------------------------------------------------------------

object ositoPeluche {
    
}

object taladro {
    
}
