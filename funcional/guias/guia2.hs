-- | Devuelve el sucesor del número dado.
--
-- === Ejemplos
--
-- >>> siguiente 1
-- 2
--
-- >>> siguiente (-2)
-- -1
siguiente :: Num a => a -> a 
siguiente = (+1)

-- | Devuelve el doble del número dado.
--
-- === Ejemplos
--
-- >>> doble 3
-- 6
--
-- >>> doble (-4)
-- -8
doble :: Num a => a -> a 
doble = (* 2)

-- | Devuelve la mitad del número dado.
--
-- === Ejemplos
--
-- >>> mitad 4
-- 2.0
--
-- >>> mitad 3
-- 1.5
mitad :: Fractional a => a -> a 
mitad = (/ 2)

-- | Devuelve el inverso multiplicativo del número dado.
--
-- === Precondición
-- El número dado debe ser distinto de cero.
--
-- === Ejemplos
--
-- >>> inverso 1
-- 1.0
--
-- >>> inverso 2
-- 0.5
inverso :: Fractional a => a -> a 
inverso = (1 /)

-- | Devuelve el triple del número dado.
--
-- === Ejemplos
--
-- >>> triple 3
-- 9
--
-- >>> triple (-1)
-- -3
triple :: Num a => a -> a 
triple = (* 3)

-- | Indica si un número es estrictamente positivo.
--
-- === Ejemplos
--
-- >>> esNumeroPositivo 3
-- True
--
-- >>> esNumeroPositivo 0
-- False
--
-- >>> esNumeroPositivo (-5)
-- False
esNumeroPositivo :: (Num a, Ord a) => a -> Bool
esNumeroPositivo = (> 0)

-- | Indica si un número es múltiplo de otro.
--
-- === Ejemplos
--
-- >>> esMultiploDe 5 10
-- True
--
-- >>> esMultiploDe 3 7
-- False
esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe divisor = (== 0) . (`mod` divisor)      

-- | Indica si un número es múltiplo de 2.
--
-- === Ejemplos
--
-- >>> esMultiploDe2 4
-- True
--
-- >>> esMultiploDe2 5
-- False
esMultiploDe2 :: Integral a => a -> Bool 
esMultiploDe2 = (esMultiploDe 2)

-- | Indica si un año dado es bisiesto.
--
-- Un año es bisiesto si es divisible por 4, pero no por 100, 
-- a menos que también sea divisible por 400.
--
-- === Ejemplos
--
-- >>> esBisiesto 2020
-- True
--
-- >>> esBisiesto 1900
-- False
--
-- >>> esBisiesto 2000
-- True
esBisiesto :: Integral a => a -> Bool 
esBisiesto anio = esMultiploDe 400 anio || (esMultiploDe 4 anio && not (esMultiploDe 100 anio))


-- | Devuelve el inverso multiplicativo de la raíz cuadrada de un número dado.
--
-- === Precondición
-- El número debe ser estrictamente positivo.
--
-- === Ejemplos
--
-- >>> inversaRaizCuadrada 4
-- 0.5
--
-- >>> inversaRaizCuadrada 1
-- 1.0
inversaRaizCuadrada :: Floating a => a -> a
inversaRaizCuadrada = inverso . sqrt 

-- | Dado un número @n@ y un incremento @m@, devuelve el resultado de 
-- elevar al cuadrado @n@ y luego sumarle @m@.
--
-- === Ejemplos
--
-- >>> incrementMCuadradoN 3 2
-- 11
--
-- >>> incrementMCuadradoN 5 1
-- 26
incrementMCuadradoN :: Num a => a -> a -> a
incrementMCuadradoN m = (+m) . (^2)

-- | Dado un número @n@ y un exponente @m@, indica si el resultado de 
-- elevar @n@ a la potencia @m@ es un número par.
--
-- === Ejemplos
--
-- >>> esResultadoPar 2 5
-- True
--
-- >>> esResultadoPar 3 2
-- False
esResultadoPar :: Int -> Int -> Bool  
esResultadoPar n = esMultiploDe2 . (n^)
