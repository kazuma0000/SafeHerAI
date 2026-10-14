"""ASGI compatibility entry point for deployments using backend.app.main."""
from ..main import app

__all__ = ["app"]
