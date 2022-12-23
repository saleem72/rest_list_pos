// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'orders_bloc.dart';

enum OrderVisibility { details, items, notes }

@immutable
class OrdersState extends Equatable {
  const OrdersState({
    this.selctedOrder,
    this.orderVisibility,
  });
  final AppOrder? selctedOrder;
  final OrderVisibility? orderVisibility;

  @override
  List<Object?> get props => [selctedOrder, orderVisibility];

  OrdersState copyWith({
    AppOrder? selctedOrder,
    OrderVisibility? orderVisibility,
  }) {
    return OrdersState(
      selctedOrder: selctedOrder ?? this.selctedOrder,
      orderVisibility: orderVisibility ?? this.orderVisibility,
    );
  }

  OrdersState clearVisibility() {
    return OrdersState(
      selctedOrder: selctedOrder,
      orderVisibility: null,
    );
  }
}
