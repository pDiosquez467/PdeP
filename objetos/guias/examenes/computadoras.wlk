// ===========================================================================================
// === EQUIPOS
// ===========================================================================================
class Equipo {
  var property modo
  var property estaQuemado = false
  
  method consumoBase()
  
  method computoBase()
  
  method computoExtraOverclock()
  
  method estaActivo() = (not estaQuemado) && (self.computo() > 0)
  
  method consumo()
  
  method computo()
  
  method computar(problema) {
    self.validarComputo(problema)
    
    if (problema.complejidad() > self.computo()) {
      throw new Exception(message = "Capacidad de cómputo excedida")
    }

    modo.computar(problema)
  }
  
  method validarComputo(problema) 
}

class A105 inherits Equipo {
  override method consumoBase() = 300
  
  override method computoBase() = 600
  
  override method computoExtraOverclock() = self.computoBase() * 0.3
  
  override method consumo() = modo.consumo(self)
  
  override method computo() = modo.computo(self)
  
  override method validarComputo(problema) {
    if (problema.complejidad() < 5) {
      throw new Exception(message = "Complejidad demasiado baja")
    }
  }
}

class B2 inherits Equipo {
  var property cantidadMicrochips
  
  override method consumoBase() = cantidadMicrochips * 50
  
  override method computoBase() = 800.min(cantidadMicrochips * 100)
  
  override method computoExtraOverclock() = cantidadMicrochips * 20
  
  override method consumo() = modo.consumo(self)
  
  override method computo() = modo.computo(self)

  override method validarComputo(problema) { }
}

class Problema {
  var property complejidad
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
  
  // === MÉTODOS DE LA INTERFAZ -- TODA SUPERCOMPUTADORA ES UN EQUIPO!
  method estaActivo()
  
  method computo() = self.sumaSobreActivos({ equipo => equipo.computo() })
  
  method capacidadConsumo() = self.sumaSobreActivos(
    { equipo => equipo.capacidadConsumo() }
  )
  
  method equiposActivos() = equipos.filter({ equipo => equipo.estaActivo() })
  
  method sumaSobreActivos(bloque) = self.equiposActivos().sum(bloque)
  
  method maximoSobreActivos(bloque) = self.equiposActivos().max(bloque)
  
  method cantidadEquiposActivos() = self.equiposActivos().size()
  
  method equipoMayorConsumo() = self.maximoSobreActivos(
    { eq, otro => eq.capacidadConsumo() > otro.capacidadConsumo() }
  )
  
  method equipoMayorComputo() = self.maximoSobreActivos(
    { eq, otro => eq.computo() > otro.computo() }
  )
  
  method estaMalConfigurada() = self.equipoMayorConsumo() != self.equipoMayorComputo()
  
  method computar(problema) {
    const fraccionCompl = problema.complejidad() / self.cantidadEquiposActivos()
    self.equiposActivos().forEach({ equipo => equipo.computar(fraccionCompl) })
    complejidadCalculada += problema.complejidad()
  }
}
// ===========================================================================================

// === MODOS
// ===========================================================================================
object standard {
  method consumo(equipo) = equipo.consumoBase()
  
  method computo(equipo) = equipo.computoBase()

  method actualizarEstadoDe(equipo) { } 
}

class Overclock {
  var usosRestantes
  
  method consumo(equipo) = equipo.consumoBase() * 2
  
  method computo(equipo) = equipo.computoBase() + equipo.computoExtraOverclock()
  
  method actualizarEstadoDe(equipo) {
    if (usosRestantes == 0) {
      equipo.estaQuemado(true)
      throw new DomainException(message = "Equipo quemado")
    }
    usosRestantes -= 1
  }
}

class Ahorro {
  method nroMaximoComputos() = 17
  
  method consumo(equipo) = 200
  
  method computo(equipo) = equipo.computoBase() * (self.consumo(
    equipo
  ) / equipo.consumoBase())
  
  method actualizarEstadoDe(equipo) {
    if (equipo.cantidadComputos() == self.nroMaximoComputos())
      equipo.estaQuemado(true)
      throw new DomainException(message = "Equipo quemado")
  }
}

class APruebaDeFallos inherits Ahorro {
  override method nroMaximoComputos() = 100
  
  override method computo(equipo) = super(equipo) * 0.5
}