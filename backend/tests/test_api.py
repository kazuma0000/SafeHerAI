from fastapi.testclient import TestClient
from backend.main import app

client = TestClient(app)

def register(email="test@example.com"):
    response = client.post("/api/auth/register", json={"email": email, "full_name": "Test User", "password": "correct horse battery"})
    assert response.status_code in (201, 409)
    return response

def token(email="test@example.com"):
    register(email)
    response = client.post("/api/auth/login", json={"email": email, "password": "correct horse battery"})
    assert response.status_code == 200
    return response.json()["access_token"]

def test_health_registration_login_and_auth():
    assert client.get("/health").json() == {"status": "ok"}
    access = token("auth@example.com")
    assert client.get("/api/contacts", headers={"Authorization": f"Bearer {access}"}).status_code == 200
    assert client.get("/api/contacts", headers={"Authorization": "Bearer bad"}).status_code == 401
    assert access

def test_contacts_are_crud_and_owner_scoped():
    first = token("owner@example.com")
    created = client.post("/api/contacts", headers={"Authorization": f"Bearer {first}"}, json={"name": "Alex", "phone": "+100000", "is_primary": True})
    assert created.status_code == 201
    contact_id = created.json()["id"]
    assert len(client.get("/api/contacts", headers={"Authorization": f"Bearer {first}"}).json()) >= 1
    other = token("other@example.com")
    assert client.patch(f"/api/contacts/{contact_id}", headers={"Authorization": f"Bearer {other}"}, json={"name": "Nope", "phone": "123"}).status_code == 404

def test_sos_idempotency_and_sync_duplicate_prevention():
    access = token("sos@example.com")
    headers = {"Authorization": f"Bearer {access}"}
    payload = {"client_event_id": "offline-1", "latitude": 1.2, "longitude": 3.4}
    first = client.post("/api/sos", headers=headers, json=payload)
    second = client.post("/api/sos", headers=headers, json=payload)
    assert first.status_code == 201 and second.json()["id"] == first.json()["id"]
    synced = client.post("/api/sos/sync", headers=headers, json=[payload, {"client_event_id": "offline-2"}])
    assert synced.status_code == 200 and len(synced.json()) == 2
    assert len(client.get("/api/sos", headers=headers).json()) == 2
