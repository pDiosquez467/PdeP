
class Micro {
    const limiteSentados 

    const limiteParados 

    const volumen

    const pasajerosActuales = [] 

    method cantidadActual() = pasajerosActuales.size()

    method limitePasajeros() = limiteSentados + limiteParados

    method volumen() = volumen

    method hayLugar() = self.cantidadActual() <= self.limitePasajeros()

    method hayAsientoLibre() = self.cantidadActual() < limiteSentados

    method estaVacio() = pasajerosActuales.isEmpty()

    method quedanXLugaresLibres(x) = (self.limitePasajeros() - self.cantidadActual()) > x  

    method puedeSubir(persona) = self.hayLugar() && persona.quiereSubir(self) 

    method subir(persona) {
        if (self.puedeSubir(persona)) {
            pasajerosActuales.add(persona)
        } else {
            self.error('Error: No se pudo subir a esta persona')
        }
    }

    method bajarPersona() {
        if (not self.estaVacio()) {
            const pasajero = pasajerosActuales.anyOne()
            pasajerosActuales.remove(pasajero)
        } else {
            self.error('Error: Micro vacío')
        } 
    }

}

class Persona {

    var property jefe

    method quiereSubir(micro) = true
}

class Apurado inherits Persona { }

class Claustrofobico {
    override method quiereSubir(micro) = micro.volumen() > 120 
}

class Fiaca {
    override method quiereSubir(micro) = micro.hayAsientoLibre()
}

class Moderado {
    var x

    override method quiereSubir(micro) = micro.quedanXLugaresLibres(x)
}

class Obsecuente {
    
    override method quiereSubir(micro) = self.jefe().quiereSubir(micro)
}
