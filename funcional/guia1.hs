-- | Devuelve 'True' si el número dado es divisible por 3, y 'False' en caso contrario.
-- 
-- === Ejemplos
--
-- >>> esMultiploDeTres 9
-- True
--
-- >>> esMultiploDeTres 10
-- False
esMultiploDeTres :: Integer -> Bool
esMultiploDeTres x = x `mod` 3 == 0


-- | Devuelve 'True' si el segundo número es múltiplo del primero, y 'False' en caso contrario.
--
-- El primer parámetro representa el divisor, y el segundo, el número que se evalúa.
--
-- === Ejemplos
--
-- >>> esMultiploDe 2 16
-- True
--
-- >>> esMultiploDe 5 16
-- False
esMultiploDe :: Integer -> Integer -> Bool 
esMultiploDe divisor numero = numero `mod` divisor == 0


-- | Devuelve el cubo del número dado.
-- 
-- === Ejemplo
--
-- >>> cubo 2
-- 8
--
cubo :: Num a => a -> a 
cubo x = x * x * x 


-- | Devuelve el área de un rectángulo dada su base y su altura.
-- | PRE: Los números dados deben ser >= 0. 
-- 
-- === Ejemplo
--
-- >>> area 3 5
-- 15
--
-- >>> area 1.2 4.2
-- 5.04
--
area :: Num a => a -> a -> a 
area base altura = base * altura


-- | Indica si el año dado es bisiesto.  
-- 
-- === Ejemplo
--
-- >>> esBisiesto 2000
-- True 
--
-- >>> esBisiesto 2025
-- False 
--
esBisiesto :: Integer -> Bool 
esBisiesto anio = esMultiploDe 400 anio ||
                 (esMultiploDe 4 anio && not (esMultiploDe 100 anio))


-- | Convierte una temperatura en grados Celsius a grados Fahrenheit.
-- 
-- === Ejemplos
--
-- >>> celsiusToFahr 0
-- 32.0
--
-- >>> celsiusToFahr 100
-- 212.0
celsiusToFahr :: Fractional a => a -> a 
celsiusToFahr c = c * (9 / 5) + 32


-- | Convierte una temperatura en grados Fahrenheit a grados Celsius.
-- 
-- === Ejemplos
--
-- >>> fahrToCelsius 32
-- 0.0
--
-- >>> fahrToCelsius 98
-- 36.666668
fahrToCelsius :: Fractional a => a -> a
fahrToCelsius f = (f - 32) * (5 / 9)