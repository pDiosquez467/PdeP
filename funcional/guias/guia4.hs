-- === Ejercicio 1

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

-- === Ejercicio 3 

-- | Devuelve, dada una lista de listas,  si la concatenación de las sublistas es una lista capicua.
--
-- === Ejemplos 
--
-- >>> esCapicua ["ne", "uqu", "en"]
-- True 
esCapicua :: (Eq a, Foldable t) => t [a] -> Bool
esCapicua silabas = ((reverse . concat) silabas) == concat silabas 

-- === Ejercicio 4 


-- | Dada una función 'f' y una tupla de horarios con sus registros,
-- devuelve el nombre del horario (como 'String') en el cual la función
-- aplicada a la lista de minutos (o llamadas) es mayor o igual.
--
-- === Ejemplo
--
-- >>> obtenerInfoHorarios suma (("reducido",[10,20]), ("normal",[5,6,8]))
-- "reducido"
obtenerInfoHorarios :: ([Int] -> Int) -> ((String, [Int]), (String, [Int])) -> String
obtenerInfoHorarios f (horario1, horario2)
  | f (snd horario1) >= f (snd horario2) = fst horario1
  | otherwise                            = fst horario2



-- | Devuelve el nombre del horario donde se habló más minutos.
--
-- === Ejemplo
--
-- >>> cuandoHabloMasMinutos (("reducido",[20,10,25,15]),("normal",[10,5,8,2,9,10]))
-- "reducido"
cuandoHabloMasMinutos :: ((String, [Int]), (String, [Int])) -> String
cuandoHabloMasMinutos = obtenerInfoHorarios suma



-- | Devuelve el nombre del horario donde se hicieron más llamadas.
--
-- === Ejemplo
--
-- >>> cuandoHizoMasLlamadas (("reducido",[20,10,25,15]),("normal",[10,5,8,2,9,10]))
-- "normal"
cuandoHizoMasLlamadas :: ((String, [Int]), (String, [Int])) -> String
cuandoHizoMasLlamadas = obtenerInfoHorarios longitud



-- | Devuelve la cantidad de elementos de una lista.
--
-- === Ejemplos
--
-- >>> longitud ["a", "hi!", "Ozzy"]
-- 3
--
-- >>> longitud []
-- 0
longitud :: [a] -> Int
longitud []     = 0
longitud (_:xs) = 1 + longitud xs


-- === Orden superior 

-- | Dados un predicado y una lista de elementos devuelve True si existe algún elemento de la tupla que haga verdadera la función. 
-- 
-- === Ejemplos 
-- 
-- >>> existsAny even [1, 2, 3]
-- True 
--
-- >>> existsAny (>0) [ -1, -9, -12]
-- False
existsAny :: (a -> Bool) -> [a] -> Bool 
existsAny _ [] = False 
existsAny pred (x : xs) = pred x || existsAny pred xs 