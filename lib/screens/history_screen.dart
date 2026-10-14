import 'package:flutter/material.dart';
import '../core/app_state.dart';
import '../widgets/app_components.dart';

class HistoryScreen extends StatelessWidget {
  final AppState state;
  const HistoryScreen({super.key, required this.state});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Activity history')),
    body: state.events.isEmpty ? const EmptyState(icon: Icons.history, title: 'Nothing here yet', detail: 'Completed journeys and check-ins will appear here.') : ListView.builder(padding: const EdgeInsets.all(20), itemCount: state.events.length, itemBuilder: (_, index) { final event = state.events[index]; return Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(leading: const CircleAvatar(child: Icon(Icons.check)), title: Text(event.title), subtitle: Text('${event.detail}\n${event.time.toLocal()}'), isThreeLine: true)); }),
  );
}
