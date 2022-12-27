// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'order.dart';
import 'order/order_item.dart';

class AppOrderViewModel extends Equatable {
  final AppOrder? order;
  final bool isNew;
  final int tableId;
  final String tableName;
  final int waiterId;
  final String waiterName;
  final String orderNumber;
  final double subTotal;
  final double taxAmount;
  final double total;
  final int id;
  final List<OrderItemViewModel> orderItems;
  final int version;
  const AppOrderViewModel({
    this.order,
    required this.isNew,
    required this.tableId,
    required this.tableName,
    required this.waiterId,
    required this.waiterName,
    required this.orderNumber,
    required this.subTotal,
    required this.taxAmount,
    required this.total,
    required this.id,
    required this.orderItems,
    this.version = 1,
  });

  factory AppOrderViewModel.fromModel(AppOrder model) {
    return AppOrderViewModel(
      isNew: false,
      tableId: model.tableId,
      tableName: model.tableName,
      waiterId: model.staffId ?? 0,
      waiterName: model.staffName ?? '',
      orderNumber: model.orderNumber,
      subTotal: model.subTotal,
      taxAmount: model.taxAmount,
      total: model.total,
      id: model.id,
      orderItems:
          model.orderItems.map((e) => OrderItemViewModel.fromModel(e)).toList(),
      version: 1,
    );
  }

  @override
  List<Object?> get props => [
        isNew,
        tableId,
        tableName,
        waiterId,
        waiterName,
        orderNumber,
        subTotal,
        taxAmount,
        total,
        id,
        orderItems,
        version,
      ];

  AppOrderViewModel copyWith({
    AppOrder? order,
    bool? isNew,
    int? tableId,
    String? tableName,
    int? waiterId,
    String? waiterName,
    String? orderNumber,
    double? subTotal,
    double? taxAmount,
    double? total,
    int? id,
    List<OrderItemViewModel>? orderItems,
  }) {
    return AppOrderViewModel(
      order: order ?? this.order,
      isNew: isNew ?? this.isNew,
      tableId: tableId ?? this.tableId,
      tableName: tableName ?? this.tableName,
      waiterId: waiterId ?? this.waiterId,
      waiterName: waiterName ?? this.waiterName,
      orderNumber: orderNumber ?? this.orderNumber,
      subTotal: subTotal ?? this.subTotal,
      taxAmount: taxAmount ?? this.taxAmount,
      total: total ?? this.total,
      id: id ?? this.id,
      orderItems: orderItems ?? this.orderItems,
      version: version + 1,
    );
  }
}

@immutable
class OrderItemViewModel extends Equatable {
  final OrderItem? item;
  final int id;
  final int productId;
  final String productName;
  final String productSize;
  final int quantity;
  final double price;

  const OrderItemViewModel({
    this.item,
    required this.id,
    required this.productId,
    required this.productName,
    required this.productSize,
    required this.quantity,
    required this.price,
  });

  factory OrderItemViewModel.fromModel(OrderItem model) {
    return OrderItemViewModel(
      item: model,
      id: model.id,
      productId: model.productId,
      productName: model.productName,
      productSize: model.productSize,
      quantity: model.quantity,
      price: model.price,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        productSize,
        quantity,
        price,
      ];

  OrderItemViewModel copyWith({
    OrderItem? item,
    int? id,
    int? productId,
    String? productName,
    String? productSize,
    int? quantity,
    double? price,
  }) {
    return OrderItemViewModel(
      item: item ?? this.item,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSize: productSize ?? this.productSize,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
