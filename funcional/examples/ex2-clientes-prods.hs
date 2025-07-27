
data Cliente = Cliente {
    saldo :: Float,
    esVip :: Bool,
    nombre :: String
} deriving Show 

data Producto = Producto {
    tipo :: String,
    precio :: Float 
} deriving Show

cambiarSaldo cliente delta = cliente {saldo = saldo cliente + delta}