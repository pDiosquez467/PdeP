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
        felicidad *= (1 - delta)
    }

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
        niño.convertirEnPensamientoCentral(recuerdo)
        niño.disminuirFelicidad(0.1)
        if (niño.felicidad() < 1) {
            throw new DomainException(message = "Felicidad demasiado baja!")
        }
    }
}

class EmocionApatica {

    method asentar(recuerdo) {

    }
}