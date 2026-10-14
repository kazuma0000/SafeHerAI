from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..dependencies import current_user
from ..models import Contact, User
from ..schemas import ContactCreate, ContactOut
router = APIRouter(prefix="/api/contacts", tags=["contacts"])
@router.get("", response_model=list[ContactOut])
def list_contacts(user: User = Depends(current_user), db: Session = Depends(get_db)): return db.query(Contact).filter_by(user_id=user.id).all()
@router.post("", response_model=ContactOut, status_code=201)
def create_contact(data: ContactCreate, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = Contact(**data.model_dump(), user_id=user.id); db.add(item); db.commit(); db.refresh(item); return item
@router.patch("/{contact_id}", response_model=ContactOut)
def update_contact(contact_id: int, data: ContactCreate, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(Contact).filter_by(id=contact_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "Contact not found")
    for key, value in data.model_dump().items(): setattr(item, key, value)
    db.commit(); db.refresh(item); return item
@router.delete("/{contact_id}", status_code=204)
def delete_contact(contact_id: int, user: User = Depends(current_user), db: Session = Depends(get_db)):
    item = db.query(Contact).filter_by(id=contact_id, user_id=user.id).first()
    if not item: raise HTTPException(404, "Contact not found")
    db.delete(item); db.commit()
