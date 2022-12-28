// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rest_list_pos/models/order/order_item.dart';
import 'package:rest_list_pos/models/order_note.dart';

final temp = {
  "items": [
    {
      "id": 1,
      "product_id": 1,
      "quantity": 1,
      "notes_removed_ids": [1, 2],
      "notes": [
        {"note": "aaa", "quantity": 2},
        {"note": "aaa", "quantity": 2}
      ]
    }
  ],
  "item_removed_ids": ["order_details id (example 2)"],
  "table_id": 2,
  "notes_removed_ids": [1, 2],
  "notes": [
    {"id": 1, "note": "aaa", "quantity": 2},
    {"note": "aaa", "quantity": 2}
  ]
};

class UpdateOrderItem {
  final int id;
  final int product_id;
  final int quantity;
  final List<int> notes_removed_ids;
  final List<UpdateOrderNote> notes;
  UpdateOrderItem({
    required this.id,
    required this.product_id,
    required this.quantity,
    required this.notes_removed_ids,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': product_id,
      'quantity': quantity,
      'notes_removed_ids': notes_removed_ids,
      'notes': notes.map((x) => x.toMap()).toList(),
    };
  }

  factory UpdateOrderItem.fromMap(Map<String, dynamic> map) {
    return UpdateOrderItem(
      id: map['id'] as int,
      product_id: map['product_id'] as int,
      quantity: map['quantity'] as int,
      notes_removed_ids: map['notes_removed_ids'] as List<int>,
      notes: (map['notes'] as List<dynamic>)
          .map<UpdateOrderNote>(
              (x) => UpdateOrderNote.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateOrderItem.fromJson(String source) =>
      UpdateOrderItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UpdateOrderNote {
  final String note;
  UpdateOrderNote({
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'note': note,
    };
  }

  factory UpdateOrderNote.fromMap(Map<String, dynamic> map) {
    return UpdateOrderNote(
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateOrderNote.fromJson(String source) =>
      UpdateOrderNote.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UpdateOrderBody {
  final List<UpdateOrderItem> items;
  final List<int> itemRemovedIds;
  final int tableId;
  final List<int> notesRemovedIds;
  final List<UpdateOrderNote> notes;

  UpdateOrderBody({
    required this.items,
    required this.itemRemovedIds,
    required this.tableId,
    required this.notesRemovedIds,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((x) => x.toMap()).toList(),
      'item_removed_ids': itemRemovedIds,
      'table_id': tableId,
      'notes_removed_ids': notesRemovedIds,
      'notes': notes.map((x) => x.toMap()).toList(),
    };
  }

  factory UpdateOrderBody.fromMap(Map<String, dynamic> map) {
    return UpdateOrderBody(
      // items: List<OrderItem>.from((map['items'] as List<dynamic>).map<OrderItem>((x) => OrderItem.fromMap(x as Map<String,dynamic>),),),
      items: (map['items'] as List<dynamic>)
          .map((e) => UpdateOrderItem.fromMap(e))
          .toList(),
      notes: (map['notes'] as List<dynamic>)
          .map((e) => UpdateOrderNote.fromMap(e))
          .toList(),
      itemRemovedIds: map['item_removed_ids'] as List<int>,
      tableId: map['table_id'] as int,
      notesRemovedIds: map['notes_removed_ids'] as List<int>,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateOrderBody.fromJson(String source) =>
      UpdateOrderBody.fromMap(json.decode(source) as Map<String, dynamic>);
}
