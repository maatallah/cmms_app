import 'package:flutter/material.dart';

class AdaptiveNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onLogout;

  const AdaptiveNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onLogout,
  });

  static const _destinations = [
    {'icon': Icons.dashboard, 'label': 'Tableau de bord'},
    {'icon': Icons.build, 'label': 'Équipements'},
    {'icon': Icons.assignment, 'label': 'Ordres de travail'},
    {'icon': Icons.inventory, 'label': 'Inventaire'},
    {'icon': Icons.bar_chart, 'label': 'Rapports'},
    {'icon': Icons.settings, 'label': 'Paramètres'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    if (isWide) {
      // 🖥️ Desktop / Tablet view → NavigationRail
      return NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        labelType: NavigationRailLabelType.all,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.factory, size: 36),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Déconnexion',
          onPressed: onLogout,
        ),
        destinations: _destinations
            .map(
              (d) => NavigationRailDestination(
                icon: Icon(d['icon'] as IconData),
                label: Text(d['label'] as String),
              ),
            )
            .toList(),
      );
    }

    // 📱 Mobile view → Drawer
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'CMMS App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ..._destinations.asMap().entries.map(
                (entry) => ListTile(
                  leading: Icon(entry.value['icon'] as IconData),
                  title: Text(entry.value['label'] as String),
                  selected: selectedIndex == entry.key,
                  onTap: () {
                    Navigator.pop(context);
                    onDestinationSelected(entry.key);
                  },
                ),
              ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
