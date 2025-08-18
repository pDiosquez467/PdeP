// =======================================================================================
// === POKEMONS
// =======================================================================================

class Pokemon {

    const vidaMaxima
    var vidaActual  
    const movimientos 
    var property puedeMoverse = true 

    method estaVivo() = vidaActual > 0

    method grositud() = vidaMaxima * movimientos.sum({ movimiento => movimiento.poder() })

    method recargarVida(cantidad) {
        vidaActual = vidaMaxima.min(vidaActual + cantidad)
    }

    method luchar(pokemon) {
        if (self.estaVivo() && self.puedeMoverse()) {
            const movimiento = movimientos.anyOne()
            if (not movimiento.estaAgotado()) movimiento.usar(self, pokemon)
        }
    }
}

// =======================================================================================
// === MOVIMIENTOS
// =======================================================================================

class MovimientoCurativo {

    var property usos = 10

    const puntosCuracion

    method estaAgotado() = usos == 0

    method usar(pokemon, otro) {
        pokemon.recargarVida(puntosCuracion)
        usos -= 1 
    }

    method poder() = puntosCuracion
}

class MovimientoDañino {

    var property usos = 10

    const dañoProducido

    method usar(pokemon, otro) {
        
        usos -= 1
    }

    method poder() = dañoProducido * 2 
}

class MovimientoEspecial {

    var property usos = 10

    method usar(pokemon, otro) {
        
        usos -= 1
    }

    method poder()

    method puedeUsarse() = 0.randomUpTo(2).roundUp().even()
}

object sueño inherits MovimientoEspecial() {

    override method poder() = 30
}

object paralisis inherits MovimientoEspecial() {

    override method poder() = 50
}