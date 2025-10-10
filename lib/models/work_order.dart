import 'dart:convert';

class WorkOrder {
  final String id;
  final String title;
  final String? status;
  final DateTime? orderDate;
  final DateTime? doneDate;
  final DateTime? createdAt;

  WorkOrder({
    required this.id,
    required this.title,
    this.status,
    this.orderDate,
    this.doneDate,
    this.createdAt,
  });

  factory WorkOrder.fromJson(Map<String, dynamic> json) => WorkOrder(
        id: json['id'],
        title: json['title'],
        status: json['status'],
        orderDate: json['order_date'] != null
            ? DateTime.parse(json['order_date'])
            : null,
        doneDate:
            json['done_date'] != null ? DateTime.parse(json['done_date']) : null,
        createdAt:
            json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'status': status,
        'order_date': orderDate?.toIso8601String(),
        'done_date': doneDate?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
      };
}
