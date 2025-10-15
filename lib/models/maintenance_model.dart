class Maintenance {
  final String id;
  final String assetId;
  final String type;
  final String status;
  final DateTime date;

  Maintenance({
    required this.id,
    required this.assetId,
    required this.type,
    required this.status,
    required this.date,
  });

  factory Maintenance.fromMap(Map<String, dynamic> map) {
    return Maintenance(
      id: map['id'] ?? '',
      assetId: map['asset_id'] ?? '',
      type: map['type'] ?? 'Inconnu',
      status: map['status'] ?? 'Non défini',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'asset_id': assetId,
      'type': type,
      'status': status,
      'date': date.toIso8601String(),
    };
  }
}
