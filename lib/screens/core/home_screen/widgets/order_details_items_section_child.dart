//

import 'package:flutter/material.dart';

import '../../../../helpers/formmaters.dart';
import '../../../../helpers/styling/styling.dart';
import '../../../../models/order.dart';
import '../../../../models/order/order_item.dart';

class OrderDetailsItemsSectionChild extends StatelessWidget {
  const OrderDetailsItemsSectionChild({
    super.key,
    required this.order,
  });
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          order.orderItems.map((e) => OrderDetailsItemTile(item: e)).toList(),
    );
  }
}

class OrderDetailsItemTile extends StatelessWidget {
  const OrderDetailsItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  final OrderItem item;
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: item.productName,
                      style: style?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: item.isRead
                            ? Pallet.darkAppBar
                            : const Color(0xFF00B4CB),
                      ),
                    ),
                    TextSpan(
                      text: ' X ${item.quantity.toString()}',
                      style: style?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Pallet.darkAppBar,
                      ),
                    )
                  ],
                ),
              ),
              Text(Formatters.currencyFormater.format(item.price)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // children: item.note.map((e) => Text(e.note)).toList(),
            children: [
              const SizedBox(height: 8),
              Text(item.productSize),
            ],
          ),
        ],
      ),
    );
  }
}
