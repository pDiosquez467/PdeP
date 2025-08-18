// =======================================================================================
// === POKEMONS
// =======================================================================================

class Pokemon {

    const vidaMaxima
    var vidaActual  
    const movimientos 
    var property puedeMoverse = true
    const property condicion

    method estaVivo() = vidaActual > 0

    method grositud() = vidaMaxima * movimientos.sum({ movimiento => movimiento.poder() })

    method movimientosDispobibles() = 
        movimientos.filter({ movimiento => not movimiento.estaAgotado() })

    method recargarVida(cantidad) {
        vidaActual = vidaMaxima.min(vidaActual + cantidad)
    }

    method disminuirVida(cantidad) {
        vidaActual = 0.max(vidaActual - cantidad)
    }

    method puedeLuchar() = self.estaVivo()

    method luchar(pokemon) {
        if (self.puedeLuchar()) {
            const movimiento = self.movimientosDispobibles().anyOne()
            movimiento.usar(self, pokemon)
        }
    }
}

// =======================================================================================
// === MOVIMIENTOS
// =======================================================================================

class Movimiento {
    var property usos

    method estaAgotado() = usos == 0

    method poder()

    method usar(pokemon, otro) {
        usos -= 1 
    }

}

class MovimientoCurativo inherits Movimiento {

    const puntosCuracion

    override method usar(pokemon, otro) {
        pokemon.recargarVida(puntosCuracion)
        super(pokemon, otro) 
    }

    override method poder() = puntosCuracion
}

class MovimientoDañino inherits Movimiento {

    const dañoProducido

    override method usar(pokemon, otro) {
        otro.disminuirVida(dañoProducido)
        super(pokemon, otro)
    }

    override method poder() = dañoProducido * 2 
}

class MovimientoEspecial inherits Movimiento {

    const condicion 

    override method usar(pokemon, otro) {
        otro.condicion(condicion) 
        super(pokemon, otro)  
    }

    override method poder() = condicion.poder()
    
}

// =======================================================================================
// === CONDICIONES
// =======================================================================================

object dormido {

    method puedeMoverse(pokemon) {
        const puedeMoverse = 0.randomUpTo(2).roundUp().even()
        pokemon.puedeMoverse(puedeMoverse)
    } 
        
    method poder() = 30
}

class Paralizado {

    var turnosParalizado = 2

    method puedeMoverse(pokemon) {
        const puedeMoverse = 0.randomUpTo(2).roundUp().even() && turnosParalizado == 0
        turnosParalizado -= 1
        pokemon.puedeMoverse(puedeMoverse)
    }

    method poder() = 50
}
