// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rest_list_pos/helpers/formmaters.dart';
import 'package:rest_list_pos/models/order_status.dart';
import 'package:rest_list_pos/models/product.dart';

import 'order.dart';
import 'order/order_item.dart';
import 'tax.dart';

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
      order: model,
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

  AppOrderViewModel addProduct(Product product) {
    return AppOrderViewModel(
      isNew: false,
      order: order,
      tableId: tableId,
      tableName: tableName,
      waiterId: waiterId,
      waiterName: waiterName,
      orderNumber: orderNumber,
      subTotal: subTotal,
      taxAmount: taxAmount,
      total: total,
      id: id,
      orderItems: orderItems..add(OrderItemViewModel.fromProduct(product)),
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

  double get calcSubTotal {
    final sum = orderItems
        .map((e) => e.price * e.quantity)
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element);
    return sum;
  }

  double get calcTax {
    final sub = calcSubTotal;
    final taxSum = order?.taxes
            .map(
                (e) => e.type == TaxType.amount ? e.value : e.value * sub / 100)
            .toList()
            .fold<double>(
                0, (previousValue, element) => previousValue + element) ??
        0;
    return taxSum;
  }

  double get calcSum {
    return calcSubTotal + calcTax;
  }
}

@immutable
class OrderItemViewModel extends Equatable {
  final OrderItem? item;
  final int id;
  final int productId;
  final String productName;
  final String productImage;
  final String productSize;
  final int quantity;
  final double price;
  final OrderStatus status;

  bool get isEditable => status == OrderStatus.preparing;

  const OrderItemViewModel({
    this.item,
    required this.id,
    required this.productId,
    required this.productName,
    required this.productSize,
    required this.quantity,
    required this.price,
    this.status = OrderStatus.preparing,
    this.productImage = '',
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
      status: model.status,
      productImage: model.productImage,
    );
  }

  factory OrderItemViewModel.fromProduct(Product product) {
    return OrderItemViewModel(
      id: 0,
      productId: product.id,
      productName: product.name,
      productSize: product.size ?? '',
      quantity: 1,
      price: product.price ?? 1,
      status: OrderStatus.preparing,
      productImage: product.image ?? '',
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
        status,
      ];

  OrderItemViewModel copyWith({
    OrderItem? item,
    int? id,
    int? productId,
    String? productName,
    String? productSize,
    int? quantity,
    double? price,
    OrderStatus? status,
    String? productImage,
  }) {
    return OrderItemViewModel(
      item: item ?? this.item,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSize: productSize ?? this.productSize,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      status: status ?? this.status,
      productImage: productImage ?? this.productImage,
    );
  }
}
