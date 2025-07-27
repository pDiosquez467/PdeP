-- "Rambo tiene dos armas, una principal y otra secundaria.""
-- "Cada una cuenta con un cargador de cierta capacidad con alguna cantidad de balas."

-- 1. Averiguar cuántas balas le quedan a Rambo en total.

-- 2. Dada un arma, disparar si tiene balas.
-- Detalle: 
--      Si el cargador está lleno, Rambo se confía y dispara dos balas.
--      Si el cargador tiene al menos una bala, Rambo dispara.
--      Si el cargador no tiene balas, Rambo gatilla pero no pasa nada.

-- 3. Hacer que Rambo dispare todo a la vez.

-- === Resolución

data Arma = Arma {
    balas :: Int,
    tamañoCargador :: Int 
} deriving Show

data Rambo = Rambo {
    armaPrincipal :: Arma,
    armaSecundaria :: Arma 
} deriving Show

balasTotales :: Rambo -> Int 
balasTotales rambo = balas (armaPrincipal rambo) + balas (armaSecundaria rambo)

disparar :: Arma -> Arma 
disparar arma | balas arma == tamañoCargador arma = arma{balas = balas arma - 2}
              | balas arma > 0                    = arma{balas = balas arma - 1}
              | otherwise                         = arma 