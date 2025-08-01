--------------------
-- === Estructuras 
--------------------

-- | Representa a una persona con un nombre y tres niveles: suerte, inteligencia y fuerza.
data Persona = Persona {
  nombrePersona :: String,      -- ^ Nombre de la persona
  suerte :: Int,                -- ^ Nivel de suerte
  inteligencia :: Int,          -- ^ Nivel de inteligencia
  fuerza :: Int                 -- ^ Nivel de fuerza
} deriving (Show, Eq)

-- | Representa una poción mágica, con un nombre y una lista de ingredientes.
data Pocion = Pocion {
  nombrePocion :: String,       -- ^ Nombre de la poción
  ingredientes :: [Ingrediente] -- ^ Ingredientes que la componen
}

-- | Un efecto es una transformación sobre una persona.
type Efecto = Persona -> Persona

-- | Representa un ingrediente con un nombre y una lista de efectos que produce.
data Ingrediente = Ingrediente {
  nombreIngrediente :: String,  -- ^ Nombre del ingrediente
  efectos :: [Efecto]           -- ^ Efectos que aplica al ser consumido
}

----------------
-- === Ejemplos
----------------

-- | Lista de nombres de ingredientes prohibidos.
nombresDeIngredientesProhibidos :: [String]
nombresDeIngredientesProhibidos = [
  "sangre de unicornio",
  "veneno de basilisco",
  "patas de cabra",
  "efedrina"
  ]

------------------
-- === Código Base 
------------------

-- | Devuelve el elemento máximo de una lista según un criterio dado.
--   La lista debe tener al menos un elemento.
maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun _ [ x ] = x
maximoSegun f (x:y:xs)
  | f x > f y  = maximoSegun f (x:xs)
  | otherwise  = maximoSegun f (y:xs)

-----------------
-- === Ejercicios 
-----------------

-- | Devuelve los niveles de una persona como lista: [suerte, inteligencia, fuerza].
niveles :: Persona -> [Int]
niveles persona = [suerte persona, inteligencia persona, fuerza persona]

-- | Suma todos los niveles de una persona.
sumaDeNiveles :: Persona -> Int 
sumaDeNiveles = sum . niveles

-- | Devuelve la diferencia entre el mayor y el menor nivel de una persona.
diferenciaDeNiveles :: Persona -> Int 
diferenciaDeNiveles persona = maximoNivel persona - minimoNivel persona

-- | Devuelve el nivel máximo de una persona.
maximoNivel :: Persona -> Int 
maximoNivel = maximum . niveles

-- | Devuelve el nivel mínimo de una persona.
minimoNivel :: Persona -> Int 
minimoNivel = minimum . niveles

-- | Devuelve la cantidad de niveles de una persona que son mayores a un valor dado.
nivelesMayoresA :: Int -> (Persona -> Int) 
nivelesMayoresA valor = length . filter (>valor) . niveles

-- | Devuelve la lista de efectos de una poción, combinando los efectos de todos sus ingredientes.
efectosDePocion :: Pocion -> [Efecto]
efectosDePocion = concat . map efectos . ingredientes 

-- | Devuelve los nombres de las pociones hardcore, que son aquellas con al menos 4 efectos.
pocionesHardcore :: [Pocion] -> [String]
pocionesHardcore = map nombrePocion . filter ((>=4) . length . efectosDePocion)

-- | Devuelve la cantidad de pociones prohibidas, aquellas que contienen ingredientes prohibidos.
cantidadPocionesProhibidas :: [Pocion] -> Int 
cantidadPocionesProhibidas = length . filter esProhibida

-- | Indica si una poción contiene al menos un ingrediente prohibido.
esProhibida :: Pocion -> Bool
esProhibida = any ((`elem` nombresDeIngredientesProhibidos) . nombreIngrediente) . ingredientes

-- | Indica si todas las pociones de la lista contienen al menos un ingrediente llamado “azúcar”.
todasDulces :: [Pocion] -> Bool 
todasDulces = all (any ((== "azúcar") . nombreIngrediente) . ingredientes)

-- | Aplica los efectos de una poción en orden a una persona, devolviendo el resultado final.
tomarPocion :: Pocion -> Persona -> Persona
tomarPocion pocion persona = 
  (foldl (\persona efecto -> efecto persona) persona . efectosDePocion) pocion

-- | Indica si una poción actúa como antídoto de otra para una persona dada, 
--   es decir, si deshace sus efectos.
esAntidotoDe :: Pocion -> Pocion -> Persona -> Bool 
esAntidotoDe pocion antidoto persona = 
  ((== persona) . tomarPocion antidoto . tomarPocion pocion) persona 

-- | Dada una poción, una función cuantificadora y una lista de personas,
--   devuelve la persona más afectada (la que maximiza el valor del cuantificador tras tomar la poción).
--   
--   Ejemplo de uso:
--   > personaMasAfectada pocion sumaDeNiveles [persona1, persona2, persona3]
personaMasAfectada :: Pocion -> (Persona -> Int) -> ([Persona] -> Persona)
personaMasAfectada pocion criterio = maximoSegun (criterio . tomarPocion pocion)
