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
    _loadAsset();
  }

  Future<void> _loadAsset() async {
    try {
      final response = await _supabase
          .from('assets')
          .select()
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
        appBar: AppBar(title: const Text('Détails équipement')),
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
        body: Center(child: Text('Aucun détail disponible.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_asset!['name'] ?? 'Équipement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailRow('ID', _asset!['id'].toString()),
            _buildDetailRow('Nom', _asset!['name']),
            _buildDetailRow('Emplacement', _asset!['location']),
            _buildDetailRow('Statut', _asset!['status']),
            _buildDetailRow('Date d’ajout', _asset!['created_at']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label : ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value ?? '—'),
          ),
        ],
      ),
    );
  }
}
