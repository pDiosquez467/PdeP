// --------------------------------------------------------------------------------------------
// === AVES
// --------------------------------------------------------------------------------------------

object pepita {

  var energia = 100
  var lugarActual = lugarA
  var property entrenador = susana

  method energia() = energia

  method lugarActual() = lugarActual

  method estáDébil() = energia < 50 

  method estáEufórica() = energia > 500 && energia.even()

  method puedeVolar(kilometros) = energia >= self.energiaNecesariaParaVolar(kilometros)

  method energiaNecesariaParaVolar(km) = km + 10

  // Pepita vuela cierta distancia y consume la energía correspondiente.
  // Solo vuela si tiene la energía suficiente. En caso contrario, no hace nada.
  method volá(kilometros) {
    if (self.puedeVolar(kilometros)) {
        energia = energia - self.energiaNecesariaParaVolar(kilometros)
    }
  }

  // Pepita come una cierta cantidad de gramos y gana energía.
  method comé(gramos) {
    energia = energia + gramos * 4
  }

  // Hace que Pepita vaya hacia un lugar si tiene suficiente energía.
  // Cambia el lugar actual, y consume energía al volar la distancia correspondiente.
  method irA(destino) {
    const distancia = self.lugarActual().distanciaA(destino)
    if (self.puedeVolar(distancia)) {
        self.volá(distancia)
        lugarActual = destino
    }
  }

  // Hace que Pepita actúe según su estado de ánimo.
  // Si está débil, come 500g. Si está eufórica, vuela 5km (sin cambiar de lugar).
  method cumplíTuDeseo() {
    if (self.estáDébil()) self.comé(500)
    else if (self.estáEufórica()) self.volá(5)
  }

  // Entrena a Pepita utilizando el entrenador asignado.
  method entrenate() {
    entrenador.entrenáA(self)
  }
}

object pepón {
  var energia = 100
  var property entrenador = roque

  method energia() = energia

  method energiaNecesariaParaVolar(kilometros) = kilometros * 2

  method puedeVolar(kilometros) = energia >= self.energiaNecesariaParaVolar(kilometros)  

  // Pepón vuela una distancia si tiene la energía suficiente.
  // Consume 2 joules por kilómetro (sin costo fijo).
  method volá(kilometros) {
    if (self.puedeVolar(kilometros)) {
        energia = energia - self.energiaNecesariaParaVolar(kilometros)
    }
  }

  // Pepón gana energía al comer, con un costo fijo de 20 joules por digestión.
  method comé(gramos) {
    energia = energia + gramos * 3 - 20
  }

  // El deseo de Pepón es siempre comer 100 gramos.
  method cumplíTuDeseo() {
    self.comé(100)
  }

  // Entrena a Pepón utilizando el entrenador asignado.
  method entrenate() {
    entrenador.entrenáA(self)
  }
}

// --------------------------------------------------------------------------------------------
// === LUGARES
// --------------------------------------------------------------------------------------------

class Lugar {
  const kilometro = 0

  // Calcula la distancia entre dos lugares, siempre como valor absoluto.
  method distanciaA(otroLugar) = (otroLugar.kilometro() - self.kilometro()).abs()

  method kilometro() = kilometro
}

const lugarA = new Lugar()
const lugarB = new Lugar(kilometro = 50)

// --------------------------------------------------------------------------------------------
// === ENTRENADORES
// --------------------------------------------------------------------------------------------

object susana {

  // La rutina de Susana es: volar 3 km y luego cumplir el deseo del ave.
  method entrenáA(ave) {
    ave.volá(3)
    ave.cumplíTuDeseo()
  }
}

object roque {

  // La rutina de Roque es: volar 5 km, comer 500 gramos y volar otros 3 km.
  method entrenáA(ave) {
    ave.volá(5)
    ave.comé(500)
    ave.volá(3)
  }
}
