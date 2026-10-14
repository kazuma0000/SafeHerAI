from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from ..database import get_db
from ..models import User
from ..schemas import Login, Token, UserCreate, UserOut
from ..security import create_access_token, hash_password, verify_password
router = APIRouter(prefix="/api/auth", tags=["auth"])
@router.post("/register", response_model=UserOut, status_code=201)
def register(data: UserCreate, db: Session = Depends(get_db)):
    if db.query(User).filter_by(email=data.email).first(): raise HTTPException(409, "Email already registered")
    user = User(email=data.email, full_name=data.full_name, password_hash=hash_password(data.password)); db.add(user); db.commit(); db.refresh(user); return user
@router.post("/login", response_model=Token)
def login(data: Login, db: Session = Depends(get_db)):
    user = db.query(User).filter_by(email=data.email).first()
    if not user or not verify_password(data.password, user.password_hash): raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Incorrect email or password")
    return Token(access_token=create_access_token(str(user.id)))
