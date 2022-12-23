// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersBlocSetActiveOrder extends OrdersEvent {
  final AppOrder order;

  const OrdersBlocSetActiveOrder({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class OrdersBlocClearActiveOrder extends OrdersEvent {}

class OrdersBlocSetVisibility extends OrdersEvent {
  final OrderVisibility visibility;

  const OrdersBlocSetVisibility({
    required this.visibility,
  });

  @override
  List<Object> get props => [visibility];
}
