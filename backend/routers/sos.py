from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..dependencies import current_user
from ..models import SosEvent, User
from ..schemas import SosCreate, SosOut
router = APIRouter(prefix="/api/sos", tags=["sos"])
@router.post("", response_model=SosOut, status_code=201)
def create_sos(data: SosCreate, user: User = Depends(current_user), db: Session = Depends(get_db)):
    existing = db.query(SosEvent).filter_by(user_id=user.id, client_event_id=data.client_event_id).first()
    if existing: return existing
    item = SosEvent(**data.model_dump(), user_id=user.id); db.add(item); db.commit(); db.refresh(item); return item
@router.get("", response_model=list[SosOut])
def history(user: User = Depends(current_user), db: Session = Depends(get_db)): return db.query(SosEvent).filter_by(user_id=user.id).order_by(SosEvent.created_at.desc()).all()
@router.get("/{event_id}", response_model=SosOut)
def detail(event_id: int, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(SosEvent).filter_by(id=event_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "SOS event not found")
    return item
@router.post("/{event_id}/end", response_model=SosOut)
def end(event_id: int, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(SosEvent).filter_by(id=event_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "SOS event not found")
    item.status = "ended"; item.ended_at = datetime.now(timezone.utc); db.commit(); db.refresh(item); return item
@router.post("/sync", response_model=list[SosOut])
def sync(events: list[SosCreate], user: User = Depends(current_user), db: Session = Depends(get_db)):
    result = []
    for data in events:
        item = db.query(SosEvent).filter_by(user_id=user.id, client_event_id=data.client_event_id).first()
        if not item: item = SosEvent(**data.model_dump(), user_id=user.id); db.add(item); db.flush()
        result.append(item)
    db.commit(); return result

# Product-facing aliases keep the API vocabulary aligned with the mobile client.
emergency_router = APIRouter(prefix="/api/emergency", tags=["emergency"])
emergency_router.add_api_route("/sos", create_sos, methods=["POST"], response_model=SosOut, status_code=201)
emergency_router.add_api_route("/history", history, methods=["GET"], response_model=list[SosOut])
emergency_router.add_api_route("/{event_id}", detail, methods=["GET"], response_model=SosOut)
emergency_router.add_api_route("/sync", sync, methods=["POST"], response_model=list[SosOut])
