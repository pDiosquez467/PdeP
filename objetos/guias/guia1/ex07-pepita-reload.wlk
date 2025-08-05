// --------------------------------------------------------------------------------------------
// === AVES
// --------------------------------------------------------------------------------------------

// Objeto que representa a Pepita, una paloma mensajera
object pepita {

  var energia = 100
  var lugarActual = lugarA
  var property entrenador = susana

  // Devuelve la energía actual de Pepita
  method energia() = energia

  // Devuelve el lugar actual en el que se encuentra Pepita
  method lugarActual() = lugarActual

  // Indica si Pepita está débil.
  method estáDébil() = energia < 50 

  // Indica si Pepita está eufórica.  
  method estáEufórica() = energia > 500 && energia.even()

  // Indica si Pepita aún puede volar.  
  method puedeVolar() = energia > 0

  // Pepita vuela cierta distancia y consume la energía correspondiente
  method volá(kilometros) {
    energia = energia - self.energiaNecesariaPara(kilometros)
  }

  // Devuelve cuánta energía necesita para volar una cantidad de kilómetros
  method energiaNecesariaPara(km) = km + 10

  // Pepita come una cierta cantidad de gramos y gana energía
  method comé(gramos) {
    energia = energia + gramos * 4
  }

  // Indica si Pepita tiene energía suficiente para ir a un lugar dado
  method puedeIrA(destino) = 
    energia >= self.energiaNecesariaPara(self.lugarActual().distanciaA(destino))

  // Hace que Pepita vaya hacia un lugar si tiene suficiente energía.
  // Cambia el lugar actual, y consume energía al volar.
  method irA(destino) {
    if (self.puedeIrA(destino)) {
        const distancia = self.lugarActual().distanciaA(destino)
        self.volá(distancia)
        lugarActual = destino
    }
  }

    // Hace que Pepita se comporte como quiera según su estado de ánimo.
    method cumplíTuDeseo() {
        if (self.estáDébil()) {
            self.comé(500)
        } else if (self.estáEufórica()) {
            self.volá(5)
        }
    }

    // Hace que Pepita se entrene según las reglas de su entrenador actual.
    method entrenate() {
        entrenador.entrenáA(self)
    }
}

object pepón {
    var energía = 100
    var property entrenador = roque

    method energía() = energía

    method volá(kilometros) {
        energía = energía - kilometros * 2
    }

    method comé(gramos) {
        energía = energía + gramos * 3 - 20
    }

    method cumplíTuDeseo() {
        self.comé(100)
    }

    method entrenate() {
        entrenador.entrenáA(self)
    }


}

// --------------------------------------------------------------------------------------------
// === LUGARES
// --------------------------------------------------------------------------------------------

class Lugar {
    const kilometro = 0

    method distanciaA(otroLugar) = otroLugar.kilometro() - self.kilometro()

	method kilometro() = kilometro
}

const lugarA = new Lugar()

const lugarB = new Lugar(kilometro = 50)

// --------------------------------------------------------------------------------------------
// === ENTRENADORES
// --------------------------------------------------------------------------------------------

object susana {

    method entrenáA(ave) {
        ave.volá(3)
        ave.cumplíTuDeseo()
    }
}

object roque {

    method entrenáA(ave) {
        ave.volá(5)
        ave.comé(500)
        ave.volá(3)
    }
}