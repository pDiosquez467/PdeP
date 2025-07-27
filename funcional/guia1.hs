-- | Devuelve 'True' si el número dado es divisible por 3, y 'False' en caso contrario.
-- 
-- === Ejemplos
--
-- >>> esMultiploDeTres 9
-- True
--
-- >>> esMultiploDeTres 10
-- False
esMultiploDeTres :: Integer -> Bool
esMultiploDeTres x = x `mod` 3 == 0


-- | Devuelve 'True' si el segundo número es múltiplo del primero, y 'False' en caso contrario.
--
-- El primer parámetro representa el divisor, y el segundo, el número que se evalúa.
--
-- === Ejemplos
--
-- >>> esMultiploDe 2 16
-- True
--
-- >>> esMultiploDe 5 16
-- False
esMultiploDe :: Integer -> Integer -> Bool 
esMultiploDe divisor numero = numero `mod` divisor == 0


-- | Devuelve el cubo del número dado.
-- 
-- === Ejemplo
--
-- >>> cubo 2
-- 8
--
cubo :: Num a => a -> a 
cubo x = x * x * x 


-- | Devuelve el área de un rectángulo dada su base y su altura.
--
-- Precondición == Los números dados deben ser >= 0. 
-- 
-- === Ejemplo
--
-- >>> area 3 5
-- 15
--
-- >>> area 1.2 4.2
-- 5.04
--
area :: Num a => a -> a -> a 
area base altura = base * altura


-- | Indica si el año dado es bisiesto.  
-- 
-- === Ejemplo
--
-- >>> esBisiesto 2000
-- True 
--
-- >>> esBisiesto 2025
-- False 
--
esBisiesto :: Integer -> Bool 
esBisiesto anio = esMultiploDe 400 anio ||
                 (esMultiploDe 4 anio && not (esMultiploDe 100 anio))


-- | Convierte una temperatura en grados Celsius a grados Fahrenheit.
-- 
-- === Ejemplos
--
-- >>> celsiusToFahr 0
-- 32.0
--
-- >>> celsiusToFahr 100
-- 212.0
celsiusToFahr :: Fractional a => a -> a 
celsiusToFahr c = c * (9 / 5) + 32


-- | Convierte una temperatura en grados Fahrenheit a grados Celsius.
-- 
-- === Ejemplos
--
-- >>> fahrToCelsius 32
-- 0.0
--
-- >>> fahrToCelsius 98
-- 36.666668
fahrToCelsius :: Fractional a => a -> a
fahrToCelsius f = (f - 32) * (5 / 9)


-- | Indica si una temperatura expresada en grados Fahrenheit es fría.
-- 
-- Se considera que una temperatura es fría si es menor a 8 grados Celsius.
--
-- === Ejemplos
--
-- >>> haceFrio 100
-- False
--
-- >>> haceFrio 0
-- True
haceFrio :: (Fractional a, Ord a) => a -> Bool 
haceFrio gradosFah = fahrToCelsius gradosFah < 8


-- | Devuelve el mínimo común múltiplo entre dos números dados.
-- 
-- Precondición == Requiere que ambos números sean mayores que 0.
--
-- === Ejemplos
--
-- >>> mcm 12 3
-- 12
--
-- >>> mcm 4 5
-- 20
mcm :: Integer -> Integer -> Integer
mcm numero otroNumero = (numero * otroNumero) `div` gcd numero otroNumero
  
-- === Ejercicio 10

type Medicion = Integer

-- | Indica si la dispersión de las mediciones recibidas es chica.
--
-- Se considera que la dispersion es chica cuando es menor a 30cm.
-- === Ejemplos
--
-- >>> diasParejos 233 123 344
-- False 
--
-- >>> diasParejos 233 222 234
-- True 
diasParejos :: Medicion -> Medicion -> Medicion -> Bool
diasParejos m1 m2 m3 = dispersion m1 m2 m3 < 30


-- | Indica si la dispersión de las mediciones recibidas es grande.
--
-- Se considera que la dispersion es grande cuando es mayor a 100cm.
-- === Ejemplos
--
-- >>> diasLocos 233 123 344
-- True 
--
-- >>> diasLocos 233 222 234
-- False  
diasLocos :: Medicion -> Medicion -> Medicion -> Bool
diasLocos m1 m2 m3 = dispersion m1 m2 m3 > 100 


-- | Indica si la dispersión de las mediciones recibidas no es ni chica ni grande.
--
-- Se considera que la dispersion es chica cuando está entre 30cm y 100cm inclusive.
-- === Ejemplos
--
-- >>> diasNormales 233 123 344
-- False 
--
-- >>> diasNormales 233 230 201
-- True 
diasNormales :: Medicion -> Medicion -> Medicion -> Bool
diasNormales m1 m2 m3 = not (diasParejos m1 m2 m3) && not (diasLocos m1 m2 m3)


-- | Devuelve la diferencia entre la más alta y la más baja de las mediciones dadas.
--
-- === Ejemplos
--
-- >>> dispersion 12 34 5
-- 29
--
-- >>> dispersion 100 34 71
-- 66
dispersion :: Medicion -> Medicion -> Medicion -> Integer
dispersion m1 m2 m3 = max3 m1 m2 m3 - min3 m1 m2 m3 


-- Funciones auxiliares para max y min de tres elementos

-- | Devuelve el máximo entre los tres números dados.
--
-- === Ejemplos
--
-- >>> max3 12 3 4
-- 12
--
-- >>> max3 (-1) 3 7
-- 7
max3 :: Integer -> Integer -> Integer -> Integer
max3 x y z = x `max` y `max` z 


-- | Devuelve el mínimo entre los tres números dados.
--
-- === Ejemplos
--
-- >>> min3 12 3 4
-- 3
--
-- >>> min3 (-1) 3 7
-- -1
min3 :: Integer -> Integer -> Integer -> Integer
min3 x y z = x `min` y `min` z 

-- === Ejercicio 11 

type Altura = Float
type Peso   = Float 

-- | Recibe la altura de un pino y devuelve su peso.
--
-- La altura se calcula así: 3 kg x cm hasta 3 metros, 2 kg x cm arriba de los 3 metros.
-- === Ejemplos
--
-- >>> pesoPino 200
-- 600.0
--
-- >>> pesoPino 500
-- 1300.0
pesoPino :: Altura -> Peso 
pesoPino alturaPino | alturaPino <= 300 = 3 * alturaPino
                    | otherwise         = 3 * 300 + 2 * (alturaPino - 300)


-- | Recibe un peso en kg y devuelve True si un pino de ese peso le sirve a la fábrica, y False en caso contrario.
--
-- A la fábrica le sirven árboles de entre 400 y 1000 kilos.
-- === Ejemplos
--
-- >>> esPesoUtil 467
-- True
--
-- >>> pesoPino 1234
-- False 
esPesoUtil :: Peso -> Bool 
esPesoUtil pesoPino = pesoPino >= 400 && pesoPino <= 1000


-- | Recibe la altura de un pino y devuelve True si un pino de ese peso le sirve a la fábrica, y False en caso contrario.
--
-- === Ejemplos
--
-- >>> sirvePino 467
-- False 
--
-- >>> sirvePino 220
-- True 
sirvePino :: Altura -> Bool
sirvePino = esPesoUtil . pesoPino