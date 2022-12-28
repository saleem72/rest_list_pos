//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_list_pos/helpers/formmaters.dart';
import 'package:rest_list_pos/helpers/styling/assets.dart';
import 'package:rest_list_pos/helpers/styling/pallet.dart';
import 'package:rest_list_pos/models/app_order_view_model.dart';
import 'package:rest_list_pos/models/order_status.dart';
import 'package:rest_list_pos/screens/core/home_screen/orders_bloc/orders_bloc.dart';

import 'add_edit_order_butttons.dart';
import 'add_edit_order_finance.dart';
import 'add_edit_order_sloth.dart';
import 'add_edit_order_summary.dart';

class AddNewOrderView extends StatelessWidget {
  const AddNewOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: const [
        // Select Table
        AddEditOrderSummary(),
        Expanded(
          child: AddEditOrderBody(),
        ),
        // finance Section
        AddEditOrderFinance(),
        SizedBox(height: 8),
        AddEditOrderButttons(),
      ],
    );
  }

  Widget _scrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SizedBox(
                  height: double.maxFinite,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text('Dish name*',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                          Switch(
                            value: true,
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Enter dish name',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey.shade400,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text('Description**',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Enter dish name',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey.shade400,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class AddEditOrderBody extends StatelessWidget {
  const AddEditOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: double.infinity,
            child: (state.orderToEdit != null &&
                    state.orderToEdit!.orderItems.isNotEmpty)
                ? AddEditOrderItemsList(items: state.orderToEdit!.orderItems)
                : const AddEditOrderSloth(),
          ),
        );
      },
    );
  }
}

class AddEditOrderItemsList extends StatelessWidget {
  const AddEditOrderItemsList({
    super.key,
    required this.items,
  });
  final List<OrderItemViewModel> items;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return AddEditOrderItemTile(item: item);
      },
    );
  }
}

class AddEditOrderItemTile extends StatelessWidget {
  const AddEditOrderItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final OrderItemViewModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 100,
                  height: 70,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: item.isEditable ? Colors.green : Colors.grey,
                        width: 3),
                    image: DecorationImage(
                        image: Image.network(item.productImage).image),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(item.productName),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                              text: Formatters.currencyFormater
                                  .format(item.price)),
                          TextSpan(
                            text: ' X ${item.quantity} ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          TextSpan(text: item.productSize),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                context
                                    .read<OrdersBloc>()
                                    .add(OrdersBlocIncreaseAmount(item: item));
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Pallet.primary,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.quantity.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () => context
                                  .read<OrdersBloc>()
                                  .add(OrdersBlocDecreaseAmount(item: item)),
                              style: TextButton.styleFrom(
                                backgroundColor: Pallet.primary,
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Pallet.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
