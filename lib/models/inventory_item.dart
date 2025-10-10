import 'dart:convert';

class InventoryItem {
  final String id;
  final String itemName;
  final int? quantity;
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final DateTime? createdAt;

  InventoryItem({
    required this.id,
    required this.itemName,
    this.quantity,
    this.periodStart,
    this.periodEnd,
    this.createdAt,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        id: json['id'],
        itemName: json['item_name'],
        quantity: json['quantity'],
        periodStart: json['period_start'] != null
            ? DateTime.parse(json['period_start'])
            : null,
        periodEnd:
            json['period_end'] != null ? DateTime.parse(json['period_end']) : null,
        createdAt:
            json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_name': itemName,
        'quantity': quantity,
        'period_start': periodStart?.toIso8601String(),
        'period_end': periodEnd?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
      };
}
