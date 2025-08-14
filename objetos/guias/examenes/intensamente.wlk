// ==========================================================================================
// === NIÑO
// ==========================================================================================

class Niño {

    var property felicidad = 1000
    var property emocionDominante
    const recuerdos = []
    const pensamientosCentrales = #{}

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

    method recuerdosRecientes(n) = recuerdos.reverse().take(n).reverse()

    method pensamientosCentrales() = pensamientosCentrales

    method pensamientosCentralesDificilesDeExplicar() = 
        pensamientosCentrales.filter({ pensamiento => pensamiento.esDificilDeExplicar() })

    

}

// ==========================================================================================
// === RECUERDOS
// ==========================================================================================

class Recuerdo {

    const descripcion 
    const fecha 
    const emocion

    method asentar(niño) {
        emocion.asentar(niño, self)
    }

    method esDificilDeExplicar() = descripcion.words().size() > 10
    
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
}

object tristeza {

    method asentar(niño, recuerdo) {
        niño.disminuirFelicidad(0.1)
        niño.convertirEnPensamientoCentral(recuerdo)
    }
}

class EmocionApatica {

    method asentar(recuerdo) {

    }
}