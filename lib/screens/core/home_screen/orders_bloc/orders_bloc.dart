import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rest_list_pos/helpers/dashboard_bloc/dashboard_bloc.dart';
import 'package:rest_list_pos/helpers/pretty_json.dart';
import 'package:rest_list_pos/models/product.dart';
import 'package:rest_list_pos/models/requests_bodies/update_order_body.dart';

import '../../../../models/app_order_view_model.dart';
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
    on<OrdersBlocSetOrderToEdit>(_onSetOrderToEdit);
    on<OrdersBlocIncreaseAmount>(_onIncreaseAmount);
    on<OrdersBlocDecreaseAmount>(_onDecreaseAmount);
    on<OrdersBlocSubmit>(_onSubmit);
    on<OrdersBlocAddNewItem>(_onAddNewItem);
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

  _onSetOrderToEdit(OrdersBlocSetOrderToEdit event, Emitter<OrdersState> emit) {
    emit(state.copyWith(orderToEdit: AppOrderViewModel.fromModel(event.order)));
  }

  _onIncreaseAmount(OrdersBlocIncreaseAmount event, Emitter<OrdersState> emit) {
    if (state.orderToEdit != null) {
      final itemsList = state.orderToEdit!.orderItems;

      final idx = itemsList.indexWhere((element) => element == event.item);

      if (idx != null) {
        final itemToUpdate = itemsList[idx];
        itemsList[idx] =
            itemToUpdate.copyWith(quantity: itemToUpdate.quantity + 1);

        final orderToEdit = state.orderToEdit!.copyWith(
          orderItems: itemsList,
        );
        emit(state.copyWith(orderToEdit: orderToEdit));
      }
    }

    emit(state);
  }

  _onDecreaseAmount(OrdersBlocDecreaseAmount event, Emitter<OrdersState> emit) {
    if (state.orderToEdit != null) {
      final itemsList = state.orderToEdit!.orderItems;

      final idx = itemsList.indexWhere((element) => element == event.item);

      if (idx != null) {
        final itemToUpdate = itemsList[idx];
        if (itemToUpdate.quantity > 1) {
          itemsList[idx] =
              itemToUpdate.copyWith(quantity: itemToUpdate.quantity - 1);

          final orderToEdit = state.orderToEdit!.copyWith(
            orderItems: itemsList,
          );
          emit(state.copyWith(orderToEdit: orderToEdit));
        }
      }
    }

    emit(state);
  }

  _onSubmit(OrdersBlocSubmit event, Emitter<OrdersState> emit) {
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
      "item_removed_ids": [1, 2],
      "table_id": 2,
      "notes_removed_ids": [1, 2],
      "notes": [
        {"id": 1, "note": "aaa", "quantity": 2},
        {"note": "aaa", "quantity": 2}
      ]
    };

    final model = UpdateOrderBody.fromMap(temp);

    final tempjson = model.toJson();
    final aaa = PrettyJson.print(tempjson);
    print(aaa);
  }

  _onAddNewItem(OrdersBlocAddNewItem event, Emitter<OrdersState> emit) {
    // final temp = state.orderToEdit?.addProduct(event.product);
    emit(state.copyWith(
      orderToEdit: state.orderToEdit?.addProduct(event.product),
      version: state.version + 1,
    ));
  }
}
