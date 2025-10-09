import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase_client.dart';
import '../services/session_manager.dart';
import '../widgets/dashboard_card.dart';
import 'assets_screen.dart';
import 'work_orders_screen.dart';
import 'inventory_screen.dart';
import 'reports_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  final SessionManager _sessionManager = SessionManager();

  String userEmail = '';
  int nbAssets = 0;
  int nbWorkOrders = 0;
  int nbInventoryItems = 0;

  @override
  void initState() {
    super.initState();
    final session = supabase.auth.currentSession;
    userEmail = session?.user.email ?? 'Utilisateur';
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final assetsResponse = await supabase.from('assets').select('id');
      final workOrdersResponse = await supabase.from('work_orders').select('id');
      final inventoryResponse = await supabase.from('inventory').select('id');

      setState(() {
        nbAssets = assetsResponse.length;
        nbWorkOrders = workOrdersResponse.length;
        nbInventoryItems = inventoryResponse.length;
      });
    } catch (e) {
      debugPrint('Erreur lors du chargement des données : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur de chargement des données.")),
      );
    }
  }

  Future<void> _logout() async {
    await _sessionManager.clearSession();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau de bord CMMS"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Actualiser",
            onPressed: _loadDashboardData,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Se déconnecter",
            onPressed: _logout,
          ),
        ],
      ),
      drawer: _buildDrawer(context, colorScheme),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            DashboardCard(
              icon: Icons.precision_manufacturing,
              title: "Équipements",
              value: "$nbAssets",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AssetsScreen()),
              ),
            ),
            DashboardCard(
              icon: Icons.assignment,
              title: "Ordres de travail",
              value: "$nbWorkOrders",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WorkOrdersScreen()),
              ),
            ),
            DashboardCard(
              icon: Icons.inventory,
              title: "Inventaire",
              value: "$nbInventoryItems",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InventoryScreen()),
              ),
            ),
            DashboardCard(
              icon: Icons.bar_chart,
              title: "Rapports",
              value: "—",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportsScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context, ColorScheme colorScheme) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colorScheme.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bienvenue,',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  userEmail,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Tableau de bord'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.precision_manufacturing),
            title: const Text('Équipements'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AssetsScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Ordres de travail'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WorkOrdersScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventaire'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InventoryScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Rapports'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReportsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
