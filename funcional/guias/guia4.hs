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

-- | Dados un predicado y una lista, devuelve True si existe al menos un elemento 
-- | que cumple con el predicado.
--
-- === Ejemplos
--
-- >>> existsAny even [1, 2, 3]
-- True
--
-- >>> existsAny (>0) [-1, -9, -12]
-- False
existsAny :: (a -> Bool) -> [a] -> Bool 
existsAny _ [] = False 
existsAny pred (x : xs) = pred x || existsAny pred xs 


-- | Recibe dos funciones y un valor, y devuelve el mayor de los resultados de aplicar 
-- ambas funciones al valor dado.
--
-- === Ejemplos
--
-- >>> mejor cuadrado triple 1
-- 3
--
-- >>> mejor cuadrado triple 5
-- 25
--
-- Donde:
-- cuadrado x = x * x
-- triple x = 3 * x
mejor :: Ord a => (t -> a) -> (t -> a) -> t -> a
mejor f g x = max (f x) (g x)


-- | Recibe una función y una lista, y devuelve una nueva lista donde cada elemento 
-- es el resultado de aplicar la función a cada elemento de la lista original.
--
-- === Ejemplos
--
-- >>> aplicar (*2) [1,2,3]
-- [2,4,6]
aplicar :: (a -> b) -> [a] -> [b]
aplicar _ [] = [] 
aplicar f (x:xs) = f x : aplicar f xs 


-- | Recibe dos funciones y una lista, y devuelve una lista de pares. 
-- Cada par contiene el resultado de aplicar ambas funciones al mismo elemento.
--
-- === Ejemplos
--
-- >>> parDeFns even (*2) [12, 3]
-- [(True,24),(False,6)]
parDeFns :: (a -> b) -> (a -> c) -> [a] -> [(b, c)]
parDeFns _ _ [] = []
parDeFns f g (x : xs) = (f x, g x) : parDeFns f g xs 
