
type Barrio = String
type Mail = String
type Requisito = Depto -> Bool
type Busqueda = [Requisito]

data Depto = Depto {
 ambientes :: Int,
 superficie :: Float,
 precio :: Float,
 barrio :: Barrio
} deriving (Show, Eq)

data Persona = Persona {
   mail :: Mail,
   busquedas :: [Busqueda]
}

-------------------
-- === CÓDIGO BASE
-------------------

ordenarSegun :: (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) =
 (ordenarSegun criterio . filter (not . criterio x)) xs ++
 [x] ++
 (ordenarSegun criterio . filter (criterio x)) xs


between :: Ord a => a -> a -> a -> Bool 
between cotaInferior cotaSuperior valor =
 valor <= cotaSuperior && valor >= cotaInferior

-----------------------
-- === DATOS DE EJEMPLO
-----------------------

deptosDeEjemplo = [
 Depto 3 80 7500 "Palermo",
 Depto 1 45 3500 "Villa Urquiza",
 Depto 2 50 5000 "Palermo",
 Depto 1 45 5500 "Recoleta"]

------------------
-- === EJERCICIOS
------------------

-- === 1.
mayor :: Ord b => (a -> b) -> (a -> a -> Bool) 
mayor f x y = f x > f y  

menor :: Ord b => (a -> b) -> (a -> a -> Bool) 
menor f x y = f x < f y

-- ordenarSegunPrecio = ordenarSegun (\ d1 d2 -> mayor precio d1 d2) 

-- | Recibe una lista de strings y devuelve una nueva lista ordenada de mayor a menor según longitud.
ordenarSegunLongitud :: [String] -> [String]
ordenarSegunLongitud = ordenarSegun (mayor length) 

-- === 2.

-- | Dada una lista de barrios, retorne verdadero si el departamento se encuentra en alguno
--   de los barrios de la lista.
ubicadoEn :: [Barrio] -> Requisito
ubicadoEn barrios = (`elem` barrios) . barrio 

ubicadoEn' :: [Barrio] -> Requisito
ubicadoEn' barrios = flip elem barrios . barrio 

-- | Dada una función y dos números, indica si el valor retornado por la función al ser aplicada
--   con el departamento se encuentra entre los dos valores indicados.
cumpleRango :: Ord a => (Depto -> a) -> a -> a -> Requisito
cumpleRango f cotaInferior cotaSuperior = between cotaInferior cotaSuperior . f 


-- === 3.

-- | Indica si todos los requisitos de una búsqueda se verifican para un departamento dado.
cumpleBusqueda :: Depto -> (Busqueda -> Bool) 
cumpleBusqueda depto = all (\ requisito -> requisito depto) 

cumpleBusqueda' :: Depto -> (Busqueda -> Bool) 
cumpleBusqueda' depto = all ($ depto) 


-- | Definir la función buscar que a partir de una búsqueda, un criterio de ordenamiento y una 
--   lista de departamentos retorne todos aquellos que cumplen con la búsqueda ordenados en base al criterio recibido.
buscar :: Busqueda -> (Depto -> Depto -> Bool) -> ([Depto] -> [Depto])
buscar busqueda criterio = ordenarSegun criterio . filter (`cumpleBusqueda` busqueda)

buscar' :: Busqueda -> (Depto -> Depto -> Bool) -> ([Depto] -> [Depto])
buscar' busqueda criterio = ordenarSegun criterio . filter (flip cumpleBusqueda busqueda)

buscarEjemplo = 
   buscar [ubicadoEn ["Palermo", "Recoleta"], cumpleRango ambientes 1 2, cumpleRango precio 0 6000] (mayor superficie) deptosDeEjemplo

-- === Ejercicio 4 

-- | Dados un departamento y una lista de personas devuelve los mails de las personas que tienen alguna
--   búsqueda que se cumpla para el departamento dado.
mailsDePersonasInteresadas :: Depto -> ([Persona] -> [Mail])
mailsDePersonasInteresadas depto = map mail . filter (any (cumpleBusqueda depto) . busquedas)
