// ==========================================================================================
// === NIÑO
// ==========================================================================================

class Niño {

    var property felicidad = 1000
    var property emocionDominante
    const property recuerdos = []
    const pensamientosCentrales = #{}
    const procesosMentales = []
    const memoriaALargoPlazo = #{}

    method vivirEvento(descripcion) {
        recuerdos.add(
            new Recuerdo(
                descripcion = descripcion,
                fecha = new Date(),
                emocion = emocionDominante
            )
        )
    }

    method convertirEnPensamientoCentral(recuerdo) {
        pensamientosCentrales.add(recuerdo)
    }

    method disminuirFelicidad(delta) {
        const nuevaFelicidad = felicidad * (1 - delta)
        self.felicidad(nuevaFelicidad)
    }

    method felicidad(nuevaFelicidad) {
        if (nuevaFelicidad < 1) {
            throw new DomainException(message = "Felicidad demasiado baja!")
        }
        felicidad = nuevaFelicidad
    }

    method recuerdosDelDia(n) = recuerdos.reverse().take(n).reverse()

    method pensamientosCentrales() = pensamientosCentrales

    method esPensamientoCentral(recuerdo) = pensamientosCentrales.contains(recuerdo)

    method esRecuerdoDelDia(recuerdo) = self.recuerdosDelDia(5).contains(recuerdo)

    method pensamientosCentralesDificilesDeExplicar() = 
        pensamientosCentrales.filter({ pensamiento => pensamiento.esDificilDeExplicar() })

    method niegaAlgunRecuerdo() = 
        recuerdos.anyOne({ recuerdo => emocionDominante.niegaRecuerdo(recuerdo) })

    method enviarMemoriaALargoPlazo(recuerdo) {
        memoriaALargoPlazo.add(recuerdo)
    }

    method desequilibrar() {
        self.disminuirFelicidad(0.15)
        3.times({ i => 
            self.pensamientosCentrales().remove(self.pesamientoMasAntiguo())
        })
    }

    method pesamientoMasAntiguo() = 
        pensamientosCentrales.min({ recuerdo => recuerdo.fecha() })

    method estaDesequilibradoHormonalmente() = 
        self.pensamientoCentralEnMemoriaLargoPlazo() or
        self.todosLosRecuerdosDelDiaConLaMismaEmocion()

    method pensamientoCentralEnMemoriaLargoPlazo() = 
        memoriaALargoPlazo.any({ pensamiento => self.esPensamientoCentral(pensamiento) })

    method todosLosRecuerdosDelDiaConLaMismaEmocion() {
        const algunRecuerdoDelDia = recuerdos.anyOne()
        return recuerdos.all({ recuerdo => recuerdo.tienenLaMismaEmocion(algunRecuerdoDelDia) })
    }

    method restaurar(valor) {
        const nuevaFelicidad = 1000.min(self.felicidad() + valor)
        self.felicidad(nuevaFelicidad)
    }

    method liberacionRecuerdosDelDia() {
        recuerdos.clear()
    }

    method dormir() {
        procesosMentales.forEach({ proceso => proceso.desencadenarseEn(self) })
    }

}

// ==========================================================================================
// === RECUERDOS
// ==========================================================================================

class Recuerdo {

    const descripcion 
    const property fecha 
    const property emocion

    method asentar(niño) {
        emocion.asentar(niño, self)
    }

    method esDificilDeExplicar() = descripcion.words().size() > 10

    method contieneLaPalabra(palabra) = descripcion.words().contains(palabra)

    method esAlegre() = emocion.esAlegre()

    method esPensamientoCentral(niño) = niño.esPensamientoCentral(self)

    method esRecuerdoDelDia(niño) = niño.esRecuerdoDelDia(self)
    
    method esNegadoPor(otraEmocion) = otraEmocion.niega(self)

    method enviarMemoriaALargoPlazo(niño) {
        niño.enviarMemoriaALargoPlazo(self)
    }

    method tienenLaMismaEmocion(otro) = emocion == otro.emocion()
}


// ==========================================================================================
// === EMOCIONES
// ==========================================================================================

object alegria {

    method asentar(niño, recuerdo) {
        if (niño.felicidad() > 500) {
            niño.convertirEnPensamientoCentral(recuerdo)
        }
    }

    method niegaRecuerdo(recuerdo) = not recuerdo.esAlegre() 

    method esAlegre() = true 
}

object tristeza {

    method asentar(niño, recuerdo) {
        niño.disminuirFelicidad(0.1)
        niño.convertirEnPensamientoCentral(recuerdo)
    }

    method niegaRecuerdo(recuerdo) = recuerdo.esAlegre()

    method esAlegre() = false 
}

class EmocionApatica {

    method asentar(recuerdo) {

    }

    method niegaRecuerdo(recuerdo) = false 

    method esAlegre() = false 
}

// ==========================================================================================
// === PROCESOS MENTALES
// ==========================================================================================

class Asentamiento {
    
    method desencadenarseEn(niño) {
        self.recuerdosAplicados(niño)
            .forEach({ recuerdo => recuerdo.asentar(niño) })
    }

    method recuerdosAplicados(niño) = niño.recuerdos()

}
class AsentamientoSelectivo inherits Asentamiento {
    const palabra

    override method recuerdosAplicados(niño) = niño.recuerdos().filter({
        recuerdo => recuerdo.contieneLaPalabra(palabra)
    })
    
}

object profundizacion {
    
    method desencadenarseEn(niño) {
        niño.recuerdos()
            .filter({ 
                recuerdo => 
                recuerdo.esRecuerdoDelDia(niño) &&
                not recuerdo.esPensamientoCentral(niño) && 
                not recuerdo.esNegadoPor(niño.emocionDominante())
            })
            .forEach({ recuerdo => recuerdo.enviarMemoriaALargoPlazo(niño) })
    }
}

object restauracionCognitiva {
    
    method desencadenarseEn(niño) {
        niño.restaurar(100)
    }
}

object controlHormonal {

    method desencadenarseEn(niño) {
        if (niño.estaDesequilibradoHormonalmente()) {
            niño.desequilibrar()
        }
    }
}

object liberacionRecuerdosDelDia {
    
    method desencadenarseEn(niño) {
        niño.liberacionRecuerdosDelDia()
    }
}