from pydantic import BaseModel
from typing import Optional

class CategoriaComponenteCreate(BaseModel):
    id_categoria: Optional[int] = None
    nombre_categoria: str
    descripcion: Optional[str] = None