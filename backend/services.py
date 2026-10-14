from typing import Protocol

class SafetyAdviceProvider(Protocol):
    def advise(self, message: str) -> tuple[str, str]: ...

class OfflineSafetyProvider:
    def advise(self, message: str) -> tuple[str, str]:
        return safety_advice(message)

def safety_advice(message: str) -> tuple[str, str]:
    text = message.lower()
    urgent = any(word in text for word in ("help", "danger", "attack", "threat", "unsafe", "emergency"))
    if urgent: return ("Move to a public, well-lit place, contact a trusted person, and call local emergency services if you are in immediate danger.", "high")
    return ("Stay aware of your surroundings, share your location with a trusted contact, and choose a well-lit route.", "normal")
