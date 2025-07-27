-- | Representa a un cliente con un saldo, si es VIP o no, y su nombre.
data Cliente = Cliente {
    saldo  :: Float,   -- ^ Saldo actual del cliente
    esVIP  :: Bool,    -- ^ True si el cliente es VIP
    nombre :: String   -- ^ Nombre del cliente
} deriving Show 


-- | Representa un producto con su tipo y precio base (sin IVA).
data Producto = Producto {
    tipo   :: String,  -- ^ Tipo o categoría del producto
    precio :: Float    -- ^ Precio base sin impuestos
} deriving Show


-- | Modifica el saldo de un cliente aplicando una variación dada.
-- 
-- === Ejemplos
-- 
-- >>> cambiarSaldo (Cliente 100 False "Pablo") (-20)
-- Cliente {saldo = 80.0, esVIP = False, nombre = "Pablo"}
--
cambiarSaldo :: Cliente -> Float -> Cliente
cambiarSaldo cliente delta = cliente {saldo = saldo cliente + delta}


-- | Crea un nuevo cliente VIP con saldo cero.
--
-- === Ejemplos
--
-- >>> nuevoClienteVIP "Ana"
-- Cliente {saldo = 0.0, esVIP = True, nombre = "Ana"}
--
nuevoClienteVIP :: String -> Cliente
nuevoClienteVIP = Cliente 0 True  -- Uso de Point-Free


-- | Calcula el precio final de un producto con IVA (21%).
--
-- === Ejemplos
--
-- >>> precioNeto (Producto "Libro" 100)
-- 121.0
--
precioNeto :: Producto -> Float
precioNeto = (*1.21) . precio


-- | Permite que un cliente compre un producto, descontando el precio con IVA de su saldo.
--
-- === Ejemplos
--
-- >>> comprar (Producto "Lapicera" 10) (Cliente 50 False "Lucas")
-- Cliente {saldo = 37.9, esVIP = False, nombre = "Lucas"}
--
comprar :: Producto -> Cliente -> Cliente
comprar producto cliente = cambiarSaldo cliente (negate $ precioNeto producto)


-- | Permite al cliente comprar dos productos y aplicar un descuento final.
--
-- Se descuentan ambos productos con IVA y luego se suma el descuento al saldo.
--
-- === Ejemplos
--
-- >>> let p1 = Producto "Remera" 100
-- >>> let p2 = Producto "Zapatilla" 300
-- >>> comprarEnPromocion p1 p2 50 (Cliente 500 False "Juan")
-- Cliente {saldo = 50.0, esVIP = False, nombre = "Juan"}
--
comprarEnPromocion :: Producto -> Producto -> Float -> Cliente -> Cliente
comprarEnPromocion prod1 prod2 descuento = 
    cambiarSaldo descuento . comprar prod2 . comprar prod1
