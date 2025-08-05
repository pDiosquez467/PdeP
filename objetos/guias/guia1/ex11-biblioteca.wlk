// -----------------------------------------------------------------------------------
// === Clase Libro
// -----------------------------------------------------------------------------------
/*
 * Representa un libro que puede tener una estrategia de préstamo diferente.
 * 
 * Atributos:
 * - capitulos: la cantidad de capítulos del libro (por defecto, 0).
 * - estrategiaDePréstamo: objeto que define cómo calcular el tiempo de préstamo.
 * 
 * Métodos:
 * - tiempoDePréstamo(): devuelve el tiempo que se puede prestar el libro, 
 *   delegando en su estrategia correspondiente.
 */
class Libro {
    var property capitulos = 0
    var property estrategiaDePréstamo
    
    method tiempoDePréstamo() = estrategiaDePréstamo.tiempoDe(self)
}

// -----------------------------------------------------------------------------------
// === Instancias de libros
// -----------------------------------------------------------------------------------
const libroMatematica  = new Libro(capitulos = 10, estrategiaDePréstamo = prestamoStrange)
const libroInformatica = new Libro(estrategiaDePréstamo = prestamoCorto)
const libroFilosofia   = new Libro(estrategiaDePréstamo = prestamoCorto)
const libroEconomia    = new Libro(estrategiaDePréstamo = prestamoStandard)
const libroDerecho     = new Libro(estrategiaDePréstamo = prestamoStandard)


// -----------------------------------------------------------------------------------
// === Estrategias de préstamo
// -----------------------------------------------------------------------------------

/*
 * Estrategia de préstamo estándar: permite 5 días de préstamo.
 */
object prestamoStandard {
    method tiempoDe(libro) = 5
}

/*
 * Estrategia de préstamo corto: permite solo 2 días.
 */
object prestamoCorto {
    method tiempoDe(libro) = 2
}

/*
 * Estrategia especial: si el libro tiene un solo capítulo, permite 1 día;
 * si tiene más de uno, permite 3 días.
 */
object prestamoStrange {
    method tiempoDe(libro) = if (libro.capitulos() == 1) 1 else 3
}
