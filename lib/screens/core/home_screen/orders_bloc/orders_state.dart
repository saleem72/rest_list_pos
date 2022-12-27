// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'orders_bloc.dart';

enum OrderVisibility { details, items, notes }

@immutable
class OrdersState extends Equatable {
  const OrdersState({
    this.selctedOrder,
    this.orderVisibility,
    this.orderToEdit,
  });
  final AppOrder? selctedOrder;
  final OrderVisibility? orderVisibility;
  final AppOrderViewModel? orderToEdit;

  @override
  List<Object?> get props => [selctedOrder, orderVisibility, orderToEdit];

  OrdersState copyWith({
    AppOrder? selctedOrder,
    OrderVisibility? orderVisibility,
    AppOrderViewModel? orderToEdit,
  }) {
    return OrdersState(
      selctedOrder: selctedOrder ?? this.selctedOrder,
      orderVisibility: orderVisibility ?? this.orderVisibility,
      orderToEdit: orderToEdit ?? this.orderToEdit,
    );
  }

  OrdersState clearVisibility() {
    return OrdersState(
      selctedOrder: selctedOrder,
      orderToEdit: orderToEdit,
      orderVisibility: null,
    );
  }
}
