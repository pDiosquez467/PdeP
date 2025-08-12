// ======================================================================================= 
// == NIÑOS
// =======================================================================================

object niños {
  
    const niños = []

    method niñosConMuchosCaramelos() = 
        niños
        .sortBy({ niño, otro => niño.bolsaDeCaramelos() > otro.bolsaDeCaramelos() })
        .take(3)

    method elementosUsados() = 
        niños
        .filter({ niño => niño.bolsaDeCaramelos() > 10 })
        .map({ niño => niño.elementosUsados() })
        .asSet()

}

class Niño {
    var property actitud 
    const elementosUsados
    var property bolsaDeCaramelos = 0 
    var property estadoDeSalud = sano 
    var cantidadCaramelosComidos = 0

    method capacidadDeAsustar() =
         elementosUsados.sum({ el => el.susto() }) * estadoDeSalud.actitud(self)

    method asustar(adulto) {
      bolsaDeCaramelos += adulto.darCaramelosA(self)
    }

    method agregarCaramelos(cantidad) {
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
        if (cantidad > 10) estadoDeSalud = estadoDeSalud.estadoSiguiente()
    }

    method puedeComerCaramelos() = estadoDeSalud.puedeSeguirComiendo(self)

}

// ======================================================================================= 
// == ESTADO DE SALUD
// =======================================================================================

object sano {

    method actitud(niño) = niño.actitud()  

    method puedeSeguirComiendo(niño) = true

    method estadoSiguiente() = empachado
}

object empachado {

    method actitud(niño) = niño.actitud() / 2 

    method puedeSeguirComiendo(niño) = true

    method estadoSiguiente() = enCama
}

object enCama {
    method actitud(niño) = 0

    method puedeSeguirComiendo(niño) = false 

    method estadoSiguiente() = self
}


// ======================================================================================= 
// == ELEMENTOS QUE ASUSTAN
// =======================================================================================

object maquillaje {
  
    method susto() = 3
}

object trajeTierno {

    method susto() = 2
}

object trajeTerrorifico  {

    method susto() = 5
}

// ======================================================================================= 
// == ADULTOS
// =======================================================================================

class Adulto {

    method toleranciaAlSusto() = 100

    method esAsustadoPor(niño)

    method darCaramelos(niño)

}

class AdultoComun inherits Adulto {

    var property cantidadDeNiñosAntes

    override method toleranciaAlSusto() = 10 * cantidadDeNiñosAntes

    override method esAsustadoPor(niño) = self.toleranciaAlSusto() > niño.capacidadDeAsustar()

    override method darCaramelos(niño) {
        if (self.esAsustadoPor(niño)) {
            throw new DomainException(message = "El niño no pudo asustar al adulto!")
        }

        if (niño.bolsaDeCaramelos() > 15) {
            cantidadDeNiñosAntes += 1
        }

        niño.agregarCaramelos(self.toleranciaAlSusto() / 2)
    }
}

class Anciano inherits Adulto {

    override method esAsustadoPor(niño) = true 

    override method toleranciaAlSusto() = super() / 2

}

class AdultoNecio inherits Adulto {

    override method esAsustadoPor(niño) = false

}

// ======================================================================================= 
// == LEGIONES
// =======================================================================================

class Legion {

    const miembros 

    override method initialize() {
        if (miembros.size() < 2) {
            throw new DomainException(message = "Cada legión debe tener al menos dos niños")
        }
    }

    method capacidadDeAsustar() = miembros.sum({ miembro => miembro.capacidadDeAsustar() })

    method cantidadDeCaramelos() = miembros.sum({ miembro => miembro.bolsaDeCaramelos() })

    method lider() = miembros.max({ miembro => miembro.capacidadDeAsustar() })

    method asustar(adulto) {
        if (adulto.esAsustadoPor(self)) {
            adulto.darCaramelos(self.lider())
        }
    }

}