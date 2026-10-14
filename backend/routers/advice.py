from fastapi import APIRouter, Depends
from ..dependencies import current_user
from ..models import User
from ..schemas import AdviceRequest, AdviceResponse
from ..services import safety_advice
router = APIRouter(prefix="/api/advice", tags=["advice"])
@router.post("", response_model=AdviceResponse)
def advice(data: AdviceRequest, user: User = Depends(current_user)): 
    result, urgency = safety_advice(data.message); return AdviceResponse(advice=result, urgency=urgency)
