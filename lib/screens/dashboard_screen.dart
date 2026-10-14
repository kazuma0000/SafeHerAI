import 'package:flutter/material.dart';
import '../core/app_state.dart';
import '../widgets/app_components.dart';
import 'journey_screen.dart';
import 'sos_screen.dart';

class DashboardScreen extends StatelessWidget {
  final AppState state;
  const DashboardScreen({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Good evening'), StatusPill(icon: state.online ? Icons.wifi : Icons.cloud_off, label: state.online ? 'Online' : 'Offline', color: state.online ? Colors.green : Colors.orange)]),
      const SizedBox(height: 8), Text('You’re safe here.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 24),
      _SafetyCard(state: state),
      const SizedBox(height: 24), const SectionTitle('Quick actions'), const SizedBox(height: 10),
       Row(children: [Expanded(child: _Action(icon: Icons.route, label: 'Start journey', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => JourneyScreen(state: state))))), const SizedBox(width: 12), Expanded(child: _Action(icon: Icons.people, label: 'Trusted people', onTap: () => state.setTab(1)))]),
      const SizedBox(height: 24), const SectionTitle('Recent activity'), const SizedBox(height: 8),
    ];
    if (state.events.isEmpty) { children.add(const Text('No activity yet.')); } else { children.add(ListTile(contentPadding: EdgeInsets.zero, leading: const CircleAvatar(child: Icon(Icons.check)), title: Text(state.events.first.title), subtitle: Text(state.events.first.detail))); }
    return ListView(padding: const EdgeInsets.fromLTRB(20, 18, 20, 100), children: children);
  }
}
class _Action extends StatelessWidget { final IconData icon; final String label; final VoidCallback onTap; const _Action({required this.icon, required this.label, required this.onTap}); @override Widget build(BuildContext context) => Card(child: InkWell(onTap: onTap, child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [Icon(icon), const SizedBox(height: 12), Text(label)])))); }
class _SafetyCard extends StatelessWidget {
  final AppState state;
  const _SafetyCard({required this.state});
  @override Widget build(BuildContext context) {
    return Card(color: Theme.of(context).colorScheme.primaryContainer, child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Icon(Icons.favorite_rounded), const SizedBox(height: 12), const Text('Need help right now?'), const SizedBox(height: 12),
      FilledButton.icon(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => SosScreen(state: state))); }, icon: const Icon(Icons.sos), label: const Text('Hold to activate SOS')),
    ])));
  }
}
