from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from .database import get_db
from .models import User
from .security import decode_subject

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/auth/login")
def current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> User:
    try: uid = decode_subject(token)
    except ValueError: raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authentication credentials")
    user = db.get(User, uid)
    if not user: raise HTTPException(status_code=401, detail="User not found")
    return user
