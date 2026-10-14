import 'package:flutter/material.dart';
import '../core/app_state.dart';
import 'assistant_screen.dart';
import 'contacts_screen.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

 class HomeScreen extends StatelessWidget { final AppState state; const HomeScreen({super.key, required this.state}); @override Widget build(BuildContext context) { final pages = [DashboardScreen(state: state), ContactsScreen(state: state), HistoryScreen(state: state), ProfileScreen(state: state)]; return Scaffold(body: SafeArea(child: IndexedStack(index: state.tab, children: pages)), floatingActionButton: state.tab == 0 ? FloatingActionButton.extended(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AssistantScreen(state: state))), icon: const Icon(Icons.auto_awesome), label: const Text('Ask SafeHer')) : null, bottomNavigationBar: NavigationBar(selectedIndex: state.tab, onDestinationSelected: state.setTab, destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'), NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'People'), NavigationDestination(icon: Icon(Icons.history), label: 'History'), NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile')])); } }
