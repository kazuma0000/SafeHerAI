from datetime import datetime
from pydantic import BaseModel, ConfigDict, EmailStr, Field

class UserCreate(BaseModel):
    email: EmailStr; full_name: str = Field(min_length=1, max_length=120); password: str = Field(min_length=8, max_length=128)
class UserOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int; email: EmailStr; full_name: str; created_at: datetime
class Token(BaseModel): access_token: str; token_type: str = "bearer"
class Login(BaseModel): email: EmailStr; password: str
class ContactCreate(BaseModel):
    name: str = Field(min_length=1, max_length=120); phone: str = Field(min_length=3, max_length=40); relationship_type: str | None = None; is_primary: bool = False
class ContactOut(ContactCreate):
    model_config = ConfigDict(from_attributes=True)
    id: int
class SosCreate(BaseModel):
    client_event_id: str = Field(min_length=1, max_length=100); latitude: float | None = None; longitude: float | None = None; note: str | None = None
class SosOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int; client_event_id: str; status: str; latitude: float | None; longitude: float | None; note: str | None; created_at: datetime; ended_at: datetime | None
class JourneyCreate(BaseModel): destination: str = Field(min_length=1, max_length=255); expected_arrival: datetime | None = None
class JourneyOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int; destination: str; expected_arrival: datetime | None; status: str; created_at: datetime; ended_at: datetime | None
class AdviceRequest(BaseModel): message: str = Field(min_length=1, max_length=2000)
class AdviceResponse(BaseModel): advice: str; urgency: str
