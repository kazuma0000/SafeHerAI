import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/local_queue.dart';
import '../services/session_service.dart';
import '../services/sync_service.dart';

class AppState extends ChangeNotifier {
  final SessionService session;
  final LocalQueue queue;
  final SyncService syncService;
  bool ready = false, signedIn = false, online = true;
  int pendingSync = 0;
  int tab = 0;
  final contacts = <SafetyContact>[];
  final events = <SafetyEvent>[];
  StreamSubscription<bool>? _connection;
  AppState({SessionService? session, LocalQueue? queue, SyncService? syncService}) : session = session ?? SessionService(), queue = queue ?? LocalQueue(), syncService = syncService ?? SyncService() {
    _init();
  }
  Future<void> _init() async { signedIn = await session.isSignedIn(); pendingSync = (await queue.pending()).length; _connection = syncService.connectivity.online.listen((value) { online = value; if (value) sync(); notifyListeners(); }); ready = true; notifyListeners(); }
  Future<void> signIn() async { await session.setSignedIn(true); signedIn = true; notifyListeners(); }
  Future<void> signOut() async { await session.setSignedIn(false); signedIn = false; notifyListeners(); }
  void setTab(int value) { tab = value; notifyListeners(); }
  void addContact(SafetyContact contact) { contacts.add(contact); notifyListeners(); }
  Future<void> sync() async { pendingSync -= await syncService.sync(); if (pendingSync < 0) pendingSync = 0; notifyListeners(); }
  Future<void> logEvent(String title, String detail) async { events.insert(0, SafetyEvent(id: DateTime.now().toIso8601String(), title: title, detail: detail, time: DateTime.now())); await queue.enqueue('event', {'title': title, 'detail': detail}); pendingSync++; notifyListeners(); }
  Future<void> queueSos(String eventId, {double? latitude, double? longitude}) async {
    await queue.enqueue('sos', {'client_event_id': eventId, 'latitude': latitude, 'longitude': longitude, 'note': 'SOS created by SafeHer AI mobile app'});
    events.insert(0, SafetyEvent(id: eventId, title: 'SOS created', detail: online ? 'Waiting for server confirmation' : 'Saved securely — waiting for connectivity', time: DateTime.now(), resolved: false));
    pendingSync = (await queue.pending()).length;
    if (online) await sync();
    notifyListeners();
  }
  @override void dispose() { _connection?.cancel(); super.dispose(); }
}
