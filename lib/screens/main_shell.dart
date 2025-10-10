import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'work_orders_screen.dart';
import 'inventory_screen.dart';
import 'assets_screen.dart';
import 'parameters_screen.dart';
import '../services/session_manager.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    WorkOrdersScreen(),
    InventoryScreen(),
    AssetsScreen(),
    ParametersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    await SessionManager().clearSavedSession();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Work Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Parameters',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _logout,
              backgroundColor: Colors.red,
              child: const Icon(Icons.logout),
            )
          : null,
    );
  }
}
