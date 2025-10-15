class Asset {
  final String id; // UUID
  final String name;
  final String? manufacturer;
  final String? model;
  final String? purchaseDate;
  final String? warrantyEnd;
  final String? createdAt;

  Asset({
    required this.id,
    required this.name,
    this.manufacturer,
    this.model,
    this.purchaseDate,
    this.warrantyEnd,
    this.createdAt,
  });

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Sans nom',
      manufacturer: map['manufacturer'],
      model: map['model'],
      purchaseDate: map['purchase_date'],
      warrantyEnd: map['warranty_end'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'model': model,
      'purchase_date': purchaseDate,
      'warranty_end': warrantyEnd,
      'created_at': createdAt,
    };
  }
}
