import 'package:supabase/supabase.dart';

class SupabaseService {
  final SupabaseClient supabase;

  SupabaseService(this.supabase);

  // Example: Get all users
  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await supabase.from('users').select();
    return response as List<Map<String, dynamic>>;
  }

  // Example: Get a single user by id
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final response = await supabase.from('users').select().eq('id', id).maybeSingle();
    return response as Map<String, dynamic>?;
  }

  // Example: Get all work orders
  Future<List<Map<String, dynamic>>> getWorkOrders({int? limit, int? offset}) async {
    var query = supabase.from('work_orders').select();
    if (limit != null) query = query.limit(limit, offset: offset ?? 0);
    final response = await query;
    return response as List<Map<String, dynamic>>;
  }

  // Example: Get inventory items with count
  Future<Map<String, dynamic>> getInventoryItems({int? limit, int? offset}) async {
    final response = await supabase.from('inventory_items').select(
      '*',
      const FetchOptions(count: CountOption.exact),
    ).limit(limit ?? 100, offset: offset ?? 0);

    // The response now contains both data and count
    return {
      'data': response as List<Map<String, dynamic>>,
      'count': response.count,
    };
  }

  // Example: Insert a new work order
  Future<Map<String, dynamic>> addWorkOrder(Map<String, dynamic> data) async {
    final response = await supabase.from('work_orders').insert(data).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // Example: Update a work order by id
  Future<Map<String, dynamic>> updateWorkOrder(int id, Map<String, dynamic> data) async {
    final response = await supabase.from('work_orders').update(data).eq('id', id).select().maybeSingle();
    return response as Map<String, dynamic>;
  }

  // Example: Delete a work order by id
  Future<void> deleteWorkOrder(int id) async {
    await supabase.from('work_orders').delete().eq('id', id);
  }
}
