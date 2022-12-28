// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'orders_bloc.dart';

enum OrderVisibility { details, items, notes }

@immutable
class OrdersState extends Equatable {
  const OrdersState({
    this.selctedOrder,
    this.orderVisibility,
    this.orderToEdit,
    this.version = 1,
  });
  final AppOrder? selctedOrder;
  final OrderVisibility? orderVisibility;
  final AppOrderViewModel? orderToEdit;
  final int version;

  @override
  List<Object?> get props =>
      [selctedOrder, orderVisibility, orderToEdit, version];

  OrdersState copyWith({
    AppOrder? selctedOrder,
    OrderVisibility? orderVisibility,
    AppOrderViewModel? orderToEdit,
    int? version,
  }) {
    return OrdersState(
      selctedOrder: selctedOrder ?? this.selctedOrder,
      orderVisibility: orderVisibility ?? this.orderVisibility,
      orderToEdit: orderToEdit ?? this.orderToEdit,
      version: version ?? this.version,
    );
  }

  OrdersState clearVisibility() {
    return OrdersState(
      selctedOrder: selctedOrder,
      orderToEdit: orderToEdit,
      orderVisibility: null,
      version: version,
    );
  }
}
