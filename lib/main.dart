import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_state.dart';
import 'core/router.dart';
import 'core/theme.dart';

void main() => runApp(ChangeNotifierProvider(create: (_) => AppState(), child: const SafeHerApp()));

class SafeHerApp extends StatelessWidget {
  const SafeHerApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, title: 'SafeHer AI', theme: AppTheme.light, home: AppRouter(state: context.watch<AppState>()));
}
