// ===========================================================================================
// === EQUIPOS
// ===========================================================================================
class Equipo {
  var property modo
  var property estaQuemado = false
  var property cantidadComputos = 0
  
  method consumoBase()
  
  method capacidadComputoBase()
  
  method capacidadComputoOverclock()
  
  method estaActivo() = (not estaQuemado) && (self.capacidadComputo() > 0)
  
  method consumo()
  
  method capacidadComputo()
  
  method computar(complejidad) {
    self.validarComputo(complejidad)
    
    if (complejidad > self.capacidadComputo()) {
      throw new Exception(message = "Capacidad de cómputo excedida")
    }
    
    cantidadComputos += 1
    self.actualizarEstado()
    
    if (self.estaQuemado()) {
      throw new Exception(message = "Equipo quemado")
    }
  }
  
  method actualizarEstado() {
    modo.estadoEquipo(self)
  }
  
  method validarComputo(complejidad) {
    
  }
}

class A105 inherits Equipo {
  override method consumoBase() = 300
  
  override method capacidadComputoBase() = 600
  
  override method capacidadComputoOverclock() = self.capacidadComputoBase() * 1.3
  
  override method consumo() = modo.consumoRequerido(self)
  
  override method capacidadComputo() = modo.capacidadGenerada(self)
  
  override method validarComputo(complejidad) {
    if (complejidad < 5) {
      throw new Exception(message = "Complejidad demasiado baja")
    }
  }
}

class B2 inherits Equipo {
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
  var complejidadCalculada = 0
  
  method conectarEquipo(equipo) {
    equipos.add(equipo)
  }
  
  method equiposActivos() = equipos.filter({ equipo => equipo.estaActivo() })
  
  method sumaSobreActivos(bloque) = self.equiposActivos().sum(bloque)
  
  method maximoSobreActivos(bloque) = self.equiposActivos().max(bloque)
  
  method cantidadEquiposActivos() = self.equiposActivos().size()
  
  method capacidadComputo() = self.sumaSobreActivos(
    { equipo => equipo.capacidadComputo() }
  )
  
  method capacidadConsumo() = self.sumaSobreActivos(
    { equipo => equipo.capacidadConsumo() }
  )
  
  method equipoMayorConsumo() = self.maximoSobreActivos(
    { eq, otro => eq.capacidadConsumo() > otro.capacidadConsumo() }
  )
  
  method equipoMayorComputo() = self.maximoSobreActivos(
    { eq, otro => eq.capacidadComputo() > otro.capacidadComputo() }
  )
  
  method estaMalConfigurada() = self.equipoMayorConsumo() != self.equipoMayorComputo()
  
  method computar(complejidad) {
    const fraccionCompl = complejidad / self.cantidadEquiposActivos()
    self.equiposActivos().map({ equipo => equipo.computar(fraccionCompl) })
    complejidadCalculada += complejidad
  }
}
// ===========================================================================================

// === MODOS
// ===========================================================================================
object standard {
  method consumoRequerido(equipo) = equipo.consumoBase()
  
  method capacidadGenerada(equipo) = equipo.capacidadComputoBase()
  
  method estadoEquipo(equipo) {
    
  }
}

class Overclock {
  const property nroMaximoUso
  
  method consumoRequerido(equipo) = equipo.consumoBase() * 2
  
  method capacidadGenerada(equipo) = equipo.capacidadComputoOverclock()
  
  method estadoEquipo(equipo) {
    if (equipo.cantidadComputos() == nroMaximoUso) equipo.estaQuemado(true)
  }
}

class Ahorro {
  method nroMaximoComputos() = 17

  method consumoRequerido(equipo) = 200
  
  method capacidadGenerada(
    equipo
  ) = equipo.capacidadComputoBase() * (200 / equipo.consumoBase())
  
  method estadoEquipo(equipo) {
    if (equipo.cantidadComputos() == self.nroMaximoComputos()) equipo.estaQuemado(true)
  }
}

class APruebaDeFallos inherits Ahorro {
    override method nroMaximoComputos() = 100

    override method capacidadGenerada(equipo) = super(equipo) * 0.5

}