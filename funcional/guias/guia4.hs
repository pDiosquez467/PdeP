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


-- | Recibe un número y una lista de enteros, y devuelve True si el número es múltiplo
--   de al menos uno de los elementos de la lista.
--
-- === Ejemplos
--
-- >>> esMultiploDeAlguno 10 [2, 3, 5]
-- True
--
-- >>> esMultiploDeAlguno 7 [2, 4, 6]
-- False
esMultiploDeAlguno :: Int -> [Int] -> Bool 
esMultiploDeAlguno d ns = any ((== 0) . (d `mod`)) ns


-- | Dada una lista de listas de notas, devuelve la lista de promedios correspondientes
--   a cada sublista. El promedio se calcula como la suma de las notas dividida por la cantidad.
--
-- === Ejemplos
--
-- >>> promedios [[8,6], [7,9,4], [6,2,4], [9,6]]
-- [7.0, 6.6666665, 4.0, 7.5]
promedios :: [[Float]] -> [Float]
promedios = map (\notas -> sum notas / fromIntegral (longitud notas))



-- | Dada una lista de listas de notas, elimina los aplazos (notas menores o iguales a 4)
--   de cada sublista antes de calcular los promedios. Devuelve la lista de promedios sin contar los aplazos.
--
-- === Ejemplos
--
-- >>> promedioSinAplazos [[8,6], [7,9,4], [6,2,4], [9,6]]
-- [7.0, 8.0, 6.0, 7.5]
--
-- En el segundo caso, [7,9,4] se transforma en [7,9] antes de calcular el promedio.
-- En el tercero, [6,2,4] se convierte en [6].
promedioSinAplazos :: [[Float]] -> [Float]
promedioSinAplazos = promedios . map (filter (> 4))


-- | Dada la lista de las notas de un alumno devuelve True si el alumno aprobó.
--
-- Se dice que un alumno aprobó si todas sus notas son 6 o más. 
--
-- === Ejemplos
--
-- >>> aprobo [8,6,2,4] 
-- False 
-- >>> aprobo [7,9,6,8] 
-- True 
aprobo :: [Float] -> Bool 
aprobo = all (>6)


-- | Devuelve las notas de los alumnos que aprobaron.
--
-- === Ejemplos
--
-- >>> aprobaron [[8,6,2,4],[7,9,6,7],[6,2,4,2],[9,6,7,10]] 
-- [[7,9,6,7], [9,6,7,10]] 
-- aprobaron :: [[Float]] -> [[Float]]


-- | Devuelve la lista de los divisores del número dado.
--
-- Precondición == El número dado debe ser > 0.
--
-- === Ejemplos
-- 
-- >>> divisores 60
-- [1,2,3,4,5,6,10,12,15,20,30,60]
divisores :: Integral a => a -> [a]
divisores n = filter ((==0) . (n `mod` )) [1 .. n] 


-- | Dada una función booleana y una lista, devuelve 'True' si la función devuelve 'True'
--   para al menos un elemento de la lista.
--
-- === Ejemplos
--
-- >>> exists even [1,3,5]
-- False
--
-- >>> exists even [1,4,7]
-- True
exists :: (a -> Bool) -> [a] -> Bool
exists pred = (> 0) . longitud . filter pred


-- | Dada una lista de números devuelve True si hay algún número negativo. 
--
-- === Ejemplos
--
-- >>> hayAlgunNegativo [2,-3,9] 
-- True
hayAlgunNegativo :: (Num a, Ord a) => [a] -> Bool 
hayAlgunNegativo = exists (<0)


-- | Dadas una lista de funciones y un valor cualquiera, devuelve la lista que resulta de aplicar
--   las funciones al valor.
--
-- === Ejemplos
--
-- >>> aplicarFunciones[(*4),(+3),abs] (-8) 
-- [-32,-5,8] 
aplicarFunciones :: [a -> b] -> a -> [b]
aplicarFunciones fs x = map ($ x) fs  -- ($ x) es una función parcial, que espera una función f y le aplica x.


-- | Dadas una lista de funciones y un número, devuelve la suma del resultado de aplicar las funciones
--   al número. 
--
-- === Ejemplos
--
-- >>> sumaF[(*4),(+3),abs] (-8) 
-- -29 
sumaF :: Num a => [a -> a] -> a -> a 
sumaF fs x = sum (map ($ x) fs)  



-- | Aumenta la habilidad de cada jugador en una cantidad dada, sin que
--   ninguna habilidad final supere el valor máximo de 12.
--
-- Cada elemento de la lista representa la habilidad de un jugador.
-- Si al sumarle el aumento se pasa de 12, se ajusta automáticamente a 12.
--
-- === Ejemplos
--
-- >>> subirHabilidad 2 [3,6,9,10,11,12]
-- [5,8,11,12,12,12]
--
-- >>> subirHabilidad 0 [1,2,3]
-- [1,2,3]
--
-- >>> subirHabilidad 5 [10,11]
-- [12,12]
subirHabilidad :: Int -> [Int] -> [Int]
subirHabilidad x = map (min 12 . (+x))

