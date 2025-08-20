// =======================================================================================
// === POKEMONS
// =======================================================================================
class Pokemon {

    const vidaMaxima
    var vida  
    const movimientos = #{}
    var property condicion = normal 

    override method initialize() {
        if (vida > vidaMaxima or vida <= 0) {
            throw new DomainException(message = "Debe ser 0 <= vida <= vidaMaxima!")
        }
    }

    method estaVivo() = vida > 0

    method puedeMoverse() = condicion.puedeMoverse(self)

    method normalizar() {
        condicion = normal
    }

    method grositud() = vidaMaxima * movimientos.sum({ movimiento => movimiento.poder() })

    method movimientosDisponible() = 
        movimientos.find({ movimiento => movimiento.estaDisponible() })

    method restaurarVida(cantidad) {
        vida = vidaMaxima.min(vida + cantidad)
    }

    method recibirDaño(daño) {
        vida = 0.max(vida - daño)
    }

    method lucharContra(contrincante) {
        if (not self.estaVivo() && contrincante.estaVivo()) {
            throw new DomainException(message = "El pokemon NO puede luchar!")
        }
        const movimiento = self.movimientosDisponible()
        condicion.intentarMoverse(self)
        movimiento.usarEntre(self, contrincante)
    }
}

// =======================================================================================
// === MOVIMIENTOS
// =======================================================================================

class Movimiento {
    var property usosPendientes

    method estaDisponible() = usosPendientes > 0

    method poder()

    method usarEntre(pokemon, contrincante) {
        if (not self.estaDisponible()) {
            throw new DomainException(message = "El movimiento NO está disponible")
        }
        usosPendientes -= 1 
        self.afectarPokemons(pokemon, contrincante)
    }

    method afectarPokemons(pokemon, contrincante)

}

class MovimientoCurativo inherits Movimiento {

    const puntosDeSalud

    override method afectarPokemons(pokemon, contrincante) {
        pokemon.restaurarVida(puntosDeSalud)
    }

    override method poder() = puntosDeSalud
}

class MovimientoDañino inherits Movimiento {

    const dañoQueProduce

    override method afectarPokemons(pokemon, contrincante) {
        contrincante.recibirDaño(dañoQueProduce)
    }

    override method poder() = dañoQueProduce * 2 
}

class MovimientoEspecial inherits Movimiento {

    const condicionQueGenera 

    override method afectarPokemons(pokemon, contrincante) {
        contrincante.condicion(condicionQueGenera) 
    
    }

    override method poder() = condicionQueGenera.poder()
    
}

// =======================================================================================
// === CONDICIONES
// =======================================================================================
object normal {
    method puedeMoverse(pokemon) = true 

    method intentarMoverse(pokemon) {

    }
}

class CondicionEspecial {
    method puedeMoverse(pokemon) = 0.randomUpTo(2).roundUp().even()

    method intentarMoverse(pokemon) {
        if (not self.puedeMoverse(pokemon)) {
            throw new DomainException(message = "El pokemon NO pudo moverse!")
        }

        pokemon.normalizar()
    }
        
    method poder()
}


object sueño inherits CondicionEspecial() {

    override method intentarMoverse(pokemon) {
        super(pokemon)
        pokemon.normalizar()
    }
        
    override method poder() = 50
}

class Paralizado inherits CondicionEspecial {

    override method poder() = 30
}

class Confusion {

    var property turnosConfundido 

    method puedeMoverse(pokemon) { 
        pokemon.recibirDaño(20)
        turnosConfundido -= 1
        return turnosConfundido == 0
    }

    method poder() = turnosConfundido * 40
}
