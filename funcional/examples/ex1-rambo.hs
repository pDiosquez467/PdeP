-- | Representa un arma con cierta cantidad de balas cargadas y capacidad máxima de su cargador.
data Arma = Arma
  { balas :: Int                -- ^ Cantidad actual de balas en el cargador
  , tamañoCargador :: Int       -- ^ Capacidad máxima del cargador
  } deriving Show

-- | Representa a Rambo con un arma principal y una secundaria.
data Rambo = Rambo
  { armaPrincipal :: Arma       -- ^ Arma principal de Rambo
  , armaSecundaria :: Arma      -- ^ Arma secundaria de Rambo
  } deriving Show


-- | Devuelve la cantidad total de balas que tiene Rambo entre sus dos armas.
--
-- === Ejemplos
--
-- >>> balasTotales (Rambo (Arma 10 30) (Arma 5 15))
-- 15
balasTotales :: Rambo -> Int
balasTotales rambo = balas (armaPrincipal rambo) + balas (armaSecundaria rambo)


-- | Simula un disparo con un arma según la siguiente lógica:
--
-- - Si el cargador está lleno, dispara dos balas.
-- - Si tiene al menos una bala, dispara una.
-- - Si no tiene balas, no dispara.
--
-- === Ejemplos
--
-- >>> disparar (Arma 10 10)
-- Arma {balas = 8, tamañoCargador = 10}
--
-- >>> disparar (Arma 3 5)
-- Arma {balas = 2, tamañoCargador = 5}
--
-- >>> disparar (Arma 0 5)
-- Arma {balas = 0, tamañoCargador = 5}
disparar :: Arma -> Arma
disparar arma
  | balas arma == tamañoCargador arma = arma { balas = max 0 (balas arma - 2) }
  | balas arma > 0                    = arma { balas = balas arma - 1 }
  | otherwise                         = arma


-- | Hace que Rambo dispare con ambas armas a la vez.
--
-- === Ejemplos
--
-- >>> dispararTodo (Rambo (Arma 10 10) (Arma 1 5))
-- Rambo {armaPrincipal = Arma {balas = 8, tamañoCargador = 10}, armaSecundaria = Arma {balas = 0, tamañoCargador = 5}}
dispararTodo :: Rambo -> Rambo
dispararTodo rambo = Rambo
  { armaPrincipal  = disparar (armaPrincipal rambo)
  , armaSecundaria = disparar (armaSecundaria rambo)
  }
