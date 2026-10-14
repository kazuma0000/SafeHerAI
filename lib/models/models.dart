class SafetyContact {
  final String id, name, phone;
  final bool trusted;
  const SafetyContact({required this.id, required this.name, required this.phone, this.trusted = true});
}

class SafetyEvent {
  final String id, title, detail;
  final DateTime time;
  final bool resolved;
  const SafetyEvent({required this.id, required this.title, required this.detail, required this.time, this.resolved = true});
}

class JourneyPlan {
  final String destination;
  final DateTime eta;
  final bool sharing;
  const JourneyPlan({required this.destination, required this.eta, this.sharing = true});
}

class ChatMessage {
  final String text;
  final bool fromUser;
  const ChatMessage(this.text, {this.fromUser = false});
}
