from fastapi import FastAPI
from models.model_CategoriaComponente import CategoriaComponente
from models.model_Componente import Componente
from models.model_Proveedor import Proveedor
from routes import componentes
import os

app = FastAPI()

# Incluir el router de componentes
app.include_router(componentes.router)


