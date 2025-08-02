---------------------
-- === Tipos de datos
---------------------

type Peso = Int 
type Tiempo = Int 
type Grados = Int 
type Calorias = Int 

data Gimnasta = Gimnasta {
    peso :: Peso, 
    tonificacion :: Int 
} deriving (Eq, Show)


data Rutina = Rutina {
    nombreRutina :: String,
    duracionTotal :: Int,
    ejercicios :: [Ejercicio]
}

type Ejercicio = Gimnasta -> Gimnasta

-----------------
-- === Ejercicios 
-----------------
-- 1.
tonificar :: Int -> (Gimnasta -> Gimnasta)
tonificar delta gimnasta = gimnasta { tonificacion = tonificacion gimnasta + delta }

quemarCalorias :: Calorias -> Gimnasta -> Gimnasta
quemarCalorias cal gimnasta = gimnasta { peso = peso gimnasta - cal `div` 500 }
