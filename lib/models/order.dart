// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rest_list_pos/helpers/formmaters.dart';
import 'package:rest_list_pos/models/order/order_item.dart';
import 'package:rest_list_pos/models/order/order_sub_status.dart';
import 'package:rest_list_pos/models/order_note.dart';
import 'package:collection/collection.dart';

import 'order_status.dart';
import 'tax.dart';

typedef OredersList = List<AppOrder>;

class AppOrder {
  final int id;
  final String orderNumber;
  final String uuid;
  final OrderStatus status;
  final double taxAmount;
  final double subTotal;
  final double total;
  final int tableId;
  final String tableName;
  final int restaurantId;
  final bool isRead;
  final int? staffId;
  final String? staffName;
  final List<Tax> taxes;
  final DateTime createdAt;
  final String createdAt2;
  final String updatedAt;
  final String updatedAt2;
  final List<OrderNote> notes;
  final List<OrderItem> orderItems;
  final List<OrderSubStatus> statuses;
  AppOrder({
    required this.id,
    required this.orderNumber,
    required this.uuid,
    required this.status,
    required this.taxAmount,
    required this.subTotal,
    required this.total,
    required this.tableId,
    required this.tableName,
    required this.restaurantId,
    required this.isRead,
    this.staffId,
    this.staffName,
    required this.taxes,
    required this.createdAt,
    required this.createdAt2,
    required this.updatedAt,
    required this.updatedAt2,
    required this.notes,
    required this.orderItems,
    required this.statuses,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_number': orderNumber,
      'uuid': uuid,
      'status': status,
      'tax_amount': taxAmount,
      'sub_total': subTotal,
      'total': total,
      'table_id': tableId,
      'table_name': tableName,
      'restaurant_id': restaurantId,
      'is_read': isRead,
      'staff_id': staffId,
      'staff_name': staffName,
      'taxes': taxes.map((x) => x.toMap()).toList(),
      'created_at': createdAt,
      'created_at2': createdAt2,
      'updated_at': updatedAt,
      'updated_at2': updatedAt2,
      'notes': notes.map((e) => e.toMap()).toList(),
    };
  }

