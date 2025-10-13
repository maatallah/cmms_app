import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAssets() async {
    final response = await _supabase.from('assets').select('*');
    return (response as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>?> getAssetById(int id) async {
    final response =
        await _supabase.from('assets').select('*').eq('id', id).maybeSingle();
    return response;
  }

  Future<void> addAsset(Map<String, dynamic> assetData) async {
    await _supabase.from('assets').insert(assetData);
  }

  Future<void> updateAsset(int id, Map<String, dynamic> updates) async {
    await _supabase.from('assets').update(updates).eq('id', id);
  }

  Future<void> deleteAsset(int id) async {
    await _supabase.from('assets').delete().eq('id', id);
  }
}
