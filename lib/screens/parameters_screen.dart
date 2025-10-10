import 'package:flutter/material.dart';

class ParametersScreen extends StatelessWidget {
  const ParametersScreen({super.key});

  void _showNotImplemented(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(feature),
        content: const Text('This parameter page is not implemented yet.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // A simple parameters list — extend each ListTile to navigate to
    // real screens when you implement them.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parameters'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Users'),
            subtitle: const Text('Manage user accounts, roles and units'),
            onTap: () => _showNotImplemented(context, 'Users'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Asset types / Categories'),
            subtitle: const Text('Configure asset categories and metadata'),
            onTap: () => _showNotImplemented(context, 'Asset categories'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('System settings'),
            subtitle: const Text('Global application settings'),
            onTap: () => _showNotImplemented(context, 'System settings'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Inventory settings'),
            subtitle: const Text('Units, thresholds and inventory policies'),
            onTap: () => _showNotImplemented(context, 'Inventory settings'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Work order statuses'),
            subtitle: const Text('Configure default statuses (e.g. Ouvert, Fermé)'),
            onTap: () => _showNotImplemented(context, 'Work order statuses'),
          ),
          const Divider(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () => _showNotImplemented(context, 'Export / Import'),
              icon: const Icon(Icons.import_export),
              label: const Text('Export / Import configuration'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
