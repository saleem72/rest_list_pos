//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../orders_bloc/orders_bloc.dart';
import 'add_edit_order/add_new_order_view.dart';
import 'add_edit_order/order_odification_view.dart';

// AddEditOrderView
class AddEditOrderView extends StatelessWidget {
  const AddEditOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<OrdersBloc, OrdersState>(
    //   builder: (context, state) {
    //     return state.orderToEdit == null
    //         ? const AddNewOrderView()
    //         : OrderModificationView(order: state.orderToEdit!);
    //   },
    // );

    return const AddNewOrderView();
  }
}
