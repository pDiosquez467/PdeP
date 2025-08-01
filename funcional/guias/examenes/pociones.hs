
--------------------
-- === Estructuras 
--------------------

data Persona = Persona {
  nombrePersona :: String,
  suerte :: Int,
  inteligencia :: Int,
  fuerza :: Int
} deriving (Show, Eq)

data Pocion = Pocion {
  nombrePocion :: String,
  ingredientes :: [Ingrediente]
}

type Efecto = Persona -> Persona

data Ingrediente = Ingrediente {
  nombreIngrediente :: String,
  efectos :: [Efecto]
}

----------------
-- === Ejemplos
----------------

nombresDeIngredientesProhibidos = [
 "sangre de unicornio",
 "veneno de basilisco",
 "patas de cabra",
 "efedrina"]

------------------
-- === Código Base 
------------------

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun _ [ x ] = x
maximoSegun  f ( x : y : xs)
  | f x > f y = maximoSegun f (x:xs)
  | otherwise = maximoSegun f (y:xs)

-----------------
-- === Ejercicios 
-----------------

-- 1. Dada una persona definir las siguientes funciones para cuantificar sus niveles de suerte, 
-- inteligencia y fuerza sin repetir código:
--    sumaDeNiveles que suma todos sus niveles.
--    diferenciaDeNiveles es la diferencia entre el nivel más alto y más bajo.
--    nivelesMayoresA n, que indica la cantidad de niveles de la persona que están por encima
--    del valor dado.

niveles :: Persona -> [Int]
niveles persona = [suerte persona, inteligencia persona, fuerza persona]

sumaDeNiveles :: Persona -> Int 
sumaDeNiveles = sum . niveles

diferenciaDeNiveles :: Persona -> Int 
diferenciaDeNiveles persona = maximoNivel persona - minimoNivel persona

maximoNivel :: Persona -> Int 
maximoNivel = maximum . niveles

minimoNivel :: Persona -> Int 
minimoNivel = minimum . niveles

nivelesMayoresA :: Int -> (Persona -> Int) 
nivelesMayoresA valor = length . filter (>valor ) . niveles

-- 2. Definir la función efectosDePocion que dada una poción devuelve una lista con los efectos
-- de todos sus ingredientes.

efectosDePocion :: Pocion -> [Efecto]
efectosDePocion = concat . map efectos . ingredientes 

-- 3. Dada una lista de pociones, consultar:
  -- a. Los nombres de las pociones hardcore, que son las que tienen al menos 4 efectos.

  -- b. La cantidad de pociones prohibidas, que son aquellas que tienen algún ingrediente cuyo
  --    nombre figura en la lista de ingredientes prohibidos.

  -- c. Si son todas dulces, lo cual ocurre cuando todas las pociones de la lista tienen algún
  --   ingrediente llamado “azúcar”.

-- a .
pocionesHardcore :: [Pocion] -> [String]
pocionesHardcore  = map nombrePocion . filter ((>=4) . length . efectosDePocion)


-- b.
cantidadPocionesProhibidas :: [Pocion] -> Int 
cantidadPocionesProhibidas = length . filter esProhibida

esProhibida :: Pocion -> Bool
esProhibida = any (( `elem` nombresDeIngredientesProhibidos) . nombreIngrediente) . ingredientes

-- c.
todasDulces :: [Pocion] -> Bool 
todasDulces = all (any ((== "azúcar") . nombreIngrediente) . ingredientes) 


-- 4. Definir la función tomarPocion que recibe una poción y una persona, y devuelve como quedaría
-- la persona después de tomar la poción. Cuando una persona toma una poción, se aplican todos los
-- efectos de esta última, en orden.

tomarPocion :: Pocion -> Persona -> Persona
tomarPocion pocion persona = 
  (foldl (\ persona efecto -> efecto persona) persona . efectosDePocion) pocion

-- 5. Definir la función esAntidotoDe que recibe dos pociones y una persona, y dice si tomar la 
-- segunda poción revierte los cambios que se producen en la persona al tomar la primera.

esAntidotoDe :: Pocion -> Pocion -> Persona -> Bool 
esAntidotoDe pocion antidoto persona = ((== persona) . tomarPocion antidoto . tomarPocion pocion) persona 