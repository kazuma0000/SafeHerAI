import 'package:flutter/material.dart';
import '../core/app_state.dart';

class AuthScreen extends StatefulWidget {
  final AppState state;
  const AuthScreen({super.key, required this.state});
  @override State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool onboarding = true;
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Padding(padding: const EdgeInsets.all(28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Spacer(),
      Container(width: 68, height: 68, decoration: const BoxDecoration(color: Color(0xFFF9DCE5), borderRadius: BorderRadius.all(Radius.circular(22))), child: const Icon(Icons.shield_rounded, color: Color(0xFFCE5B7A), size: 38)),
      const SizedBox(height: 24),
      Text(onboarding ? 'Feel safer,\nwherever you go.' : 'Welcome back.', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Text(onboarding ? 'SafeHer AI is your calm companion for check-ins, journeys, and moments that need extra support.' : 'Sign in to pick up where you left off.', style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 32),
      if (!onboarding) TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email address', prefixIcon: Icon(Icons.mail_outline))),
      const SizedBox(height: 12),
      FilledButton(onPressed: () => onboarding ? setState(() => onboarding = false) : widget.state.signIn(), style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)), child: Text(onboarding ? 'Get started' : 'Continue')),
      if (!onboarding) Center(child: TextButton(onPressed: () => setState(() => onboarding = true), child: const Text('Back to intro'))),
      const Spacer(),
      Center(child: Text('Your safety data stays yours.', style: Theme.of(context).textTheme.bodySmall)),
    ]))),
  );
}
