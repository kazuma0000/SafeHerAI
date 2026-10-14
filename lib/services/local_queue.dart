import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalQueue {
  static const _key = 'safeher_sync_queue';
  Future<void> enqueue(String type, Map<String, dynamic> payload) async {
    final prefs = await SharedPreferences.getInstance();
    final queue = prefs.getStringList(_key) ?? <String>[];
    final id = payload['client_event_id'] ?? const Uuid().v4();
    if (queue.any((item) => (jsonDecode(item) as Map<String, dynamic>)['id'] == id)) return;
    queue.add(jsonEncode({'id': id, 'type': type, 'payload': payload, 'status': 'PENDING', 'created_at': DateTime.now().toUtc().toIso8601String()}));
    await prefs.setStringList(_key, queue);
  }
  Future<List<Map<String, dynamic>>> pending() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? []).map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }
  Future<void> remove(String id) async { final prefs = await SharedPreferences.getInstance(); final remaining = (prefs.getStringList(_key) ?? []).where((item) => (jsonDecode(item) as Map<String, dynamic>)['id'] != id).toList(); await prefs.setStringList(_key, remaining); }
  Future<void> clear() async => (await SharedPreferences.getInstance()).remove(_key);
}
