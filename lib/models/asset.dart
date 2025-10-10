class Asset {
  final String id;
  final String name;
  final String? manufacturer;
  final String? model;
  final DateTime? purchaseDate;
  final DateTime? warrantyEnd;
  final DateTime? createdAt;

  Asset({
    required this.id,
    required this.name,
    this.manufacturer,
    this.model,
    this.purchaseDate,
    this.warrantyEnd,
    this.createdAt,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as String,
      name: json['name'] as String,
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      purchaseDate:
          json['purchase_date'] != null ? DateTime.parse(json['purchase_date']) : null,
      warrantyEnd:
          json['warranty_end'] != null ? DateTime.parse(json['warranty_end']) : null,
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'model': model,
      'purchase_date': purchaseDate?.toIso8601String(),
      'warranty_end': warrantyEnd?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
