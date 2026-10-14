# SafeHer AI

SafeHer AI is an offline-first personal safety companion built for the MSc AI & ML academic project by Arya Yadav (26MAG0026), Divyanshu Kandpal (26MAG0028), and Raghav Malhotra (26MAG0048).

## Architecture

- **Flutter/Dart:** Material 3 mobile client, local queue, connectivity monitor, secure session token storage, SOS countdown, contacts, journeys, assistant, history, and settings.
- **Python/FastAPI:** JWT authentication, PBKDF2 password hashing, SQLAlchemy models, SQLite development database, owner-scoped contacts, idempotent SOS ingestion/sync, journeys, and deterministic safety advice.
- **Offline-first behavior:** An SOS is assigned a client event ID and is queued locally as `PENDING` when the API cannot be reached. When connectivity returns, the sync service posts it to `/api/emergency/sos`; the backend's unique `(user_id, client_event_id)` constraint prevents duplicates.

## Run the backend (PowerShell)

```powershell
python -m venv backend\.venv
.\backend\.venv\Scripts\Activate.ps1
pip install -r backend\requirements.txt
Copy-Item backend\.env.example backend\.env
uvicorn backend.main:app --reload
```

The API is available at `http://127.0.0.1:8000`; interactive docs are at `/docs`.

## Run the Flutter app

For an Android emulator, the default API URL is `http://10.0.2.2:8000`. For a physical device, set the API base URL to the host machine's LAN address in `ApiClient`.

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
```

The app remains usable without the backend for local safety queueing and the deterministic UI assistant. Camera, SMS delivery, background voice activation, and nearby-place search require platform permissions or external integrations and are deliberately reported as unavailable rather than simulated.

## Backend tests

```powershell
python -m pytest backend\tests -q
python -m compileall backend
```

See `backend/README.md` and `backend/.env.example` for environment configuration. Never commit `.env`, JWT secrets, or provider API keys.
