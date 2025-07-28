-- fst3, snd3, trd3

fst3 :: (a, b, c) -> a 
fst3 (x, _, _) = x 

snd3 :: (a, b, c) -> b 
snd3 (_, x, _) = x 

trd3 :: (a, b, c) -> c 
trd3 (_, _, x) = x 

-- | Devuelve una tupla con el resultado de aplicar las funciones dadas al elemento dado.
--
-- === Ejemplos
-- >>> aplicar (doble, triple) 8
-- (16, 24)
--
-- >>> aplicar ((3+), (2*)) 8
-- (11, 16)
aplicar :: (a -> b, a -> c) -> a -> (b, c)
aplicar (f, g) x = (f x, g x)

