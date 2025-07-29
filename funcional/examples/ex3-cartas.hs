-- | Una 'Carta' representa un superhéroe con diversas características numéricas y etiquetas.
--
data Carta = Carta {
    nombre   :: String    -- ^ Nombre del superhéroe
    , tags     :: [String]  -- ^ Etiquetas que describen características (ej. "alien", "volador", etc.)
    , velocidad :: Int      -- ^ Velocidad del superhéroe
    , altura   :: Int       -- ^ Altura del superhéroe (en cm)
    , peso     :: Int       -- ^ Peso del superhéroe (en kg)
    , fuerza   :: Int       -- ^ Nivel de fuerza (entero arbitrario)
    , peleas   :: Int       -- ^ Cantidad de peleas en las que participó
} deriving (Eq, Show)

-- | Devuelve la carta ganadora entre dos, según un criterio numérico dado.
--
--   @ganadoraSegun fuerza carta1 carta2@ devuelve la carta con más fuerza.
ganadoraSegun :: (Carta -> Int) -> Carta -> Carta -> Carta
ganadoraSegun criterio carta1 carta2
  | criterio carta1 > criterio carta2 = carta1
  | otherwise                         = carta2

-- | Extrae el nombre de cada carta.
nombres :: [Carta] -> [String]
nombres = map nombre

-- | Extrae la fuerza de cada carta.
fuerzas :: [Carta] -> [Int]
fuerzas = map fuerza

-- | Devuelve la longitud del nombre de cada carta.
longitudNombres :: [Carta] -> [Int]
longitudNombres = map (length . nombre)

-- | Filtra las cartas que no participaron en ninguna pelea.
nuevos :: [Carta] -> [Carta]
nuevos = filter ((== 0) . peleas)

-- | Filtra las cartas cuyo nombre contiene la letra 'X'.
conX :: [Carta] -> [Carta]
conX = filter (elem 'X' . nombre)

-- | Filtra las cartas cuyo peso es mayor a su altura.
pesadas :: [Carta] -> [Carta]
pesadas = filter (\carta -> peso carta > altura carta)

-- | Verifica si hay al menos una carta sin peleas.
hayNuevos :: [Carta] -> Bool
hayNuevos = any ((== 0) . peleas)

-- | Verifica si todos los nombres contienen la letra 'X'.
todosConX :: [Carta] -> Bool
todosConX = all (elem 'X' . nombre)

-- | Verifica si hay al menos una carta cuyo peso es mayor a su altura.
hayPesadas :: [Carta] -> Bool
hayPesadas = any (\c -> peso c > altura c)

-- | Suma total de peleas de todas las cartas.
peleasTotales :: [Carta] -> Int
peleasTotales = foldr (\carta acum -> peleas carta + acum) 0

-- | Une todos los nombres con punto y coma (;).
--   Ejemplo: "Batman;Superman;Ironman;"
nombresSeparados :: [Carta] -> String
nombresSeparados = foldr (\carta acum -> nombre carta ++ ";" ++ acum) ""

-- | Devuelve la carta con mayor fuerza.
--   Precondición: la lista no debe estar vacía.
masFuerte :: [Carta] -> Carta
masFuerte cartas = foldr (ganadoraSegun fuerza) (head cartas) (tail cartas)
-- Alternativa más segura: usar foldr1 si se garantiza no vacía

-- | Agrega una etiqueta a una carta.
--
-- >>> ponerTag "volador" (Carta "Superman" [] 10 190 90 100 5)
-- Carta {nombre = "Superman", tags = ["volador"], ...}
ponerTag :: String -> Carta -> Carta
ponerTag tag carta = carta {tags = tag : tags carta}

-- | Quita una etiqueta específica de una carta.
quitarTag :: String -> Carta -> Carta
quitarTag tag carta = carta {tags = filter (/= tag) (tags carta)}

-- | Filtra nombres que comienzan con "bat".
batiNombres :: [Carta] -> [String]
batiNombres = filter ((== "bat") . take 3) . map nombre

-- | Verifica si hay al menos una carta con todos sus tags de más de 10 caracteres.
hayCartasConTodosLosTagsMuyLargos :: [Carta] -> Bool
hayCartasConTodosLosTagsMuyLargos = any (all ((> 10) . length) . tags)

-- | Reemplaza el tag "alguien" por "alien" en las cartas que lo tienen.
aliensCorregidos :: [Carta] -> [Carta]
aliensCorregidos = map (ponerTag "alien" . quitarTag "alguien") . filter (elem "alguien" . tags)
