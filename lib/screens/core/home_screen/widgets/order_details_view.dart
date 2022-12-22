//

import 'package:flutter/material.dart';
import 'package:rest_list_pos/helpers/formmaters.dart';

import '../../../../helpers/styling/styling.dart';
import '../../../../models/order.dart';
import '../../../../models/order/order_item.dart';
import 'categories_add_button.dart';
import 'order_details_details_section_child.dart';
import 'order_details_finance_section.dart';
import 'order_details_items_section_child.dart';
import 'order_details_section_view.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Order.details();
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        SizedBox(
          width: 460,
          height: double.infinity,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Column(
              children: [
                _header(order, context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        OrderDetailsSectionView(
                          label: 'Details',
                          child: OrderDetailsDetailsSectionChild(order: order),
                        ),
                        OrderDetailsSectionView(
                          label:
                              'Items x ${order.orderItems.length.toString()}',
                          child: OrderDetailsItemsSectionChild(
                            order: order,
                          ),
                        ),
                        OrderDetailsSectionView(
                          label:
                              'General Notes x ${order.notes.length.toString()}',
                          child: const Text('Hello'),
                        ),
                        const SizedBox(height: 16),
                        OrderDetailsFinanceSection(order: order),
                      ],
                    ),
                  ),
                ),
                _addNewItemButton(context),
                const SizedBox(height: 56),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _addNewItemButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add New Item'),
            ),
          ),
        ),
      ],
    );
  }

  Row _header(Order order, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CategoriesAddButton(
              icon: Icons.close,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            Text(
              '#${order.orderNumber}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(Assets.callWaiter),
                ))
          ],
        ),
      ],
    );
  }
}
