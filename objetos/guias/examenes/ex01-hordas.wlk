
class Personaje {

    var property fuerza

    var property inteligencia

    var property  rol   

    method potencialOfensivo() = fuerza * 10 + rol.potencialOfensivo()

    method esGroso() = rol.esGroso(self)
}

class Orco inherits Personaje {

    override method potencialOfensivo() = super() * 1.1

}

class Humano inherits Personaje {

    method esInteligente() = inteligencia > 50
    
}

// ===========================================================================================
// ROLES 
// ===========================================================================================

// Clase abstracta - Funciona como interfaz 
class Rol {
    method potencialOfensivo()

    method esGroso(personaje)
}

class Guerrero {

    method potencialOfensivo() = 100

    method esGroso(personaje) = personaje.fuerza() > 50

}

class Cazador {
    const mascota 

    method potencialOfensivo() = mascota.potencialOfensivo()

    method esGroso(personaje) = mascota.esLongeva()

}

class Brujo {

    method potencialOfensivo() = 0

    method esGroso(personaje) = true 
}

// ===========================================================================================
// ANEXO 
// ===========================================================================================

class Mascota {
    const fuerza 
    const tieneGarras 
    const edad 

    method fuerza() = fuerza

    method tieneGarras() = tieneGarras

    method edad() = edad 

    method potecialOfensivo() = if (self.tieneGarras()) fuerza * 2 else fuerza 

    method esLongeva() = edad > 10

}

// ===========================================================================================
// LOCALIDADES 
// ===========================================================================================

class Localidad {
    const habitantes = []

    method cantidadHabitantes() = habitantes.size()

    method agregarHabitante(personaje) = habitantes.add(personaje)

    method sePuedeAgregarHabitante()

}

class Aldea inherits Localidad {
    const tamaño 

    override method sePuedeAgregarHabitante() = tamaño > self.cantidadHabitantes()
}

class Ciudad inherits Localidad {

    override method sePuedeAgregarHabitante() = true 
}
