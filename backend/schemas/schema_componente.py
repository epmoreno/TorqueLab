from pydantic import BaseModel
from typing import Optional

class ComponenteCreate(BaseModel):
    nombre: str
    precio_venta: float
    precio_compra: float
    stock: int = 0
    stock_minimo: int = 0
    tipo_producto: str
    marca: Optional[str] = None
    modelos_compatibles: Optional[str] = None
    id_proveedor: int
    id_categoria: int