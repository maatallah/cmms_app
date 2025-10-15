import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'asset_details_screen.dart';
import '../models/asset_model.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Asset> _assets = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    try {
      final response = await _supabase.from('assets').select();

      final data = response as List<dynamic>;
      setState(() {
        _assets = data.map((item) => Asset.fromMap(item as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Équipements')),
        body: Center(
          child: Text(
            'Erreur : $_error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (_assets.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Équipements')),
        body: const Center(child: Text('Aucun équipement trouvé.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Équipements'),
      ),
      body: ListView.builder(
        itemCount: _assets.length,
        itemBuilder: (context, index) {
          final asset = _assets[index];
          return ListTile(
            title: Text(asset.name),
            subtitle: Text(asset.model ?? 'Modèle inconnu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssetDetailsScreen(assetId: asset.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
