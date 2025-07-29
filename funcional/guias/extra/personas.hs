
data Persona = Persona {
  nombre :: String,
  edad :: Int,
  ciudad :: String
} deriving (Show, Eq)

-- === Ejercicio 1
-- Dado una lista de personas, obtener una lista con los nombres de aquellas cuya edad
-- es mayor o igual a 18 años.

nombresDeMayores :: [Persona] -> [String]
nombresDeMayores = map nombre . filter (\p -> edad p >= 18)
 

-- === Ejercicio 3
-- Definir una función que reciba una lista de personas y una cantidad, y devuelva una 
-- nueva lista donde se haya incrementado esa cantidad a la edad de cada persona.

aumentarEdad :: Int -> Persona -> Persona
aumentarEdad delta persona = persona {edad = edad persona + delta}

nuevasEdades :: Int -> [Persona] -> [Persona]
nuevasEdades delta = map (aumentarEdad delta)

-- === Ejercicio 4 
-- Definir una función que reciba una lista de personas y una función booleana sobre 
-- personas (por ejemplo: (\p -> ciudad p == "Rosario" && edad p < 30)) y devuelva solo
-- las personas que la satisfacen.

-- Esto es simplemente -> cumplenQue personas cond = flip filter
-- Pero a más bajo nivel...

-- | Devuelve la sublista de personas que cumplen con un predicado dado.
cumplenQue :: [Persona] -> (Persona -> Bool) -> [Persona]
cumplenQue [] _ = []
cumplenQue (p:ps) cond | cond p    = p : cumplenQue ps cond
                       | otherwise = cumplenQue ps cond

-- === Ejercicio 6
-- Definir una función que devuelva la persona de mayor edad en una lista (suponiendo que hay
-- al menos una).

-- | Devuelve la persona de mayor edad de una lista (no vacía).
masVieja :: [Persona] -> Persona
masVieja personas = foldr1 mayorEntre personas

mayorEntre :: Persona -> Persona -> Persona
mayorEntre p1 p2 | edad p1 > edad p2 = p1 
                 | otherwise         = p2 


-- === Ejercicio 7 
-- Definir una función que devuelva un único String con los nombres de todas las personas cuya 
-- edad esté en un rango dado (por ejemplo, entre 20 y 40), separados por comas.

personasFiltradasPorEdad :: [Persona] -> Int -> Int -> String  
personasFiltradasPorEdad personas desde hasta = 
        foldr (\ p acum -> nombre p ++ "," ++ acum) "" (filter (\ p -> edad p >= desde && edad p <= hasta) personas)


-- === Ejercicio 9 
-- Dada una lista de personas, calcular una tupla con:
-- el promedio de edades, la edad mínima, la edad máxima.
-- (Suponer lista no vacía).
--

infoEdades :: [Persona] -> (Float, Int, Int)
infoEdades personas =
  let edades = map edad personas
      total = sum edades
      len = length edades
  in (fromIntegral total / fromIntegral len, minimum edades, maximum edades)
