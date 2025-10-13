import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AssetDetailsScreen extends StatefulWidget {
  final int assetId;
  const AssetDetailsScreen({super.key, required this.assetId});

  @override
  State<AssetDetailsScreen> createState() => _AssetDetailsScreenState();
}

class _AssetDetailsScreenState extends State<AssetDetailsScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  Map<String, dynamic>? _asset;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAssetDetails();
  }

  Future<void> _loadAssetDetails() async {
    try {
      final response = await _supabase
          .from('assets')
          .select('*')
          .eq('id', widget.assetId)
          .single();

      setState(() {
        _asset = response;
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
        body: Center(
          child: Text(
            'Erreur : $_error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (_asset == null) {
      return const Scaffold(
        body: Center(child: Text('Aucun détail trouvé pour cet équipement.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_asset!['name'] ?? 'Détails de l’équipement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _asset!['name'] ?? 'Sans nom',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Emplacement : ${_asset!['location'] ?? 'Inconnu'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Description : ${_asset!['description'] ?? 'Aucune description'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
