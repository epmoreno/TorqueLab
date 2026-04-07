import os
import sqlalchemy
import requests

db = sqlalchemy.create_engine(os.getenv("POSTGRES_URL"))

class Vehiculo(db.Model):
    __tablename__ = "vehiculo"
    __table_args__ = {"schema": "public"}
    
    id_vehiculo = db.Column(db.Integer, primary_key=True, autoincrement=True)
    matricula = db.Column(db.String(20), nullable=False)
    marca = db.Column(db.String(50), nullable=False)
    modelo = db.Column(db.String(50), nullable=False)
    anio = db.Column(db.Integer, nullable=False)
    num_bastidor = db.Column(db.String(20), nullable=False)
    id_cliente = db.Column(db.Integer, db.ForeignKey("cliente.id_cliente"), nullable=False)
    
    def to_dict(self):
        return {
            "id_vehiculo": self.id_vehiculo,
            "matricula": self.matricula,
            "marca": self.marca,
            "modelo": self.modelo,
            "anio": self.anio,
            "num_bastidor": self.num_bastidor,
            "id_cliente": self.id_cliente
        }