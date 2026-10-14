import 'package:flutter/material.dart';
import '../core/app_state.dart';
import '../widgets/app_components.dart';

class ProfileScreen extends StatelessWidget {
  final AppState state;
  const ProfileScreen({super.key, required this.state});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Profile & settings')), body: ListView(padding: const EdgeInsets.all(20), children: [Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: const Text('Your SafeHer profile'), subtitle: const Text('Safety preferences are stored on this device'), trailing: const Icon(Icons.chevron_right))), const SizedBox(height: 20), const SectionTitle('Preferences'), Card(child: Column(children: const [_Setting(icon: Icons.notifications_none, title: 'Notifications', detail: 'Alerts and check-ins'), Divider(height: 1), _Setting(icon: Icons.lock_outline, title: 'Privacy & security', detail: 'Location and data controls'), Divider(height: 1), _Setting(icon: Icons.help_outline, title: 'Help center', detail: 'Get support')])), const SizedBox(height: 20), if (state.pendingSync > 0) StatusPill(icon: Icons.cloud_upload_outlined, label: '${state.pendingSync} action(s) waiting to sync', color: Colors.orange), const SizedBox(height: 24), OutlinedButton.icon(onPressed: state.signOut, icon: const Icon(Icons.logout), label: const Text('Sign out'))]));
}
class _Setting extends StatelessWidget { final IconData icon; final String title, detail; const _Setting({required this.icon, required this.title, required this.detail}); @override Widget build(BuildContext context) => ListTile(leading: Icon(icon), title: Text(title), subtitle: Text(detail), trailing: const Icon(Icons.chevron_right)); }
