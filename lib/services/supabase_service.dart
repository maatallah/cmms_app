import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cmms_app/models/user.dart' as app_models;
import 'package:cmms_app/models/asset.dart';
import 'package:cmms_app/models/inventory.dart';
import 'package:cmms_app/models/work_order.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // ================= USERS =================
  Future<List<app_models.User>> getUsers() async {
    final response = await _client.from('users').select();
    return (response as List)
        .map((e) => app_models.User.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ================= ASSETS =================
  Future<List<Asset>> getAssets() async {
    final response = await _client
        .from('assets')
        .select()
        .order('created_at', ascending: false);
    return (response as List)
        .map((e) => Asset.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ================= INVENTORY =================
  Future<List<Inventory>> getInventory() async {
    final response = await _client
        .from('inventory')
        .select()
        .order('created_at', ascending: false);
    return (response as List)
        .map((e) => Inventory.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ================= WORK ORDERS =================
  Future<List<WorkOrder>> getWorkOrders() async {
    final response = await _client
        .from('work_orders')
        .select()
        .order('created_at', ascending: false);
    return (response as List)
        .map((e) => WorkOrder.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
