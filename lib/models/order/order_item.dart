//

import 'package:equatable/equatable.dart';
import 'package:rest_list_pos/models/order_note.dart';
import 'package:rest_list_pos/models/order_status.dart';

class OrderItem extends Equatable {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final String productImage;
  final String productSize;
  final int quantity;
  final double price;
  final OrderStatus status;
  final List<OrderNote> note;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryName;
  final String parentCategoryName;

  const OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productSize,
    required this.quantity,
    required this.price,
    required this.status,
    required this.note,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
    required this.parentCategoryName,
    this.productImage = '',
  });

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'product_size': productSize,
      'quantity': quantity,
      'price': price,
      'status': status.toString(),
      'note': note.map((x) => x.toMap()).toList(),
      'is_read': isRead,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'category_name': categoryName,
      'parent_category_name': parentCategoryName,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    final noteList = map['note'] as List<dynamic>?;
    return OrderItem(
      id: map['id'] as int,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      productName: map['product_name'] as String,
      productImage:
          map['product_image'] == null ? '' : map['product_image'] as String,
      productSize: map['product_size'] as String,
      quantity: map['quantity'] as int,
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : map['price'] as double,
      status: OrderStatus.fromString(map['status'] as String),
      note: noteList == null
          ? []
          : List<OrderNote>.from(
              noteList.map<OrderNote>(
                (x) => OrderNote.fromMap(x as Map<String, dynamic>),
              ),
            ),
      isRead: (map['is_read'] as int) == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      categoryName: map['category_name'] as String,
      parentCategoryName: map['parent_category_name'] as String,
    );
  }

  @override
  String toString() {
    return 'OrderItem(orderId: $orderId, productName: $productName, productSize: $productSize)';
  }
}


/*
{
                "id": 706,
                "order_id": 196,
                "product_id": 136,
                "product_name": "Coffee",
                "product_size": "Beaker",
                "quantity": 3,
                "price": 9.2,
                "status": "preparing",
                "note": [],
                "is_read": 0,
                "created_at": "2022-12-20T07:44:33.000000Z",
                "updated_at": "2022-12-20T07:44:33.000000Z",
                "category_name": "Hot Drinks",
                "parent_category_name": "Drinks"
            }
*/