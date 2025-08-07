// ==========================================================================================
// === Animales 
// ==========================================================================================

class Vaca {
    const modPeso 
    const modSed
    const modVacunas

    method comer(cantidad) {
        modPeso.aumentarPeso(cantidad / 3)
        modSed.tieneSed(true)
    }

    method beber() {
        modSed.tieneSed(false)
        modPeso.disminuirPeso(0.500)
    }

    method convieneVacunarla() = not modVacunas.estaVacunado()

    method vacunar() {
        modVacunas.vacunar()
    }

    method tieneHambre() = modPeso.peso() < 200

    method caminar() {
        modPeso.disminuirPeso(3)
    }
}

class Cerdo {

    const modPeso 
    const modHambre
    const modSed 
    const modRegistroComidas 

    method comer(cantidad) {
        if (cantidad > 0.200) {
            if (cantidad > 1) modHambre.tieneHambre(false)
            modPeso.aumentarPeso(cantidad)
        }
        modRegistroComidas.registrarComida()
    }

    method tieneSed() = modRegistroComidas.cantidadDeVecesQueComio() > 3 // ?? algo más...
    

    method beber() {
        modSed.tieneSed(false)
        modHambre.tieneHambre(true)
    }

    method convieneVacunarlo() = true 

}

class Gallina {

    const modRegistroComidas

    method peso() = 4

    method tieneHambre() = true

    method tieneSed() = false 

    method convieneVacunarla() = false 

    method comer(cantidad) {
        modRegistroComidas.registrarComida()
    }

    method cantidadVecesQueComio() = modRegistroComidas.cantidadDeVecesQueComio()

}

// ==========================================================================================
// Módulos de comportamiento
// ==========================================================================================

class ModSed {
    var property tieneSed 
}

class ModHambre {
    var property tieneHambre  
}

class ModVacunas {
    var estaVacunado = false 

    method vacunar() {
        estaVacunado = true 
    }
}

class ModPeso {
    var peso 

    method aumentarPeso(delta) {
        peso += delta
    }  

    method disminuirPeso(delta) {
        peso -= delta
    }
}

class ModRegistroComidas {
    var cantidadComidas = 0

    method registrarComida() {
        cantidadComidas += 1
    }

    method cantidadDeVecesQueComio() = cantidadComidas
}


// ==========================================================================================
// DISPOSITIVOS DE ATENCIÓN
// ==========================================================================================

class DispositivoAtencionComida {

    const valorInicial

    var valorActual 

    method disminuirValorActual(delta) {
        valorActual -= delta
    }

    method puedeAtender(animal) = animal.tieneHambre()

    method atender(animal, racion, delta) {
        animal.comer(racion)
        self.disminuirValorActual(delta)
    }

    method necesitaRecargar(criterio) = valorActual.apply(criterio) 

    method recargar() {
        valorActual = valorInicial
    }
}

class DispositivoAtencionBebida {

    var valorActual 

    method incrementarValorActual(delta) {
        valorActual += delta
    }

    method puedeAtender(animal) = animal.tieneSed()

    method atender(animal, racion, delta) {
        animal.beber()
        self.incrementarValorActual(delta)
    }

    method necesitaRecargar(criterio) = valorActual.apply(criterio) 

    method recargar() {
        valorActual = 0
    }
}

class DispositivoAtencionVacunas {

    var valorActual 

    method disminuirValorActual(delta) {
        valorActual += delta
    }

    method puedeAtender(animal) = animal.convieneVacunarlo()

    method atender(animal, racion, delta) {
        animal.vacunar()
        self.disminuirValorActual(delta)
    }

    method necesitaRecargar(criterio) = valorActual.apply(criterio) 

    method recargar() {
        valorActual = 50
    }
}

class Comedero {
    const racion
    const pesoMaximoSop 

    const dispositivoAtencionComida = new DispositivoAtencionComida(valorInicial=30, valorActual=30)

    method puedeAtender(animal) = dispositivoAtencionComida.puedeAtender(animal) && animal.peso() < pesoMaximoSop

    method atender(animal) {
        dispositivoAtencionComida.atender(animal, racion, 1)
    }

    method necesitaRecarga() = dispositivoAtencionComida.necesitaRecarga({ valor => valor < 10 })

    method recargar() {
        dispositivoAtencionComida.recargar()
    }

}

class ComederoInteligente {

    const capacidadMaxComida

    const dispositivoAtencionComida = 
        new DispositivoAtencionComida(valorInicial=capacidadMaxComida, valorActual=capacidadMaxComida)


    method puedeAtender(animal) = dispositivoAtencionComida.puedeAtender(animal)

    method atender(animal) {
        const racion = animal.peso() / 100
        dispositivoAtencionComida.atender(animal, racion, racion)
    }

    method necesitaRecarga() = dispositivoAtencionComida.necesitaRecargar({valor => valor < 15})

    method recargar() {
        dispositivoAtencionComida.recargar()
    }

}

class Bebedero {

    const dispositivoAtencionBebida = 
        new DispositivoAtencionBebida(valorActual=0)


    method puedeAtender(animal) = dispositivoAtencionBebida.puedeAtender(animal)

    method atender(animal) {
        dispositivoAtencionBebida.atender(animal, 1)
    }

    method necesitaRecarga() = dispositivoAtencionBebida.necesitaRecarga({ valor => valor == 20 })

    method recargar() {
        dispositivoAtencionBebida.recargar()
    }

}

class Vacunatorio {

    const dispositivoAtencionVacunas = 
        new DispositivoAtencionVacunas(valorActual=50)

    method puedeAtender(animal) = dispositivoAtencionVacunas.puedeAtender(animal)

    method atender(animal) {
        dispositivoAtencionVacunas.atender(animal, 1)
    }

    method necesitaRecarga() = dispositivoAtencionVacunas.necesitaRecarga({ valor => valor == 0 })

    method recargar() {
        dispositivoAtencionVacunas.recargar()
    }
}
