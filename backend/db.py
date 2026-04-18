from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker ,declarative_base
import os

# Obtenemos la URL de la base de datos desde una variable de entorno
DATABASE_URL = os.getenv("DATABASE_URL")

# Crear el motor de la base de datos
engine = create_engine(DATABASE_URL)

# Sessiones
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base para los modelos
Base = declarative_base()

# Dependencia para obtener la sesión de la base de datos
def get_db():
    db_session = SessionLocal()
    try:
        yield db_session
    finally:
        db_session.close()