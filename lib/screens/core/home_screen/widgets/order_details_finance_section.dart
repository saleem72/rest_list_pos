//

import 'package:flutter/material.dart';

import '../../../../helpers/formmaters.dart';
import '../../../../models/order.dart';

class OrderDetailsFinanceSection extends StatelessWidget {
  const OrderDetailsFinanceSection({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _subTotal(context),
          const SizedBox(height: 8),
          _tax(context),
          const SizedBox(height: 8),
          _total(context)
        ],
      ),
    );
  }

  Row _total(BuildContext context) {
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
          Formatters.currencyFormater.format(order.total),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Row _tax(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tax',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          Formatters.currencyFormater.format(order.taxAmount),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Row _subTotal(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Subtotal',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          Formatters.currencyFormater.format(order.subTotal),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
