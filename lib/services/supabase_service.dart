import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  // 🔹 Fetch all users
  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await supabase.from('users').select();
    return response as List<Map<String, dynamic>>;
  }

  // 🔹 Fetch one user by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final response = await supabase.from('users').select().eq('id', id).maybeSingle();
    return response as Map<String, dynamic>?;
  }

  // 🔹 Fetch all work orders
  Future<List<Map<String, dynamic>>> getWorkOrders() async {
    final response = await supabase.from('work_orders').select().order('created_at', ascending: false);
    return response as List<Map<String, dynamic>>;
  }

  // 🔹 Fetch one work order
  Future<Map<String, dynamic>?> getWorkOrderById(int id) async {
    final response = await supabase.from('work_orders').select().eq('id', id).maybeSingle();
    return response as Map<String, dynamic>?;
  }

  // 🔹 Fetch all assets (équipements)
  Future<List<Map<String, dynamic>>> getAssets() async {
    final response = await supabase.from('assets').select().order('name');
    return response as List<Map<String, dynamic>>;
  }

  // 🔹 Fetch all inventory items
  Future<List<Map<String, dynamic>>> getInventoryItems() async {
    final response = await supabase.from('inventory_items').select();
    return response as List<Map<String, dynamic>>;
  }

  // 🔹 Count of inventory items (using FetchOptions)
  Future<int> getInventoryCount() async {
    final result = await supabase
        .from('inventory_items')
        .select('*', const FetchOptions(count: CountOption.exact));
    return result.count ?? 0;
  }

  // 🔹 Insert a new user
  Future<Map<String, dynamic>> insertUser(Map<String, dynamic> data) async {
    final response = await supabase.from('users').insert(data).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // 🔹 Insert a new work order
  Future<Map<String, dynamic>> insertWorkOrder(Map<String, dynamic> data) async {
    final response = await supabase.from('work_orders').insert(data).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // 🔹 Insert a new asset
  Future<Map<String, dynamic>> insertAsset(Map<String, dynamic> data) async {
    final response = await supabase.from('assets').insert(data).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // 🔹 Update user
  Future<Map<String, dynamic>> updateUser(int id, Map<String, dynamic> data) async {
    final response = await supabase.from('users').update(data).eq('id', id).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // 🔹 Update work order
  Future<Map<String, dynamic>> updateWorkOrder(int id, Map<String, dynamic> data) async {
    final response = await supabase.from('work_orders').update(data).eq('id', id).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // 🔹 Update asset
  Future<Map<String, dynamic>> updateAsset(int id, Map<String, dynamic> data) async {
    final response = await supabase.from('assets').update(data).eq('id', id).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // 🔹 Delete user
  Future<void> deleteUser(int id) async {
    await supabase.from('users').delete().eq('id', id);
  }

  // 🔹 Delete work order
  Future<void> deleteWorkOrder(int id) async {
    await supabase.from('work_orders').delete().eq('id', id);
  }

  // 🔹 Delete asset
  Future<void> deleteAsset(int id) async {
    await supabase.from('assets').delete().eq('id', id);
  }
}
