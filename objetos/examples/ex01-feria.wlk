
object julieta {
    const fuerza = 80
    var cansancio = 0
    var punteria = 20
    var tickets = 15

    method fuerza() = fuerza - cansancio
    
    method cansancio() = cansancio 
    method acumulaCansancio(puntos) {
        cansancio += puntos
    }

    method tickets() = tickets
    method ganaTickets(númeroTickets) {
        tickets += númeroTickets
    } 

    method punteria() = punteria
    method aumentaSuPunteriaEn(puntos) {
        punteria += puntos
    }

}

object tiroAlBlanco {
    
    method jugar(unJugador) {
        unJugador.ganaTickets((unJugador.punteria() / 10).roundUp())
        unJugador.aumentaSuPunteriaEn(2)
        unJugador.acumulaCansancio(3)
    }

}

object pruebaFuerza {
    
    method jugar(unJugador) {
        if (unJugador.fuerza() >= 75) unJugador.ganaTickets(20)
        unJugador.acumulaCansancio(8)
    }
}

object ruedaFortuna {
    const límiteDeGiros = 20
    var númeroDeGiros = 0

    method númeroDeGiros(número) {
        númeroDeGiros += número
    }

    method estáBienAceitada() = númeroDeGiros <= límiteDeGiros 
    
    method numeroAlAzar() {
        return 1.randomUpTo(20) 
    }
    
    method jugar(unJugador) {
        self.númeroDeGiros(1)
        unJugador.ganaTickets(self.numeroAlAzar())
        if (!self.estáBienAceitada()) unJugador.acumulaCansancio(1) 
    }
}

object ositoPeluche {
    const costoTickets = 45
    method costoTickets() = costoTickets 

    method puedeSerCanjeadoPor(unJugador) = unJugador.tickets() >= self.costoTickets()
}

object taladro {
    var costo = 45
    const coeficienteDeAjuste = 1.25
    method costoTickets() = costo

    method nuevoCosto(precioDolar) = costo + coeficienteDeAjuste * precioDolar

    method costoTickets(precioDolar) {
        costo += self.nuevoCosto(precioDolar)
    }

    method puedeSerCanjeadoPor(unJugador) = unJugador.tickets() >= self.costoTickets()
}
