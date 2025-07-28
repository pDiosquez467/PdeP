-- === Ejercicio 1 

-- | Devuelve el primer elemento de una tupla de tres componentes.
--
-- === Ejemplos
--
-- >>> fst3 (1, 'a', True)
-- 1
fst3 :: (a, b, c) -> a 
fst3 (x, _, _) = x 


-- | Devuelve el segundo elemento de una tupla de tres componentes.
--
-- === Ejemplos
--
-- >>> snd3 (1, 'a', True)
-- 'a'
snd3 :: (a, b, c) -> b 
snd3 (_, x, _) = x 


-- | Devuelve el tercer elemento de una tupla de tres componentes.
--
-- === Ejemplos
--
-- >>> trd3 (1, 'a', True)
-- True
trd3 :: (a, b, c) -> c 
trd3 (_, _, x) = x 

-- === Ejercicio 2 

-- | Devuelve una tupla con el resultado de aplicar dos funciones distintas al mismo valor.
--
-- === Ejemplos
--
-- >>> aplicar (doble, triple) 8
-- (16, 24)
--
-- >>> aplicar ((3+), (2*)) 8
-- (11, 16)
aplicar :: (a -> b, a -> c) -> a -> (b, c)
aplicar (f, g) x = (f x, g x)


-- === Ejercicio 3

-- | Devuelve un número a partir de una tupla de dos enteros, de acuerdo a estas reglas:
-- 
-- - Si el primer número es mayor que el segundo, devuelve la suma.
-- - Si el segundo número excede al primero por más de 10, devuelve la resta.
-- - En cualquier otro caso, devuelve el producto.
--
-- === Ejemplos
--
-- >>> cuentaBizarra (10, 5)
-- 15
--
-- >>> cuentaBizarra (5, 20)
-- 15
--
-- >>> cuentaBizarra (4, 10)
-- 40
cuentaBizarra :: (Integral a) => (a, a) -> a
cuentaBizarra (num1, num2)
                        | num1 > num2      = num1 + num2
                        | num2 - num1 > 10 = num2 - num1
                        | otherwise        = num1 * num2

-- === Ejercicio 4 

-- | Tipo sinónimo para representar notas, que son números enteros.
type Nota = Int 


-- | Indica si una nota es un bochazo (menor a 6).
--
-- === Ejemplos
--
-- >>> esNotaBochazo 4
-- True
--
-- >>> esNotaBochazo 6
-- False
esNotaBochazo :: Nota -> Bool 
esNotaBochazo = (<6)


-- | Indica si un estudiante aprobó ambos parciales.
--
-- Un estudiante aprueba si ninguna de las dos notas es bochazo.
--
-- === Ejemplos
--
-- >>> aprobo (6, 7)
-- True
--
-- >>> aprobo (4, 8)
-- False
aprobo :: (Nota, Nota) -> Bool
aprobo (nota1, nota2) = not (esNotaBochazo nota1) && not (esNotaBochazo nota2) 


-- | Indica si un estudiante promocionó la materia.
--
-- Se promociona si la suma de ambas notas es mayor a 15, y ambas son al menos 7.
--
-- === Ejemplos
--
-- >>> promociono (8, 8)
-- True
--
-- >>> promociono (7, 6)
-- False
promociono :: (Nota, Nota) -> Bool
promociono (nota1, nota2) = nota1 + nota2 > 15 && nota1 >= 7 && nota2 >= 7


-- | Indica si se aprobó el primer parcial.
--
-- === Ejemplos
--
-- >>> aproboPrimerParcial (6, 3)
-- True
--
-- >>> aproboPrimerParcial (4, 8)
-- False
aproboPrimerParcial :: (Nota, Nota) -> Bool
aproboPrimerParcial = not . esNotaBochazo . fst


-- Ejercicio 5 


-- | Calcula las notas finales de un alumno tomando el máximo entre el parcial y el recuperatorio.
--
--   Si no rindió el recuperatorio, se usa el valor del parcial.
--
--  === Ejemplo
-- >>> notasFinales ((2,7),(6,-1)) 
-- (6,7)
notasFinales :: ((Nota, Nota), (Nota, Nota)) -> (Nota, Nota)
notasFinales ((parcial1, parcial2), (recup1, recup2)) = (max parcial1 recup1, max parcial2 recup2)


-- | Determina si un alumno recursa, dado el par de parciales y recuperatorios.
--
--   Recursa si no aprueba con sus notas finales.
recursa :: ((Nota, Nota), (Nota, Nota)) -> Bool
recursa = (not . aprobo . notasFinales)


-- | Determina si un alumno recuperó el primer parcial.
--
--   Se considera que lo recuperó si no aprobaba el primer parcial y sí aprueba la nota final del primero.
recuperoPrimerParcial :: ((Nota, Nota), (Nota, Nota)) -> Bool
recuperoPrimerParcial = rindio . fst . snd


-- | Indica si un alumno rindió al menos uno de los recuperatorios.
--
--   Devuelve True si alguno de los recuperatorios es distinto de -1.
rindioAlMenosUnRecup :: ((Nota, Nota), (Nota, Nota)) -> Bool
rindioAlMenosUnRecup = \examenes -> (rindio . fst . snd) examenes || (rindio . snd . snd) examenes

-- | Determina si un alumno, pudiendo promocionar con los parciales, rindió al menos un recuperatorio.
--
--   Es decir, si promocionaba pero aún así se presentó a algún recuperatorio.
recuperoDeGusto :: ((Nota, Nota), (Nota, Nota)) -> Bool
recuperoDeGusto examenes = promociono (notasFinales examenes) && rindioAlMenosUnRecup examenes

-- | Determina si una nota representa que se rindió (es decir, si es distinta de -1).
rindio :: Nota -> Bool
rindio = (/= -1)


-- === Ejercicio 6 

type Nombre = String 
type Edad = Int


-- | Indica si la persona dada es mayor de edad.
--
-- Una persona es mayor de edad si tiene más de 21 años.
--
-- === Ejemplos
--
-- >>> esMayorDeEdad ("Lio", 37)
-- True
--
-- >>> esMayorDeEdad ("Tommi", 16)
-- False  
esMayorDeEdad :: (Nombre, Edad) -> Bool
esMayorDeEdad = (>=21) . snd  


-- === Ejercicio 7 

-- | Duplica el número si es par, si no lo deja igual.
--
-- >>> duplicarSiEsPar 4
-- 8
-- >>> duplicarSiEsPar 3
-- 3
duplicarSiEsPar :: Int -> Int
duplicarSiEsPar n | even n    = 2 * n
                  | otherwise = n


-- | Suma 1 si el número es impar, si no lo deja igual.
--
-- >>> sumarUnoSiEsImpar 5
-- 6
-- >>> sumarUnoSiEsImpar 8
-- 8
sumarUnoSiEsImpar :: Int -> Int
sumarUnoSiEsImpar n | odd n     = n + 1
                    | otherwise = n


-- | Dada una tupla de dos enteros, aplica:
-- - al primero: duplicarlo si es par,
-- - al segundo: sumarle 1 si es impar.
--
-- Usa aplicación parcial y composición con `aplicar`.
--
-- === Ejemplos
-- >>> calcular (4, 5)
-- (8, 6)
--
-- >>> calcular (3, 7)
-- (3, 8)
calcular :: (Int, Int) -> (Int, Int)
calcular = aplicar (duplicarSiEsPar . fst , sumarUnoSiEsImpar . snd)