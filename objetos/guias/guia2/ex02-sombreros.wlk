
class JuegoSombreros {

    var monto 

    var nroPartidasTotales = 0

    var nroPartidasGanadas = 0

    var apuestaMaxima      = 0

    method monto() = monto

    method nroPartidasGanadas() = nroPartidasGanadas

    method nroPartidasPerdidas() = nroPartidasTotales - nroPartidasGanadas 

    method apuestaMaxima() = apuestaMaxima

    method nroSombreroGanador() = 0.randomUpTo(3).truncate(0)

    method actualizarApuestaMaxima(apuesta) {
        if (apuesta > apuestaMaxima) {
            apuestaMaxima = apuesta 
        }
    }

    method apostar(apuesta, nroSombrero) {
        self.actualizarApuestaMaxima(apuesta)

        nroPartidasTotales += 1
        if (nroSombrero == self.nroSombreroGanador()) {
            monto -= apuesta * 2 
            return apuesta * 2
        }
        nroPartidasGanadas += 1
        monto += apuesta 
        return 0 
    }    
}