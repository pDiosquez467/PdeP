
class AnimalDeGranja {
    var peso 

    var tieneSed  

    var property estaVacunado 

    method peso() = peso

    method tieneSed() = tieneSed

    method tieneHambre()

    method comer(cantidad) 

    method beber()  

    method convieneVacunarlo() = true 
}

class Vaca inherits AnimalDeGranja {
    
    override method comer(cantidad) {
        peso += cantidad / 3
        tieneSed = true 
    }

    override method beber() {
        tieneSed = false 
        peso -= 0.500 
    }

    override method tieneHambre() = peso < 200 

    override method convieneVacunarlo() = not self.estaVacunado()

    method caminar() {
        peso -= 3 
    }
}