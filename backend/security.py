from datetime import datetime, timedelta, timezone
from jose import JWTError, jwt
from passlib.context import CryptContext
from .config import get_settings

pwd_context = CryptContext(schemes=["pbkdf2_sha256"], deprecated="auto")
def hash_password(password: str) -> str: return pwd_context.hash(password)
def verify_password(password: str, hashed: str) -> bool: return pwd_context.verify(password, hashed)
def create_access_token(subject: str) -> str:
    s = get_settings(); return jwt.encode({"sub": subject, "exp": datetime.now(timezone.utc) + timedelta(minutes=s.access_token_expire_minutes)}, s.secret_key, algorithm=s.algorithm)
def decode_subject(token: str) -> int:
    s = get_settings()
    try: return int(jwt.decode(token, s.secret_key, algorithms=[s.algorithm])["sub"])
    except (JWTError, KeyError, TypeError, ValueError) as exc: raise ValueError("Invalid token") from exc
