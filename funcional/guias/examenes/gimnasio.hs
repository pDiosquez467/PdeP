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
-- 1. Modelar a los Gimnastas y las operaciones necesarias para hacerlos ganar tonificación y
-- quemar calorías considerando que por cada 500 calorías quemadas se baja 1 kg de peso.

-- | Aumenta la tonificación de un gimnasta en una cantidad dada.
-- 
-- Recibe:
--   - delta: cantidad de tonificación a agregar.
--   - gimnasta: el gimnasta a modificar.
--
-- Devuelve:
--   - Un nuevo gimnasta con la tonificación incrementada en delta.
tonificar :: Int -> (Gimnasta -> Gimnasta)
tonificar delta gimnasta = gimnasta { tonificacion = tonificacion gimnasta + delta }

-- | Reduce el peso de un gimnasta según las calorías quemadas.
-- 
-- Por cada 500 calorías quemadas, se pierde 1 kg de peso.
--
-- Recibe:
--   - cal: cantidad de calorías a quemar.
--   - gimnasta: el gimnasta a modificar.
--
-- Devuelve:
--   - Un nuevo gimnasta con el peso ajustado según las calorías.
quemarCalorias :: Calorias -> Gimnasta -> Gimnasta
quemarCalorias cal gimnasta = gimnasta { peso = peso gimnasta - cal `div` 500 }


-- 2. Modelar los siguientes ejercicios del gimnasio:

    -- La cinta es una de las máquinas más populares entre los socios que quieren perder peso. Los
    -- gimnastas simplemente corren sobre la cinta y queman calorías en función de la velocidad 
    -- promedio alcanzada (quemando 10 calorías por la velocidad promedio por minuto).
    -- La cinta puede utilizarse para realizar dos ejercicios diferentes:

    -- a. La caminata es un ejercicio en cinta con velocidad constante de 5 km/h.

    -- b. El pique arranca en 20 km/h y cada minuto incrementa la velocidad en 1 km/h, con lo cual la
    -- velocidad promedio depende de los minutos de entrenamiento.

    -- Las pesas son el equipo preferido de los que no quieren perder peso, sino ganar musculatura.
    -- Una sesión de levantamiento de pesas de más de 10 minutos hace que el gimnasta gane una 
    -- tonificación equivalente a los kilos levantados. Por otro lado, una sesión de menos de 
    -- 10 minutos es demasiado corta, y no causa ningún efecto en el gimnasta.

    -- La colina es un ejercicio que consiste en ascender y descender sobre una superficie inclinada
    -- y quema 2 calorías por minuto multiplicado por la inclinación con la que se haya montado la
    -- superficie.

    -- Los gimnastas más experimentados suelen preferir otra versión de este ejercicio: la montaña,
    -- que consiste en 2 colinas sucesivas (asignando a cada una la mitad del tiempo total), donde
    -- la segunda colina se configura con una inclinación de 5 grados más que la inclinación de la
    -- primera. Además de la pérdida de peso por las calorías quemadas en las colinas, la montaña
    -- incrementa en 3 unidades la tonificación del gimnasta.

-- | Modela un ejercicio en cinta con una velocidad determinada.
-- 
-- Quema 10 calorías por minuto por cada km/h de velocidad.
--
-- Recibe:
--   - velocidad: velocidad constante del ejercicio.
--   - tiempo: duración del ejercicio en minutos.
--
-- Devuelve:
--   - Una función que modifica al gimnasta según las calorías quemadas.
cinta :: Velocidad -> Ejercicio
cinta velocidad tiempo = quemarCalorias (10 * velocidad * tiempo) 

-- | Ejercicio de caminata en cinta a velocidad constante de 5 km/h.
--
-- Equivale a aplicar `cinta` con velocidad 5.
caminata :: Ejercicio
caminata = cinta 5  

-- | Ejercicio de pique en cinta que arranca a 20 km/h y sube 1 km/h por minuto.
-- 
-- La velocidad promedio se calcula en base al tiempo de duración.
pique :: Ejercicio
pique tiempo = cinta ((20 + tiempo) `div` tiempo) tiempo


-- | Ejercicio de pesas que aumenta tonificación si dura más de 10 minutos.
--
-- Recibe:
--   - peso: peso levantado.
--   - tiempo: duración del ejercicio.
--
-- Devuelve:
--   - El gimnasta modificado solo si el ejercicio dura más de 10 minutos.
pesas :: Peso -> Ejercicio
pesas peso tiempo | tiempo < 10 = id  
                  | otherwise   = tonificar peso 

