import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final supabase = Supabase.instance.client;
  final _sessionManager = SessionManager();

  late RealtimeChannel _assetsChannel;
  late RealtimeChannel _workOrdersChannel;
  late RealtimeChannel _inventoryChannel;

  int _assetsCount = 0;
  int _workOrdersCount = 0;
  int _inventoryCount = 0;

  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    AssetsScreen(),
    WorkOrdersScreen(),
    InventoryScreen(),
    ReportsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
    _initRealtimeSubscriptions();
  }

  @override
  void dispose() {
    _assetsChannel.unsubscribe();
    _workOrdersChannel.unsubscribe();
    _inventoryChannel.unsubscribe();
    super.dispose();
  }

  Future<void> _loadDashboardData() async {
    try {
      final assetsResponse = await supabase.from('assets').select();
      final workOrdersResponse = await supabase.from('work_orders').select();
      final inventoryResponse = await supabase.from('inventory').select();

      setState(() {
        _assetsCount = assetsResponse.length;
        _workOrdersCount = workOrdersResponse.length;
        _inventoryCount = inventoryResponse.length;
      });
    } catch (e) {
      debugPrint('Erreur de chargement du tableau de bord : $e');
    }
  }

  void _initRealtimeSubscriptions() {
    _assetsChannel = supabase.channel('public:assets')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'assets',
        callback: (payload) {
          debugPrint('🔁 Changement détecté sur assets');
          _loadDashboardData();
        },
      )
      ..subscribe();

    _workOrdersChannel = supabase.channel('public:work_orders')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'work_orders',
        callback: (payload) {
          debugPrint('🔁 Changement détecté sur work_orders');
          _loadDashboardData();
        },
      )
      ..subscribe();

    _inventoryChannel = supabase.channel('public:inventory')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'inventory',
        callback: (payload) {
          debugPrint('🔁 Changement détecté sur inventory');
          _loadDashboardData();
        },
      )
      ..subscribe();
  }

  Future<void> _logout() async {
    await _sessionManager.clearSession();
    await supabase.auth.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord CMMS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                'Menu principal',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.devices),
              title: const Text('Équipements'),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Ordres de travail'),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Inventaire'),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Rapports'),
              selected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? _buildDashboardView()
          : _screens[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    Navigator.pop(context); // ferme le Drawer
    setState(() => _selectedIndex = index);
  }

  Widget _buildDashboardView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          DashboardCard(
            title: 'Équipements',
            count: _assetsCount,
            icon: Icons.devices,
            color: Colors.blue.shade400,
          ),
          DashboardCard(
            title: 'Ordres de travail',
            count: _workOrdersCount,
            icon: Icons.assignment,
            color: Colors.orange.shade400,
          ),
          DashboardCard(
            title: 'Inventaire',
            count: _inventoryCount,
            icon: Icons.inventory,
            color: Colors.green.shade400,
          ),
        ],
      ),
    );
  }
}
