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