-- | Ejercicio de colina que quema calorías según el tiempo y la inclinación.
-- 
-- Fórmula: 2 calorías por minuto por grado de inclinación.
colina :: Grados -> Ejercicio
colina inclinacion tiempo = quemarCalorias (2 * tiempo * inclinacion) 

-- | Ejercicio de montaña: dos colinas seguidas y ganancia de tonificación.
--
-- Divide el tiempo en dos mitades:
--   - Primera colina con inclinación original.
--   - Segunda colina con 5 grados más.
--   - Además, suma 3 puntos de tonificación.
montaña :: Grados -> Ejercicio
montaña inclinacion tiempo = 
    let tiempoAsignado = tiempo `div` 2
    in tonificar 3 . colina (inclinacion + 5) tiempoAsignado . colina inclinacion tiempoAsignado


-- 3. Implementar una función realizarRutina, que dada una rutina y un gimnasta retorna el 
-- gimnasta resultante de realizar todos los ejercicios de la rutina, repartiendo el tiempo
-- total de la rutina en partes iguales.

-- | Aplica todos los ejercicios de una rutina a un gimnasta.
--
-- Divide el tiempo total de la rutina en partes iguales para cada ejercicio.
--
-- Recibe:
--   - gimnastaInit: estado inicial del gimnasta.
--   - rutina: la rutina a realizar.
--
-- Devuelve:
--   - El gimnasta resultante luego de realizar la rutina completa.
realizarRutina :: Gimnasta -> Rutina -> Gimnasta
realizarRutina gimnastaInit rutina =  
    foldl (\ gimnasta ejercicio -> ejercicio (tiempoEjercicio rutina) gimnasta) gimnastaInit (ejercicios rutina)

-- | Calcula la duración por ejercicio de una rutina.
--
-- Se asume que el tiempo total se reparte equitativamente.
tiempoEjercicio :: Rutina -> Tiempo
tiempoEjercicio rutina = duracionTotal rutina `div` length (ejercicios rutina)


-- 4. Definir las operaciones necesarias para hacer las siguientes consultas a partir de una lista de rutinas:
    -- a. ¿Qué cantidad de ejercicios tiene la rutina con más ejercicios?
    -- b. ¿Cuáles son los nombres de las rutinas que hacen que un gimnasta dado gane tonificación?
    -- c. ¿Hay alguna rutina peligrosa para cierto gimnasta? Decimos que una rutina es peligrosa para alguien si lo hace perder más de la mitad de su peso.

-- | Devuelve la mayor cantidad de ejercicios en una lista de rutinas.
--
-- Útil para encontrar la rutina más extensa.
mayorCantidadDeEjercicios :: [Rutina] -> Int
mayorCantidadDeEjercicios = maximum . map (length . ejercicios)

-- | Indica si una rutina mejora la tonificación de un gimnasta.
--
-- Recibe:
--   - gimnasta: estado inicial del gimnasta.
--   - rutina: rutina a evaluar.
--
-- Devuelve:
--   - True si la tonificación final es mayor que la inicial.
aumentaTonificacion :: Gimnasta -> (Rutina -> Bool) 
aumentaTonificacion gimnasta = (> (tonificacion gimnasta)) . tonificacion . realizarRutina gimnasta

-- | Devuelve los nombres de las rutinas que aumentan la tonificación de un gimnasta.
--
-- Se filtran solo las rutinas que producen ese efecto.
nombresRutinasHardCore :: Gimnasta -> ([Rutina] -> [String])
nombresRutinasHardCore gimnasta = map nombreRutina . filter (aumentaTonificacion gimnasta) 

-- | Indica si una rutina es peligrosa para un gimnasta.
--
-- Una rutina se considera peligrosa si el gimnasta pierde más de la mitad de su peso.
esPeligrosaPara :: Gimnasta -> (Rutina -> Bool)
esPeligrosaPara gimnasta = (< peso gimnasta `div` 2) . peso . realizarRutina gimnasta

-- | Indica si hay al menos una rutina peligrosa para un gimnasta en una lista.
hayAlgunaPeligrosa :: Gimnasta -> ([Rutina] -> Bool) 
hayAlgunaPeligrosa gimnasta = any (esPeligrosaPara gimnasta)