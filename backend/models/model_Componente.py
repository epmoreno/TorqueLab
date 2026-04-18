from sqlalchemy import Column, Integer, String, Numeric, TEXT, ForeignKey
from db import Base

# 3. Definir el modelo heredando de Base
class Componente(Base):
    __tablename__ = "componente"
    __table_args__ = {"schema": "public"}
    
    id_componente = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    nombre = Column(String(150), nullable=False)
    precio_venta = Column(Numeric(10, 2), nullable=False)
    precio_compra = Column(Numeric(10, 2), nullable=False)
    stock = Column(Integer, default=0, nullable=False)
    stock_minimo = Column(Integer, default=0, nullable=False)
    tipo_producto = Column(String(50), nullable=False)
    marca = Column(String(100), nullable=True)
    modelos_compatibles = Column(TEXT, nullable=True)
    
    # Las llaves foráneas se declaran directamente en la columna
    id_proveedor = Column(Integer, ForeignKey("public.proveedor.id_proveedor"), nullable=False)
    id_categoria = Column(Integer, ForeignKey("public.categoria_componente.id_categoria"), nullable=False)

    def to_dict(self):
        return {
            "id_componente": self.id_componente,
            "nombre": self.nombre,
            "precio_venta": float(self.precio_venta),
            "precio_compra": float(self.precio_compra),
            "stock": self.stock,
            "stock_minimo": self.stock_minimo,
            "tipo_producto": self.tipo_producto,
            "marca": self.marca,
            "modelos_compatibles": self.modelos_compatibles,
            "id_proveedor": self.id_proveedor,
            "id_categoria": self.id_categoria
        }