// ===========================================================================================
// === PERSONAJES
// ===========================================================================================
class Personaje {
  const property fuerza
  const property inteligencia
  var property rol
  
  method potencialOfensivo() = (fuerza * 10) + rol.potencialOfensivo()
  
  method esInteligente()
  
  method esGroso() = self.esInteligente() || rol.esGroso(self)
}

class Orco inherits Personaje {
  override method potencialOfensivo() = super() * 1.1
  
  override method esInteligente() = false
}

class Humano inherits Personaje {
  override method esInteligente() = inteligencia > 50
}
// ===========================================================================================

// === ROLES 
// ===========================================================================================
object guerrero {
  method potencialOfensivo() = 100
  
  method esGroso(personaje) = personaje.fuerza() > 50
}

class Cazador {
  const mascota
  
  method potencialOfensivo() = mascota.potencialOfensivo()
  
  method esGroso(personaje) = mascota.esLongeva()
}

object brujo {
  method potencialOfensivo() = 0
  
  method esGroso(personaje) = true
}
// ===========================================================================================

// === MASCOTA 
// ===========================================================================================
class Mascota {
  const fuerza
  const tieneGarras
  const edad
  
  method potecialOfensivo() = if (tieneGarras) fuerza * 2 else fuerza
  
  method esLongeva() = edad > 10
}
// ===========================================================================================

// === LOCALIDADES 
// ===========================================================================================
class Localidad {
  var habitantes
  
  method potencialDefensivo() = habitantes.potencialOfensivo()
  
  method esOcupadaPor(ejercito) {
    habitantes = ejercito
  }
}

class Aldea inherits Localidad {
  const maximaCantHabitantes = 50
  
  override method esOcupadaPor(ejercito) {
    if (ejercito.cantidadSoldados() > maximaCantHabitantes) {
      const nuevoEjercito = ejercito.miembrosConMayorPotencialOfensivo()
      ejercito.removerSoldados(nuevoEjercito)
      super(new Ejercito(soldados = nuevoEjercito))
    }
  }
}

class Ciudad inherits Localidad {
  override method potencialDefensivo() = super() + 300
}
// ===========================================================================================

// EJÉRCITO
// ===========================================================================================
class Ejercito {
  const soldados
  
  method cantidadSoldados() = soldados.size()
  
  method potencialOfensivo() = soldados.sum(
    { soldado => soldado.potencialOfensivo() }
  )
  
  method removerSoldados(removidos) {
    soldados.removeAll(removidos)
  }
  
  method invadirLocalidad(localidad) {
    if (localidad.potencialDefensivo() < self.potencialOfensivo())
      localidad.esOcupadaPor(self)
  }
  
  method miembrosConMayorPotencialOfensivo() = soldados.sortedBy(
    { s1, s2 => s2.potencialOfensivo() - s1.potencialOfensivo() }
  ).take(10)
}