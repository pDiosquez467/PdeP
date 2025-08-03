// Objeto que representa a Pepita, una paloma mensajera"
object pepita {

  var energia = 100
  var lugarActual = lugarA

  // Devuelve la energía actual de Pepita
  method energia() = energia

  // Devuelve el lugar actual en el que se encuentra Pepita
  method lugarActual() = lugarActual

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
  // No valida si puede ir.
  method irA(destino) {
    const distancia = self.lugarActual().distanciaA(destino)
    self.volá(distancia)
    lugarActual = destino
  }
}


object lugarA {
	const kilometro = 0

	method distanciaA(otroLugar) = otroLugar.kilometro() - self.kilometro()

	method kilometro() = kilometro
}

object lugarB {
	const kilometro = 50

	method distanciaA(otroLugar) = otroLugar.kilometro() - self.kilometro()

	method kilometro() = kilometro
}