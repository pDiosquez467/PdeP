// -------------------------------------------------------------------------------------------
// === SUPERCOMPUTADORAS
// -------------------------------------------------------------------------------------------
class SuperComputadora {
    const equipos = []

    method equiposActivos() = equipos.filter({ equipo => equipo.estaActivo() })

    method computo() = self.equiposActivos().sum({ equipo => equipo.computo() })

    method consumo() = self.equiposActivos().sum({ equipo => equipo.consumo() })

    method equipoActivoQueMas(criterio) = self.equiposActivos().max(criterio)

    method estaMalConfigurada() = 
        self.equipoActivoQueMas({ eq => eq.consumo() }) != 
        self.equipoActivoQueMas({ eq => eq.computo() })

    method estaActivo() = true
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

}

class A105 inherits Equipo{

    override method consumoBase() = 300

    override method computoBase() = 600

    override method computoExtraPorOverClock() = self.computoBase() * 0.3

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
  
}

class Overclock {

    method consumoDe(equipo) = equipo.consumoBase() * 2

    method computoDe(equipo) = equipo.computoBase() + equipo.computoExtraPorOverClock()

}

class AhorroDeEnergia {

    method consumoDe(equipo) = 200

    method computoDe(equipo) = (self.consumoDe(equipo) / equipo.consumoBase()) * equipo.computoBase()

}