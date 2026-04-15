from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import sessionmaker, Session
from models import engine, Componente
import os

app = FastAPI()

# Sessiones
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependencia para obtener la sesión de la base de datos
def get_db():
    db_session = SessionLocal()
    try:
        yield db_session
    finally:
        db_session.close()

# EndPoint para obtener todos los componentes
@app.get("/Componentes")
def lista_componentes(db_session: Session = Depends(get_db)):
    result = db_session.query(Componente).all()

    return [comp.to_dict() for comp in result]

# EndPoint para obtener un componente por su ID
@app.get("/Componentes/{id}")
def obtener_componente(id : int, db_session: Session = Depends(get_db)):
    comp = db_session.query(Componente).filter(Componente.id_componente == id).first()

    if comp is None:
        raise HTTPException(status_code=404, detail="Componente no encontrado")
    
    return comp.to_dict()
