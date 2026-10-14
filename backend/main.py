from fastapi import FastAPI
from .database import Base, engine
from .routers import advice, auth, contacts, journeys, sos
Base.metadata.create_all(bind=engine)
app = FastAPI(title="SafeHer AI API", version="1.0.0")
app.include_router(auth.router); app.include_router(contacts.router); app.include_router(sos.router); app.include_router(sos.emergency_router); app.include_router(journeys.router); app.include_router(advice.router)
@app.get("/health")
def health(): return {"status": "ok"}
