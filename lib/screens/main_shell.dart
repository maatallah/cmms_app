import 'package:flutter/material.dart';
import 'package:cmms_app/screens/dashboard_screen.dart';
import 'package:cmms_app/screens/work_orders_screen.dart';
import 'package:cmms_app/screens/inventory_screen.dart';
import 'package:cmms_app/screens/assets_screen.dart';
import 'package:cmms_app/screens/parameters_screen.dart';

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

  final List<String> _titles = const [
    'Tableau de bord',
    'Ordres de travail',
    'Inventaire',
    'Équipements',
    'Paramètres',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.blue.shade800,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade800),
              child: const Center(
                child: Text(
                  'Application de maintenance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Tableau de bord', 0),
            _buildDrawerItem(Icons.work, 'Ordres de travail', 1),
            _buildDrawerItem(Icons.inventory_2, 'Inventaire', 2),
            _buildDrawerItem(Icons.build, 'Équipements', 3),
            const Divider(),
            _buildDrawerItem(Icons.settings, 'Paramètres', 4),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon,
          color: _selectedIndex == index ? Colors.blue.shade800 : Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          fontWeight:
              _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          color:
              _selectedIndex == index ? Colors.blue.shade800 : Colors.black87,
        ),
      ),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }
}
