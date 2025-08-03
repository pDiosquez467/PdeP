---------------------
-- === Tipos de datos
---------------------

type Peso = Int 
type Tiempo = Int 
type Grados = Int 
type Velocidad = Int 
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

type Ejercicio = Tiempo -> (Gimnasta -> Gimnasta)

-----------------
-- === Ejercicios 
-----------------
-- 1.
tonificar :: Int -> (Gimnasta -> Gimnasta)
tonificar delta gimnasta = gimnasta { tonificacion = tonificacion gimnasta + delta }

quemarCalorias :: Calorias -> Gimnasta -> Gimnasta
quemarCalorias cal gimnasta = gimnasta { peso = peso gimnasta - cal `div` 500 }

-- 2.

cinta :: Velocidad -> Ejercicio
cinta velocidad tiempo = quemarCalorias (10 * velocidad * tiempo) 

caminata :: Ejercicio
caminata = cinta 5  

pique :: Ejercicio
pique tiempo = cinta ((20 + tiempo) `div` tiempo) tiempo

pesas :: Peso -> Ejercicio
pesas peso tiempo | tiempo < 10 = id  
                  | otherwise   = tonificar peso 

colina :: Grados -> Ejercicio
colina inclinacion tiempo = quemarCalorias (2 * tiempo * inclinacion) 

montaña :: Grados -> Ejercicio
montaña inclinacion tiempo = 
    let tiempoAsignado = tiempo `div` 2
    in tonificar 3 . colina (inclinacion + 5) tiempoAsignado . colina inclinacion tiempoAsignado

-- 3. Implementar una función realizarRutina, que dada una rutina y un gimnasta retorna el 
-- gimnasta resultante de realizar todos los ejercicios de la rutina, repartiendo el tiempo
-- total de la rutina en partes iguales. Mostrar un ejemplo de uso con una rutina que incluya
-- todos los ejercicios del punto anterior.

realizarRutina :: Rutina -> (Gimnasta -> Gimnasta)
realizarRutina rutina gimnasta =  
    foldr (\ ejercicio gimnasta -> ejercicio (duracionTotal rutina `div` length (ejercicios rutina)) gimnasta ) gimnasta (ejercicios rutina)