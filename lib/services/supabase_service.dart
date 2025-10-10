import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import '../models/user.dart';
import '../models/asset.dart';
import '../models/work_order.dart';
import '../models/inventory_item.dart';

class SupabaseService {
  final supa.SupabaseClient _client = supa.Supabase.instance.client;

  // ---------------- Users ----------------
  Future<List<User>> getUsers() async {
    final response = await _client.from('users').select().get();
    if (response.error != null) {
      throw response.error!;
    }
    return (response.data as List)
        .map((e) => User.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ---------------- Assets ----------------
  Future<List<Asset>> getAssets() async {
    final response = await _client.from('assets').select().get();
    if (response.error != null) throw response.error!;
    return (response.data as List)
        .map((e) => Asset.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ---------------- Work Orders ----------------
  Future<List<WorkOrder>> getWorkOrders() async {
    final response = await _client.from('work_orders').select().get();
    if (response.error != null) throw response.error!;
    return (response.data as List)
        .map((e) => WorkOrder.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ---------------- Inventory ----------------
  Future<List<InventoryItem>> getInventory() async {
    final response = await _client.from('inventory').select().get();
    if (response.error != null) throw response.error!;
    return (response.data as List)
        .map((e) => InventoryItem.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ---------------- Count helpers ----------------
  Future<int> getUsersCount() async {
    final response =
        await _client.from('users').select('id', count: 'exact').get();
    if (response.error != null) throw response.error!;
    return response.count ?? 0;
  }

  Future<int> getAssetsCount() async {
    final response =
        await _client.from('assets').select('id', count: 'exact').get();
    if (response.error != null) throw response.error!;
    return response.count ?? 0;
  }

  Future<int> getWorkOrdersCount() async {
    final response =
        await _client.from('work_orders').select('id', count: 'exact').get();
    if (response.error != null) throw response.error!;
    return response.count ?? 0;
  }

  Future<int> getInventoryCount() async {
    final response =
        await _client.from('inventory').select('id', count: 'exact').get();
    if (response.error != null) throw response.error!;
    return response.count ?? 0;
  }
}
