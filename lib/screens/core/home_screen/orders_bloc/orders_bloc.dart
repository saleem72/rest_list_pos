import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rest_list_pos/helpers/dashboard_bloc/dashboard_bloc.dart';

import '../../../../models/order.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({
    required DashboardBloc dashboard,
  })  : _dashboard = dashboard,
        super(const OrdersState()) {
    on<OrdersBlocSetActiveOrder>(_onSetActiveOrder);
    on<OrdersBlocClearActiveOrder>(_onClearActiveProduct);
    on<OrdersBlocSetVisibility>(_onSetVisibility);
  }

  final DashboardBloc _dashboard;

  _onSetActiveOrder(OrdersBlocSetActiveOrder event, Emitter<OrdersState> emit) {
    final order = OrderDummyData.details();
    emit(state.copyWith(selctedOrder: order));
  }

  _onClearActiveProduct(
      OrdersBlocClearActiveOrder event, Emitter<OrdersState> emit) {
    emit(const OrdersState());
  }

  _onSetVisibility(OrdersBlocSetVisibility event, Emitter<OrdersState> emit) {
    if (state.orderVisibility == event.visibility) {
      emit(state.clearVisibility());
    } else {
      emit(state.copyWith(orderVisibility: event.visibility));
    }
  }
}
