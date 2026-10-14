import 'dart:async';
import 'package:flutter/material.dart';
import '../core/app_state.dart';

class SosScreen extends StatefulWidget { final AppState state; const SosScreen({super.key, required this.state}); @override State<SosScreen> createState() => _SosScreenState(); }
class _SosScreenState extends State<SosScreen> {
  int seconds = 5; Timer? timer; bool active = false;
  void start() { if (timer != null) return; setState(() => active = true); timer = Timer.periodic(const Duration(seconds: 1), (t) { if (seconds <= 1) { t.cancel(); widget.state.queueSos(DateTime.now().toUtc().toIso8601String()); setState(() => seconds = 0); } else { setState(() => seconds--); } }); }
  @override void dispose() { timer?.cancel(); super.dispose(); }
  @override Widget build(BuildContext context) { final title = active ? (seconds > 0 ? 'Alerting in $seconds' : 'Your contacts have been alerted') : 'Press and hold to alert'; return Scaffold(appBar: AppBar(title: const Text('Emergency SOS')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(active ? Icons.notifications_active : Icons.sos, size: 76, color: Colors.red), const SizedBox(height: 24), Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 28), GestureDetector(onLongPress: start, child: const CircleAvatar(radius: 88, backgroundColor: Color(0xFFFFE5E5), child: Text('SOS', style: TextStyle(fontSize: 42, color: Colors.red, fontWeight: FontWeight.bold)))), const SizedBox(height: 24), if (active && seconds > 0) OutlinedButton(onPressed: () { timer?.cancel(); setState(() { active = false; seconds = 5; }); }, child: const Text('Cancel'))]))); }
}
