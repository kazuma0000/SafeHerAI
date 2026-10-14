import 'package:flutter/material.dart';
import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';
import 'app_state.dart';

class AppRouter extends StatelessWidget {
  final AppState state;
  const AppRouter({super.key, required this.state});
  @override Widget build(BuildContext context) => AnimatedBuilder(animation: state, builder: (_, __) { if (!state.ready) return const Scaffold(body: Center(child: CircularProgressIndicator())); return state.signedIn ? HomeScreen(state: state) : AuthScreen(state: state); });
}
