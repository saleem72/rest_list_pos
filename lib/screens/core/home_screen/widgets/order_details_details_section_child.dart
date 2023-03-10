//

import 'package:flutter/material.dart';

import '../../../../helpers/formmaters.dart';
import '../../../../helpers/styling/styling.dart';
import '../../../../models/order.dart';
import '../../../../models/order_status.dart';

class OrderDetailsDetailsSectionChild extends StatelessWidget {
  const OrderDetailsDetailsSectionChild({
    super.key,
    required this.order,
  });
  final AppOrder order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        _tableName(context),
        const SizedBox(height: 16),
        _createdBy(context),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            children: [
              StatusProgress(
                label: 'Ordered',
                color: Pallet.darkAppBar,
                steps: order.orderedTimes,
              ),
              const SizedBox(width: 16),
              StatusProgress(
                label: 'Delivered',
                color: OrderStatus.delivered.color,
                steps: order.deliveredTimes,
              ),
              const SizedBox(width: 16),
              StatusProgress(
                label: 'Closed',
                color: OrderStatus.closed.color,
                steps: order.closedTimes,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _createdBy(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Pallet.cardColors,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Created By',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Pallet.textGrey,
                    ),
              ),
              Text(
                '${order.staffName ?? ''} ${Formatters.datePresenter.format(order.createdAt)}',
                // '${order.staffName ?? ''} ${order.createdAt}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Closed By',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Pallet.textGrey,
                    ),
              ),
              Text(
                '${order.staffName ?? ''} ${Formatters.datePresenter.format(order.createdAt)}',
                // '${order.staffName ?? ''} ${order.createdAt}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _tableName(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Pallet.cardColors,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(order.tableName),
          Text(
            order.status.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: order.status.color,
                ),
          ),
        ],
      ),
    );
  }
}

class StatusProgress extends StatelessWidget {
  const StatusProgress({
    Key? key,
    required this.label,
    required this.steps,
    this.color = Colors.black,
  }) : super(key: key);
  final String label;
  final List<String> steps;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Pallet.cardColors, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: steps.map((e) {
            return Column(
              children: [
                Text(
                  e,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList()
            ..insert(
                0,
                Column(
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: color,
                          ),
                    ),
                    const SizedBox(height: 8),
                  ],
                )),
        ),
      ),
    );
  }
}
