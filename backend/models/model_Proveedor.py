from sqlalchemy import Column, Integer, String
from db import Base

class Proveedor(Base):
    __tablename__ = "proveedor"
    __table_args__ = {"schema": "public"}
    
    id_proveedor = Column(Integer, primary_key=True, autoincrement=True)
    nombre = Column(String(150), nullable=False)
    cif = Column(String(20), unique=True, nullable=False)
    telefono = Column(String(20), nullable=True)
    email = Column(String(150), nullable=True)
    pais = Column(String(100), nullable=True)
    region = Column(String(100), nullable=True)
    provincia = Column(String(100), nullable=True)
    ciudad = Column(String(100), nullable=True)
    direccion = Column(String(200), nullable=True)