-- Ejercicio 1

-- | Devuelve la suma de los elementos de la lista.
--
-- === Ejemplos 
--
-- >>> suma [1 .. 100]
-- 5050
--
-- >>> suma [-1, 4, 0]
-- 3
suma :: Num a => [a] -> a
suma [] = 0
suma (x : xs) = x + suma xs 

-- Ejercicio 3 

-- | Devuelve, dada una lista de listas,  si la concatenación de las sublistas es una lista capicua.
--
-- === Ejemplos 
--
-- >>> esCapicua ["ne", "uqu", "en"]
-- True 
esCapicua :: (Eq a, Foldable t) => t [a] -> Bool
esCapicua silabas = ((reverse . concat) silabas) == concat silabas 