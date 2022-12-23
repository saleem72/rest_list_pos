//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/dashboard_bloc/dashboard_bloc.dart';
import 'add_edit_order/add_new_order_view.dart';
import 'product_details.dart';

// AddEditOrderView
class AddEditOrderView extends StatelessWidget {
  const AddEditOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return state.activeProduct == null
            ? const AddNewOrderView()
            : ProductDetails(product: state.activeProduct!);
      },
    );
  }
}
