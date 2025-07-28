-- | Devuelve el primer elemento de una tupla de tres componentes.
--
-- === Ejemplos
--
-- >>> fst3 (1, 'a', True)
-- 1
fst3 :: (a, b, c) -> a 
fst3 (x, _, _) = x 


-- | Devuelve el segundo elemento de una tupla de tres componentes.
--
-- === Ejemplos
--
-- >>> snd3 (1, 'a', True)
-- 'a'
snd3 :: (a, b, c) -> b 
snd3 (_, x, _) = x 


-- | Devuelve el tercer elemento de una tupla de tres componentes.
--
-- === Ejemplos
--
-- >>> trd3 (1, 'a', True)
-- True
trd3 :: (a, b, c) -> c 
trd3 (_, _, x) = x 



-- | Devuelve una tupla con el resultado de aplicar dos funciones distintas al mismo valor.
--
-- === Ejemplos
--
-- >>> aplicar (doble, triple) 8
-- (16, 24)
--
-- >>> aplicar ((3+), (2*)) 8
-- (11, 16)
aplicar :: (a -> b, a -> c) -> a -> (b, c)
aplicar (f, g) x = (f x, g x)


-- | Devuelve un número a partir de una tupla de dos enteros, de acuerdo a estas reglas:
-- 
-- - Si el primer número es mayor que el segundo, devuelve la suma.
-- - Si el segundo número excede al primero por más de 10, devuelve la resta.
-- - En cualquier otro caso, devuelve el producto.
--
-- === Ejemplos
--
-- >>> cuentaBizarra (10, 5)
-- 15
--
-- >>> cuentaBizarra (5, 20)
-- 15
--
-- >>> cuentaBizarra (4, 10)
-- 40
cuentaBizarra :: (Integral a) => (a, a) -> a
cuentaBizarra (num1, num2)
                        | num1 > num2      = num1 + num2
                        | num2 - num1 > 10 = num2 - num1
                        | otherwise        = num1 * num2
