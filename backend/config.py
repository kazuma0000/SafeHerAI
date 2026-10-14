from functools import lru_cache
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    app_name: str = "SafeHer AI"
    database_url: str = "sqlite:///./safeher.db"
    secret_key: str = "change-me-in-production-use-a-long-random-secret"
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 60
    ai_provider: str = "offline"
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

@lru_cache
def get_settings() -> Settings:
    return Settings()