  factory AppOrder.fromMap(Map<String, dynamic> map) {
    final taxList = map['taxes'] as List<dynamic>?;
    final notesList = map['notes'] as List<dynamic>?;
    final itemsList = map['order_details'] as List<dynamic>?;
    final statusesList = map['statuses'] as List<dynamic>?;

    return AppOrder(
      id: map['id'] as int,
      orderNumber: map['order_number'] as String,
      uuid: map['uuid'] as String,
      status: OrderStatus.fromString(map['status'] as String),
      taxAmount: map["tax_amount"] is int
          ? (map['tax_amount'] as int).toDouble()
          : map["tax_amount"],
      subTotal: map["sub_total"] is int
          ? (map['sub_total'] as int).toDouble()
          : map["sub_total"],
      total:
          map["total"] is int ? (map['total'] as int).toDouble() : map["total"],
      tableId: map['table_id'] as int,
      tableName: map['table_name'] as String,
      restaurantId: map['restaurant_id'] as int,
      isRead: (map['is_read'] as int) == 1,
      staffId: map['staff_id'] != null ? map['staff_id'] as int : null,
      staffName: map['staff_name'] != null ? map['staff_name'] as String : null,
      taxes: taxList == null
          ? []
          : List<Tax>.from(
              taxList.map<Tax>(
                (x) => Tax.fromMap(x as Map<String, dynamic>),
              ),
            ),
      notes: notesList == null
          ? []
          : List<OrderNote>.from(
              notesList.map<OrderNote>(
                (e) => OrderNote.fromMap(e as Map<String, dynamic>),
              ),
            ),
      orderItems: itemsList == null
          ? []
          : List<OrderItem>.from(
              itemsList.map(
                (e) => OrderItem.fromMap(e as Map<String, dynamic>),
              ),
            ),
      statuses: statusesList == null
          ? []
          : List<OrderSubStatus>.from(
              statusesList.map(
                (e) => OrderSubStatus.fromMap(e as Map<String, dynamic>),
              ),
            ),
      createdAt: Formatters.dateFrom(map['created_at'] as String),
      createdAt2: map['created_at2'] as String,
      updatedAt: map['updated_at'] as String,
      updatedAt2: map['updated_at2'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppOrder.fromJson(String source) =>
      AppOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(orderNumber: $orderNumber, status: $status, tableName: $tableName)';
  }
}

extension OrderCalculatedProps on AppOrder {
  String get notesTitle {
    if (notes.isNotEmpty) {
      return 'General Notes x ${notes.length.toString()}';
    } else {
      return 'General Notes';
    }
  }

  String get itemsTitle {
    if (orderItems.isNotEmpty) {
      return 'Items x ${orderItems.length.toString()}';
    } else {
      return 'Items';
    }
  }

  List<String> get orderedTimes {
    return (statuses
            .where((element) => element.status == OrderSubStatusType.ordered))
        .toList()
        .map((e) => Formatters.timePresenter.format(e.createdAt))
        .toList();
  }

  List<String> get deliveredTimes {
    return (statuses
            .where((element) => element.status == OrderSubStatusType.delivered))
        .toList()
        .map((e) => Formatters.timePresenter.format(e.createdAt))
        .toList();
  }

  List<String> get closedTimes {
    return (statuses
            .where((element) => element.status == OrderSubStatusType.closed))
        .toList()
        .map((e) => Formatters.timePresenter.format(e.createdAt))
        .toList();
  }

  bool get hasNewItems {
    final temp =
        orderItems.firstWhereOrNull((element) => element.isRead == false);
    return temp != null;
  }

  bool get hasNewNotes {
    final temp = notes.firstWhereOrNull((element) => element.isRead == false);
    return temp != null;
  }
}

extension OrderDummyData on AppOrder {
  static List<AppOrder> dummyData() {
    const dummy = [
      {
        "id": 195,
        "order_number": "11",
        "uuid": "94f48050-caf7-49df-9d0d-b797733f36b2",
        "status": "preparing",
        "tax_amount": 1.34,
        "sub_total": 26.4,
        "total": 27.74,
        "table_id": 31,
        "table_name": "r",
        "restaurant_id": 18,
        "staff_id": null,
        "is_read": 0,
        "staff_name": "Tahseen",
        "notes": [],
        "taxes": [
          {"id": 8, "name": "", "type": "percentage", "value": 8},
          {"id": 9, "name": "dsf", "type": "percentage", "value": 2},
          {"id": 10, "name": "dsf", "type": "percentage", "value": 2}
        ],
        "created_at": "13/12/2022 - 12:15 PM",
        "updated_at": "13/12/2022 - 12:22 PM",
        "created_at2": "5 days ago",
        "updated_at2": "2022-12-13T12:22:32.000000Z"
      },
      {
        "id": 195,
        "order_number": "11",
        "uuid": "94f48050-caf7-49df-9d0d-b797733f36b2",
        "status": "closed",
        "tax_amount": 1.34,
        "sub_total": 26.4,
        "total": 27.74,
        "table_id": 31,
        "table_name": "r",
        "restaurant_id": 18,
        "staff_id": null,
        "is_read": 0,
        "staff_name": "Tahseen",
        "notes": [],
        "taxes": [
          {"id": 8, "name": "", "type": "percentage", "value": 8},
          {"id": 9, "name": "dsf", "type": "percentage", "value": 2},
          {"id": 10, "name": "dsf", "type": "percentage", "value": 2}
        ],
        "created_at": "13/12/2022 - 12:15 PM",
        "updated_at": "13/12/2022 - 12:22 PM",
        "created_at2": "5 days ago",
        "updated_at2": "2022-12-13T12:22:32.000000Z"
      },
      {
        "id": 195,
        "order_number": "11",
        "uuid": "94f48050-caf7-49df-9d0d-b797733f36b2",
        "status": "canceled",
        "tax_amount": 1.34,
        "sub_total": 26.4,
        "total": 27.74,
        "table_id": 31,
        "table_name": "r",
        "restaurant_id": 18,
        "staff_id": null,
        "is_read": 0,
        "staff_name": "John Doe",
        "notes": [],
        "taxes": [
          {"id": 8, "name": "", "type": "percentage", "value": 8},
          {"id": 9, "name": "dsf", "type": "percentage", "value": 2},
          {"id": 10, "name": "dsf", "type": "percentage", "value": 2}
        ],
        "created_at": "13/12/2022 - 12:15 PM",
        "updated_at": "13/12/2022 - 12:22 PM",
        "created_at2": "5 days ago",
        "updated_at2": "2022-12-13T12:22:32.000000Z"
      },
      {
        "id": 195,
        "order_number": "11",
        "uuid": "94f48050-caf7-49df-9d0d-b797733f36b2",
        "status": "delivered",
        "tax_amount": 1.34,
        "sub_total": 26.4,
        "total": 27.74,
        "table_id": 31,
        "table_name": "r",
        "restaurant_id": 18,
        "staff_id": null,
        "is_read": 0,
        "staff_name": null,
        "notes": [],
        "taxes": [
          {"id": 8, "name": "", "type": "percentage", "value": 8},
          {"id": 9, "name": "dsf", "type": "percentage", "value": 2},
          {"id": 10, "name": "dsf", "type": "percentage", "value": 2}
        ],
        "created_at": "13/12/2022 - 12:15 PM",
        "updated_at": "13/12/2022 - 12:22 PM",
        "created_at2": "5 days ago",
        "updated_at2": "2022-12-13T12:22:32.000000Z"
      }
    ];

    final temp = dummy.map((e) => AppOrder.fromMap(e)).toList();
    return temp;
  }

  static AppOrder details() {
    const dummy = {
      "id": 196,
      "order_number": "12",
      "uuid": "001cf206-c8ac-4779-955a-379a75c4310f",
      "status": "preparing",
      "tax_amount": 13.31,
      "sub_total": 55.2,
      "total": 68.51,
      "table_id": 31,
      "table_name": "r",
      "restaurant_id": 18,
      "staff_id": 179,
      "is_read": 0,
      "staff_name": 'new staff 01',
      "order_details": [
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
        },
        {
          "id": 707,
          "order_id": 196,
          "product_id": 136,
          "product_name": "Coffee",
          "product_size": "Beaker",
          "quantity": 3,
          "price": 9.2,
          "status": "preparing",
          "note": [],
          "is_read": 0,
          "created_at": "2022-12-20T07:44:38.000000Z",
          "updated_at": "2022-12-20T07:44:38.000000Z",
          "category_name": "Hot Drinks",
          "parent_category_name": "Drinks"
        }
      ],
      "notes": [
        {
          "id": 139,
          "note": "dd",
          "order_id": 196,
          "is_read": 0,
          "created_at": "2022-12-20T07:44:33.000000Z",
          "updated_at": "2022-12-20T07:44:33.000000Z"
        },
        {
          "id": 140,
          "note": "dd",
          "order_id": 196,
          "is_read": 0,
          "created_at": "2022-12-20T07:44:38.000000Z",
          "updated_at": "2022-12-20T07:44:38.000000Z"
        }
      ],
      "taxes": [
        {"id": 8, "name": "", "type": "percentage", "value": 8},
        {"id": 9, "name": "dsf", "type": "percentage", "value": 2},
        {"id": 10, "name": "dsf", "type": "percentage", "value": 2},
        {"id": 12, "name": "new tax", "type": "amount", "value": 10}
      ],
      "statuses": [
        {
          "id": 685,
          "status": "ordered",
          "staff_id": null,
          "order_id": 196,
          "created_at": "20/12/2022 - 07:44 AM",
          "updated_at": "20/12/2022 - 07:44 AM",
          "staff": "restaurant"
        },
        {
          "id": 686,
          "status": "ordered",
          "staff_id": null,
          "order_id": 196,
          "created_at": "20/12/2022 - 07:44 AM",
          "updated_at": "20/12/2022 - 07:44 AM",
          "staff": "restaurant"
        }
      ],
      "created_at": "20/12/2022 - 07:44 AM",
      "updated_at": "20/12/2022 - 07:44 AM",
      "created_at2": "22 hours ago",
      "updated_at2": "2022-12-20T07:44:38.000000Z"
    };

    final order = AppOrder.fromMap(dummy);
    return order;
  }
}
