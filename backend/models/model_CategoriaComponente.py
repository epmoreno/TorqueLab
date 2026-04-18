from sqlalchemy import Column, Integer, String, TEXT
from db import Base

class CategoriaComponente(Base):
    __tablename__ = "categoria_componente"
    __table_args__ = {"schema": "public"}
    
    id_categoria = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    nombre_categoria = Column(String(100), nullable=False)
    descripcion = Column(TEXT, nullable=True)

    def to_dict(self):
        return {
            "id_categoria": self.id_categoria,
            "nombre_categoria": self.nombre_categoria,
            "descripcion": self.descripcion
        }