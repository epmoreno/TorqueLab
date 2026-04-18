from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from models.model_Componente import Componente
from schemas.schema_componente import ComponenteCreate
from db import get_db

router = APIRouter()

# EndPoint para obtener todos los componentes
@router.get("/Componentes")
def lista_componentes(db_session: Session = Depends(get_db)):
    result = db_session.query(Componente).all()

    return [comp.to_dict() for comp in result]

# EndPoint para obtener un componente por su ID
@router.get("/Componentes/{id}")
def obtener_componente(id : int, db_session: Session = Depends(get_db)):
    comp = db_session.query(Componente).filter(Componente.id_componente == id).first()

    if comp is None:
        raise HTTPException(status_code=404, detail="Componente no encontrado")
    
    return comp.to_dict()

# EndPoint para crear un nuevo componente (NECESITA EL SCHEMA DEL MODELO PARA FUNCIONAR CORRECTAMENTE -> ComponenteCreate)
@router.post("/componentes")
def crear_componente(data: ComponenteCreate, db: Session = Depends(get_db)):
    nuevo = Componente(**data.model_dump())

    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)

    return nuevo.to_dict()

# EndPoint para actualizar un componente existente (NECESITA EL SCHEMA DEL MODELO PARA FUNCIONAR CORRECTAMENTE -> ComponenteCreate)
@router.put("/Componentes/{id}")
def actualizar_componente(id: int, componente_in: ComponenteCreate, db_session: Session = Depends(get_db)):
    comp = db_session.query(Componente).filter(Componente.id_componente == id).first()

    if comp is None:
        raise HTTPException(status_code=404, detail="Componente no encontrado")
    
    # Actualizamos dinámicamente usando el modelo de Pydantic
    datos_actualizados = componente_in.model_dump(exclude_unset=True)
    for key, value in datos_actualizados.items():
        setattr(comp, key, value)

    db_session.commit()
    db_session.refresh(comp)
    return comp.to_dict()

# EndPoint para eliminar un componente por su ID
@router.delete("/Componentes/{id}")
def eliminar_componente(id: int, db_session: Session = Depends(get_db)):
    comp = db_session.query(Componente).filter(Componente.id_componente == id).first()

    if comp is None:
        raise HTTPException(status_code=404, detail="Componente no encontrado")
    
    db_session.delete(comp)
    db_session.commit()
    
    return {"detail": "Componente eliminado exitosamente"}