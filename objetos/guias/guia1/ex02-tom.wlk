// Representa al gato Tom, cuya energía y velocidad dependen de sus actividades físicas
object tom {
  var energia = 100

  // Devuelve la energía actual de Tom en joules
  method energia() = energia

  // Calcula la velocidad actual de Tom en m/s. Aumenta con la energía
  method velocidad() = 5 + (energia / 10)

  // Tom come un ratón y gana energía según su peso
  method coméRaton(unRaton) {
    energia += self.energiaObtenidaAlComer(unRaton)
  }

  // Tom corre durante cierto tiempo en segundos.
  // La distancia se calcula usando su velocidad actual.
  // Luego pierde energía en base a la distancia recorrida.
  method corré(tiempoEnSegundos) {
    const distancia = self.velocidad() * tiempoEnSegundos
    energia -= self.energiaConsumidaAlCorrer(distancia)
  }

  // Calcula la energía que Tom pierde por correr una cierta distancia en metros"
  method energiaConsumidaAlCorrer(distanciaEnMetros) = 0.5 * distanciaEnMetros

  // Calcula la energía que Tom gana al comer un ratón (12 + peso del ratón)"
  method energiaObtenidaAlComer(unRaton) = 12 + unRaton.peso()

  // Indica si le conviene comer al ratón, es decir, si gana más energía que la que gastaría
  // corriendo cierta distancia para alcanzarlo
  method meConvieneComerRatonA(unRaton, distanciaEnMetros) =
    self.energiaObtenidaAlComer(unRaton) > self.energiaConsumidaAlCorrer(distanciaEnMetros)
}

// Representa un ratón liviano de 100 gramos.
object unRaton {
  const peso = 100
  method peso() = peso
}

// Representa un ratón pesado de 300 gramos.
object otroRaton {
  const peso = 300
  method peso() = peso
}
