// ======================================================================================= 
// == BARRIOS
// =======================================================================================
class Barrio {
  const niños
  
  method topConMasCaramelos(n) = niños.sortedBy(
    { niño, otro => niño.bolsaDeCaramelos() > otro.bolsaDeCaramelos() }
  ).take(n)
  
  method elementosUsados() = niños.filter(
    { niño => niño.bolsaDeCaramelos() > 10 }
  ).map({ niño => niño.elementosUsados() }).asSet()
}
// ======================================================================================= 

// == NIÑOS
// =======================================================================================
class Niño {
  var property actitud
  const elementosUsados = #{}
  var property bolsaDeCaramelos = 0
  var property estadoDeSalud = sano
  var cantidadCaramelosComidos = 0
  
  override method initialize() {
    if ((actitud < 1) || (actitud > 10)) {
      throw new DomainException(message = "Debe ser 1 <= 'actitud' <= 7")
    }
  }
  
  method capacidadDeSusto() = elementosUsados.sum(
    { el => el.capacidadDeSusto() }
  ) * estadoDeSalud.actitud(self)
  
  method intentarAsustar(adulto) {
    bolsaDeCaramelos += adulto.darCaramelos(self)
  }
  
  method incrementarCaramelos(cantidad) {
    bolsaDeCaramelos += cantidad
  }
  
  method comerCaramelos(cantidad) {
    if (bolsaDeCaramelos < cantidad) {
      throw new DomainException(message = "Caramelos insuficientes en la bolsa")
    }
    bolsaDeCaramelos -= cantidad
    cantidadCaramelosComidos += cantidad
    self.actualizarEstadoDeSalud(cantidad)
  }
  
  method actualizarEstadoDeSalud(cantidad) {
    if (cantidad > 10) {
      estadoDeSalud = estadoDeSalud.estadoSiguiente()
    }
  }
  
  method puedeComerCaramelos() = estadoDeSalud.puedeSeguirComiendo(self)
}
// ======================================================================================= 

// == ESTADO DE SALUD
// =======================================================================================
class EstadoDeSalud {
  method actitud(niño) = niño.actitud()
  
  method puedeSeguirComiendo(niño) = true
  
  method estadoSiguiente() = self
}

object sano inherits EstadoDeSalud {
  override method estadoSiguiente() = empachado
}

object empachado inherits EstadoDeSalud {
  override method actitud(niño) = niño.actitud() / 2
  
  override method estadoSiguiente() = enCama
}

object enCama inherits EstadoDeSalud {
  override method actitud(niño) = 0
  
  override method puedeSeguirComiendo(niño) = false
}
// ======================================================================================= 

// == ELEMENTOS QUE ASUSTAN
// =======================================================================================
class ElementoQueAsusta {
  var property capacidadDeSusto
}

object maquillaje inherits ElementoQueAsusta (capacidadDeSusto = 3) {
  
}

object trajeTierno inherits ElementoQueAsusta (capacidadDeSusto = 3) {
  
}

object trajeTerrorifico inherits ElementoQueAsusta (capacidadDeSusto = 3) {
  
}
// ======================================================================================= 

// == LEGIONES
// =======================================================================================
class Legion {
  const miembros
  
  override method initialize() {
    if (miembros.size() < 2) {
      throw new DomainException(
        message = "Cada legión debe tener al menos dos niños"
      )
    }
  }
  
  method capacidadDeSusto() = miembros.sum(
    { miembro => miembro.capacidadDeSusto() }
  )
  
  method bolsaDeCaramelos() = miembros.sum(
    { miembro => miembro.bolsaDeCaramelos() }
  )
  
  method lider() = miembros.max({ miembro => miembro.capacidadDeSusto() })
  
  method intentarAsustar(adulto) {
    if (adulto.esAsustadoPor(self)) self.lider().incrementarCaramelos(
        adulto.darCaramelos(self)
      )
  }
}
// ======================================================================================= 

// == ADULTOS
// =======================================================================================
class Adulto {
  const asustadoresQueLoIntentaronAntes = #{}
  
  method toleranciaAlSusto() = 10 * asustadoresQueLoIntentaronAntes.size()
  
  method esAsustadoPor(
    asustador
  ) = self.toleranciaAlSusto() < asustador.capacidadDeSusto()
  
  method darCaramelos(asustador) {
    if (self.criterioDeSusto(asustador)) asustadoresQueLoIntentaronAntes.add(
        asustador
      )
    
    if (!self.esAsustadoPor(asustador)) {
      return 0
    }
    return self.cantidadDeCaramelosPorSusto()
  }
  
  method cantidadDeCaramelosPorSusto() = self.toleranciaAlSusto() / 2
  
  method criterioDeSusto(asustador) = asustador.bolsaDeCaramelos() > 15
}

class Anciano inherits Adulto {
  override method darCaramelos(asustador) = super(asustador) / 2
  
  override method esAsustadoPor(asustador) = true
}

object necio inherits Adulto {
  override method esAsustadoPor(asustador) = false
}