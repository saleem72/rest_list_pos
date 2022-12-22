//

import 'package:rest_list_pos/helpers/formmaters.dart';

enum OrderSubStatusType {
  ordered,
  delivered,
  closed,
  canceled;

  String get title {
    switch (this) {
      case OrderSubStatusType.ordered:
        return 'ordered';
      case OrderSubStatusType.delivered:
        return 'delivered';
      case OrderSubStatusType.closed:
        return 'closed';
      case OrderSubStatusType.canceled:
        return 'canceled';
    }
  }

  static OrderSubStatusType fromString(String value) {
    switch (value) {
      case 'ordered':
        return OrderSubStatusType.ordered;
      case 'delivered':
        return OrderSubStatusType.delivered;
      case 'closed':
        return OrderSubStatusType.closed;
      case 'canceled':
        return OrderSubStatusType.canceled;
      default:
        return OrderSubStatusType.ordered;
    }
  }
}

class OrderSubStatus {
  final int id;
  final OrderSubStatusType status; //
  final int orderId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? staffId;
  final String staff;

  const OrderSubStatus({
    required this.id,
    required this.status,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    this.staffId,
    required this.staff,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'order_id': orderId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'staff_id': staffId,
      'staff': staff,
    };
  }

  factory OrderSubStatus.fromMap(Map<String, dynamic> map) {
    return OrderSubStatus(
      id: map['id'] as int,
      status: OrderSubStatusType.fromString(map['status'] as String),
      orderId: map['order_id'] as int,
      createdAt: Formatters.dateFrom(
          map['created_at']), //.da(map['created_at'] as String),
      updatedAt: Formatters.dateFrom(map['updated_at'] as String),
      staffId: map['staff_id'] != null ? map['staff_id'] as int : null,
      staff: map['staff'] as String,
    );
  }
}

/*
{
    "id": 686,
    "status": "ordered",
    "staff_id": null,
    "order_id": 196,
    "created_at": "20/12/2022 - 07:44 AM",
    "updated_at": "20/12/2022 - 07:44 AM",
    "staff": "restaurant"
}
*/
