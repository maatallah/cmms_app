import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AssetDetailsScreen extends StatefulWidget {
  final String assetId;

  const AssetDetailsScreen({super.key, required this.assetId});

  @override
  State<AssetDetailsScreen> createState() => _AssetDetailsScreenState();
}

class _AssetDetailsScreenState extends State<AssetDetailsScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  Map<String, dynamic>? _asset;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAssetDetails();
  }

  Future<void> _fetchAssetDetails() async {
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
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'équipement'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    'Erreur: $_errorMessage',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : _asset == null
                  ? const Center(child: Text('Aucun détail trouvé.'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          Text(
                            _asset!['name'] ?? 'Sans nom',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow('Fabricant', _asset!['manufacturer']),
                          _buildDetailRow('Modèle', _asset!['model']),
                          _buildDetailRow('Numéro de série', _asset!['serial_number']),
                          _buildDetailRow('Emplacement', _asset!['location']),
                          _buildDetailRow('État', _asset!['status']),
                          const SizedBox(height: 16),
                          const Divider(),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _asset!['description'] ?? 'Aucune description.',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? '—',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
