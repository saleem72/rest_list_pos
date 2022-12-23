import 'package:equatable/equatable.dart';

class OrderNote extends Equatable {
  final int id;
  final String note;
  final int orderId;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OrderNote({
    required this.id,
    required this.note,
    required this.orderId,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'note': note,
      'order_id': orderId,
      'is_read': isRead,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory OrderNote.fromMap(Map<String, dynamic> map) {
    return OrderNote(
      id: map['id'] as int,
      note: map['note'] as String,
      orderId: map['order_id'] as int,
      isRead: (map['is_read'] as int) == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  @override
  String toString() {
    return 'OrderNote(note: $note)';
  }
}
