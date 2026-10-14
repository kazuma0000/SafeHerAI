import 'api_client.dart';
import 'connectivity_service.dart';
import 'local_queue.dart';

class SyncService {
  final LocalQueue queue;
  final ApiClient api;
  final ConnectivityMonitor connectivity;
  SyncService({LocalQueue? queue, ApiClient? api, ConnectivityMonitor? connectivity}) : queue = queue ?? LocalQueue(), api = api ?? ApiClient(), connectivity = connectivity ?? ConnectivityService();
  Future<int> sync() async {
    if (!await connectivity.isOnline) return 0;
    final pending = await queue.pending();
    var sent = 0;
    for (final item in pending.where((item) => item['type'] == 'sos')) {
      try { await api.post('/api/emergency/sos', item['payload'] as Map<String, dynamic>); await queue.remove(item['id'] as String); sent++; } catch (_) { break; }
    }
    if (sent == pending.length) await queue.clear();
    return sent;
  }
}
