import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/dashboard_screen.dart';
import '../services/session_manager.dart';
import '../screens/login_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  late final List<_Page> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _Page('Tableau de bord', Icons.dashboard, const DashboardScreen()),
      _Page('Ordres de travail', Icons.build, const Placeholder()),
      _Page('Inventaire', Icons.inventory, const Placeholder()),
      _Page('Paramètres', Icons.settings, const Placeholder()),
    ];
  }

  Future<void> _logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      await SessionManager().clearSavedSession();

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (_) => false,
        );
      }
    } catch (e) {
      debugPrint("Erreur de déconnexion : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    final body = _pages[_selectedIndex].widget;

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex].title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: _logout,
          ),
        ],
      ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              extended: true,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: _pages
                  .map(
                    (page) => NavigationRailDestination(
                      icon: Icon(page.icon),
                      label: Text(page.title),
                    ),
                  )
                  .toList(),
            ),
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: _pages
                  .map(
                    (page) => NavigationDestination(
                      icon: Icon(page.icon),
                      label: page.title,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _Page {
  final String title;
  final IconData icon;
  final Widget widget;

  const _Page(this.title, this.icon, this.widget);
}
