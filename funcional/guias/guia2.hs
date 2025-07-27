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
-- >>> esMultiploDe 10 5
-- True
--
-- >>> esMultiploDe 7 3
-- False
esMultiploDe :: Int -> Int -> Bool 
esMultiploDe n divisor = ((== 0) . (`mod` divisor)) n 

-- | Indica si un número es múltiplo de 2.
--
-- === Ejemplos
--
-- >>> esMultiploDe2 4
-- True
--
-- >>> esMultiploDe2 5
-- False
esMultiploDe2 :: Int -> Bool 
esMultiploDe2 = (`esMultiploDe` 2)

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
esBisiesto :: Int -> Bool 
esBisiesto anio =
  (anio `esMultiploDe` 400)
  || ((anio `esMultiploDe` 4) && not (anio `esMultiploDe` 100))
