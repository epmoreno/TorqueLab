from pydantic import BaseModel
from typing import Optional, UniqueItems

class ProveedorCreate(BaseModel):
    nombre : str
    cif : str
    telefono : Optional[str] = None
    email : Optional[str] = None
    pais : Optional[str] = None
    region : Optional[str] = None
    provincia : Optional[str] = None
    ciudad : Optional[str] = None
    direccion : Optional[str] = None