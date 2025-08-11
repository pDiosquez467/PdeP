// -------------------------------------------------------------------------------------------
// === SUPERCOMPUTADORAS
// -------------------------------------------------------------------------------------------
class SuperComputadora {
    const equipos = []
    
    var totalComplejidadAcumulada = 0

    method equiposActivos() = equipos.filter({ equipo => equipo.estaActivo() })

    method estaActivo() = true

    method computo() = self.equiposActivos().sum({ equipo => equipo.computo() })

    method consumo() = self.equiposActivos().sum({ equipo => equipo.consumo() })

    method equipoActivoQueMas(criterio) = self.equiposActivos().max(criterio)

    method estaMalConfigurada() = 
        self.equipoActivoQueMas({ eq => eq.consumo() }) != 
        self.equipoActivoQueMas({ eq => eq.computo() })


    method computar(problema) {
        const subProblema = new Problema(complejidad = problema.complejidad() / self.equiposActivos().size())
        self.equiposActivos().forEach({ equipo => equipo.computar(subProblema) })
        
        totalComplejidadAcumulada += problema.complejidad()
    }
}

class Problema {
    
    const property complejidad
}

// -------------------------------------------------------------------------------------------
// === EQUIPOS
// -------------------------------------------------------------------------------------------

class Equipo {

    var property modo = standard

    var property estaQuemado = false 

    method estaActivo() = not estaQuemado && self.computo() > 0

    method consumo() = modo.consumoDe(self)

    method computo() = modo.computoDe(self)

    method consumoBase()

    method computoBase()

    method computoExtraPorOverClock()

    method computar(problema) {
        if (problema.complejidad() > self.computo()) {
            throw new DomainException(message = "Capacidad excedida")
        }

        modo.realizoComputo(self)
    }

}

class A105 inherits Equipo{

    override method consumoBase() = 300

    override method computoBase() = 600

    override method computoExtraPorOverClock() = self.computoBase() * 0.3

    override method computar(problema) {
        if (problema.complejidad() < 5) {
            throw new DomainException(message = "Error de fábrica")
        }
        super(problema)
    }

}

class B2 inherits Equipo {

    const microsInstalados

    override method consumoBase() = 10 + microsInstalados * 50

    override method computoBase() = 800.min(microsInstalados * 100)

    override method computoExtraPorOverClock() = microsInstalados * 20

}

// -------------------------------------------------------------------------------------------
// === MODOS
// -------------------------------------------------------------------------------------------

object standard {

    method consumoDe(equipo) = equipo.consumoBase()

    method computoDe(equipo) = equipo.computoBase()

    method realizoComputo(equipo) { }
}

class Overclock {
    var usosRestantes

    override method initialize() {
        if (usosRestantes < 0) {
            throw new DomainException(message = "'Usos restantes' deben ser >= 0")
        }
    }

    method consumoDe(equipo) = equipo.consumoBase() * 2

    method computoDe(equipo) = equipo.computoBase() + equipo.computoExtraPorOverClock()

    method realizoComputo(equipo) {
        if (usosRestantes == 0) {
            equipo.estaQuemado(true)
            throw new DomainException(message = "Equipo quemado")
        }
        usosRestantes -= 1
    }
}

class AhorroDeEnergia {
    var computosRealizados = 0

    method consumoDe(equipo) = 200

    method computoDe(equipo) = (self.consumoDe(equipo) / equipo.consumoBase()) * equipo.computoBase()

    method periodicidadError() = 17
    
    method realizoComputo(equipo) {
        computosRealizados += 1
        if (computosRealizados % self.periodicidadError() == 0) {
            throw new DomainException(message = "Error!")
        }
    }

}

class APruebaDeFallos inherits AhorroDeEnergia {

    override method computoDe(equipo) = super(equipo) / 2

    override method periodicidadError() = 100 
}