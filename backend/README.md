# SafeHer AI backend

FastAPI + SQLAlchemy SQLite backend with JWT authentication, owner-scoped contacts, idempotent SOS sync, journeys, and deterministic offline safety advice.

From PowerShell:

```powershell
cd backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
Copy-Item .env.example .env
uvicorn backend.app.main:app --reload
```

Run checks from the repository root with `python -m pytest backend/tests -q` and `python -m compileall backend`.
