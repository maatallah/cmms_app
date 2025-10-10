import 'package:flutter/material.dart';
import 'package:cmms_app/services/supabase_service.dart';
import 'package:cmms_app/models/asset.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  late Future<List<Asset>> _assetsFuture;

  @override
  void initState() {
    super.initState();
    _assetsFuture = SupabaseService().getAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Équipements"),
      ),
      body: FutureBuilder<List<Asset>>(
        future: _assetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun équipement trouvé."));
          }

          final assets = snapshot.data!;
          return ListView.separated(
            itemCount: assets.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final asset = assets[index];
              return ListTile(
                leading: const Icon(Icons.build_circle, color: Colors.blue),
                title: Text(asset.name),
                subtitle: Text(
                  "${asset.manufacturer ?? 'N/A'} - ${asset.model ?? 'N/A'}",
                ),
                trailing: Text(
                  "Achat: ${asset.purchaseDate?.toString().split(' ').first ?? '-'}",
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
