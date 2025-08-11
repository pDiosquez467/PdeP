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

}

class A105 inherits Equipo{

}

class B2 inherits Equipo {

}

// -------------------------------------------------------------------------------------------
// === MODOS
// -------------------------------------------------------------------------------------------

object standard {

    method consumoDe(equipo) = 0

    method computoDe(equipo) = 0
  
}

class Overclock {

    method consumoDe(equipo) = 0

    method computoDe(equipo) = 0

}

class AhorroDeEnergia {

    method consumoDe(equipo) = 0

    method computoDe(equipo) = 0

}