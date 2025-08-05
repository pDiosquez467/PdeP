
class Micro {
    const cantidadSentados 

    const cantidadParados 

    const pasajerosActuales = [] 

    method cantidadActual() = pasajerosActuales.size()

    method limitePasajeros() = cantidadSentados + cantidadParados

    method hayLugar() = self.cantidadActual() <= self.limitePasajeros()

    method estaVacio() = pasajerosActuales.isEmpty()

    method puedeSubir(persona) = self.hayLugar() && persona.quiereSubirse(self) 

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
            // El pasajero debe saber que bajó...
            pasajero.bajar(self)
            pasajerosActuales.remove(pasajero)
        } else {
            self.error('Error: Micro vacío')
        } 
    }

}

class Persona {

}