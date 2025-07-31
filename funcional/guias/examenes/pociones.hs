
--------------------
-- === Definiciones 
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