
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

    method quiereSubir(micro) 
}