// ===========================================================================================
// === PERSONAJES
// ===========================================================================================

class Personaje {

    const property fuerza

    const property inteligencia

    var property  rol   

    method potencialOfensivo() = fuerza * 10 + rol.potencialOfensivo()

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
// LOCALIDADES 
// ===========================================================================================

class Localidad {
    const habitantes

    const ejercitoDefensor = habitantes 

    method cantidadHabitantes() = habitantes.size()

    method agregarHabitante(personaje) = habitantes.add(personaje)

    method sePuedeAgregarHabitante()

    method potencialOfensivoTotal() = ejercitoDefensor.potencialOfensivoTotal()

}

class Aldea inherits Localidad {
    const tamaño 

    override method sePuedeAgregarHabitante() = tamaño > self.cantidadHabitantes()
}

class Ciudad inherits Localidad {

    override method sePuedeAgregarHabitante() = true 

    override method potencialOfensivoTotal() = super() + 300
}

// ===========================================================================================
// EJÉRCITO
// ===========================================================================================

class Ejercito {

    const soldados

    method potencialOfensivoTotal() = 
        soldados.filter({ soldado => soldado.potencialOfensivo() }).sum()

    method miembrosConMayorPotencialOfensivo() = 
        soldados
            .sortBy({ s1, s2 => s1.potecialOfensivo() > s2.potecialOfensivo() })
            .take(10)
}