import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/session_manager.dart';
import '../widgets/dashboard_card.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final supabase = Supabase.instance.client;
  final _sessionManager = SessionManager();

  int _assetsCount = 0;
  int _workOrdersCount = 0;
  int _inventoryCount = 0;
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final assets = await supabase.from('assets').select();
      final workOrders = await supabase.from('work_orders').select();
      final inventory = await supabase.from('inventory').select();

      if (!_isMounted) return;

      setState(() {
        _assetsCount = assets.length;
        _workOrdersCount = workOrders.length;
        _inventoryCount = inventory.length;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de chargement du tableau de bord : $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> _logout() async {
    await supabase.auth.signOut();
    await _sessionManager.clear();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DashboardCard(
              title: 'Équipements',
              count: _assetsCount,
              icon: Icons.precision_manufacturing,
              onTap: () {},
            ),
            DashboardCard(
              title: 'Ordres de travail',
              count: _workOrdersCount,
              icon: Icons.build,
              onTap: () {},
            ),
            DashboardCard(
              title: 'Inventaire',
              count: _inventoryCount,
              icon: Icons.inventory,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
