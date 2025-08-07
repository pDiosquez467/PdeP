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

class Comedero {
    const racion
    var cantidadRaciones = 30
    const pesoMaximoSop 

    method puedeAtender(animal) = animal.tieneHambre() && animal.peso() < pesoMaximoSop

    method atender(animal) {
        if (self.puedeAtender(animal)) {
            animal.comer(racion)
            cantidadRaciones -= 1
        }
    }

    method necesitaRecarga() = cantidadRaciones < 10

    method recargarRaciones() {
        cantidadRaciones = 30 
    }

}

class ComederoInteligente {

    const capacidadMaximaComida 

    var cantidadComida = capacidadMaximaComida

    method puedeAtender(animal) = animal.tieneHambre()

    method atender(animal) {
        if (self.puedeAtender(animal)) {
            const racion = animal.peso() / 100
            animal.comer(racion)
            cantidadComida -= racion
        }
    }

    method necesitaRecarga() = cantidadComida < 15

    method recargarRaciones() {
        cantidadComida = capacidadMaximaComida
    }

}