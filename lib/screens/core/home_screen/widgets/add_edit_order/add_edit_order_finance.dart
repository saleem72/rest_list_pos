//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_list_pos/models/app_order_view_model.dart';
import 'package:rest_list_pos/screens/core/home_screen/orders_bloc/orders_bloc.dart';

import '../../../../../helpers/formmaters.dart';

class AddEditOrderFinance extends StatelessWidget {
  const AddEditOrderFinance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return _content(context, state.orderToEdit);
      },
    );
  }

  Card _content(BuildContext context, AppOrderViewModel? order) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _subTotal(context, order),
            const SizedBox(height: 8),
            _tax(context, order),
            const SizedBox(height: 8),
            _total(context, order)
          ],
        ),
      ),
    );
  }

  Row _total(BuildContext context, AppOrderViewModel? order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          Formatters.currencyFormater.format(order?.calcSum ?? 0),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          Formatters.currencyFormater.format(order?.total ?? 0),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Row _tax(BuildContext context, AppOrderViewModel? order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tax',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          Formatters.currencyFormater.format(order?.calcTax ?? 0),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          Formatters.currencyFormater.format(order?.taxAmount ?? 0),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Row _subTotal(BuildContext context, AppOrderViewModel? order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Subtotal',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          Formatters.currencyFormater.format(order?.calcSubTotal ?? 0),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          Formatters.currencyFormater.format(order?.subTotal ?? 0),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
