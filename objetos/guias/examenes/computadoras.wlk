// ===========================================================================================
// === EQUIPOS
// ===========================================================================================

class Equipo {
    var property modo 
    var property estaQuemado = false  

    method consumoBase()
    method capacidadComputoBase()
    method capacidadComputoOverclock()
    method estaActivo() = not estaQuemado && self.capacidadComputo() > 0

    method consumo() 
    method capacidadComputo()
}

class A105 inherits Equipo {

    override method consumoBase() = 300
    override method capacidadComputoBase() = 600
    override method capacidadComputoOverclock() = self.capacidadComputoBase() * 1.3

    override method consumo() = modo.consumoRequerido(self)
    override method capacidadComputo() = modo.capacidadGenerada(self) 

}

class B2 inherits Equipo{
    var property cantidadMicrochips

    override method consumoBase() = cantidadMicrochips * 50
    override method capacidadComputoBase() = 800.min(cantidadMicrochips * 100)
    override method capacidadComputoOverclock() = cantidadMicrochips * 120
 
    override method consumo() = modo.consumoRequerido(self)
    override method capacidadComputo() = modo.capacidadGenerada(self) 

}

// ===========================================================================================
// === SC
// ===========================================================================================

class SuperComputadora {
    const equipos

    const otrasSuperComputadoras 

    method conectarEquipo(equipo) {
        equipos.add(equipo)
    }

    method cantidadEquiposActivos() = equipos.count({ equipo => equipo.estaActivo() })

    method capacidadComputo() = equipos
        .filter({ equipo => equipo.estaActivo() })
        .sum({ equipo => equipo.capacidadComputo() })

    method capacidadConsumo() = equipos
        .filter({ equipo => equipo.estaActivo() })
        .sum({ equipo => equipo.capacidadConsumo() })

    method equipoMayorConsumo() = equipos.max({ eq, otro => eq.capacidadConsumo() > otro.capacidadConsumo() })

    method equipoMayorComputo() = equipos.max({ eq, otro => eq.capacidadComputo() > otro.capacidadComputo() })

    method estaMalConfigurada() = self.equipoMayorConsumo() != self.equipoMayorComputo()
}

// ===========================================================================================
// === MODOS
// ===========================================================================================

object standard {

    method consumoRequerido(equipo) = equipo.consumoBase()
    method capacidadGenerada(equipo) = equipo.capacidadComputoBase()
}

class Overclock {
    const property nroMaximoUso

    method consumoRequerido(equipo) = equipo.consumoBase() * 2
    method capacidadGenerada(equipo) = equipo.capacidadComputoOverclock()

}

object ahorro {

    method consumoRequerido(equipo) = 200
    method capacidadGenerada(equipo) = 
        equipo.capacidadComputoBase() * (200 / equipo.consumoBase())
}