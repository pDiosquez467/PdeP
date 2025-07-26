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
