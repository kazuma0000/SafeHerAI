from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..dependencies import current_user
from ..models import Journey, User
from ..schemas import JourneyCreate, JourneyOut
router = APIRouter(prefix="/api/journeys", tags=["journeys"])
@router.get("", response_model=list[JourneyOut])
def list_journeys(user: User = Depends(current_user), db: Session = Depends(get_db)): return db.query(Journey).filter_by(user_id=user.id).all()
@router.post("", response_model=JourneyOut, status_code=201)
def create(data: JourneyCreate, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = Journey(**data.model_dump(), user_id=user.id); db.add(item); db.commit(); db.refresh(item); return item
@router.get("/{journey_id}", response_model=JourneyOut)
def get(journey_id: int, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(Journey).filter_by(id=journey_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "Journey not found")
    return item
@router.patch("/{journey_id}", response_model=JourneyOut)
def update(journey_id: int, data: JourneyCreate, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(Journey).filter_by(id=journey_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "Journey not found")
    for key, value in data.model_dump().items(): setattr(item, key, value)
    db.commit(); db.refresh(item); return item
@router.delete("/{journey_id}", status_code=204)
def delete(journey_id: int, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(Journey).filter_by(id=journey_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "Journey not found")
    db.delete(item); db.commit()
@router.patch("/{journey_id}/end", response_model=JourneyOut)
def end(journey_id: int, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(Journey).filter_by(id=journey_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "Journey not found")
    item.status = "ended"; item.ended_at = datetime.now(timezone.utc); db.commit(); db.refresh(item); return item
